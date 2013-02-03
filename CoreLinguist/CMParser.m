/***************************************************************
 
 CoreMobile - A cross-platform GUI abstraction
 Copyright (c) 2013 'Core S2'. All rights reserved.
 
***************************************************************/

#import "CMParser.h"
#import "CMGlobals.h"

// Internal private cache of all view controllers that have previous been loaded; the data structure is a
// dictionary where the key is the string "<view name>.<last edit date of given file, in seconds since epoch>"
// and the data is simply a pre-parsed CMParser object
static NSMutableDictionary* CMParser_CachedViews = nil;

@implementation CMParser

/*** Public Functions ***/

-(id)initWithJson:(NSString*)JsonFile withKeyName:(NSString*)KeyName onError:(NSError**)ErrorOut
{
    // Set error to nothing
    *ErrorOut = nil;
    
    // First, get date of last edit to the target file
    NSDictionary* FileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:JsonFile error:nil];
    uint64_t EpochToEditSeconds = (uint64_t)[[FileAttributes fileModificationDate] timeIntervalSince1970];
    
    // For the key for look-up
    NSString* CacheKey = [NSString stringWithFormat:@"%@.%@.%llu", JsonFile, KeyName, EpochToEditSeconds];
    
    // Allocate cache if needed
    if(CMParser_CachedViews == nil)
        CMParser_CachedViews = [[NSMutableDictionary alloc] init];
    
    // Has this been pre-processed?
    if([CMParser_CachedViews objectForKey:CacheKey])
    {
        self = [CMParser_CachedViews objectForKey:CacheKey];
    }
    
    // Else, create it!
    else if(self = [super init])
    {
        /*** Parse Source ***/
        
        // Load source file into string
        NSMutableString* Source = [NSMutableString stringWithContentsOfFile:JsonFile encoding:NSUTF8StringEncoding error:ErrorOut];
        
        // Strip all comments
        Source = [CMParser StripComments:Source];
        
        // Parse as JSON object
        id ParseResult = [NSJSONSerialization JSONObjectWithData:[Source dataUsingEncoding:NSUTF8StringEncoding] options:0 error:ErrorOut];
        if(*ErrorOut != nil)
            return nil;
        
        // The result should always be a dictionary.
        if(![ParseResult isKindOfClass:[NSDictionary class]])
        {
            *ErrorOut = NSErrorMake(@"The given JSON file is not a dictionary data structure");
            return nil;
        }
        
        // Do we have the target view as a root-key?
        if([ParseResult objectForKey:KeyName] == nil)
        {
            *ErrorOut = NSErrorMake(@"The given KeyName was not found in the given script");
            return nil;
        }
        
        // Convert into an editable dictionary, since we need to add the imports
        NSMutableDictionary* ExpandedParseResult = [[NSMutableDictionary alloc] init];
        [ExpandedParseResult setObject:[ParseResult objectForKey:KeyName] forKey:KeyName];
        
        /*** Parse Imports ***/
        
        // What files are we to import?
        NSArray* ImportsList = [ExpandedParseResult valueForKey:CMKeyword_JSONImports];
        if(ImportsList != nil)
        {
            // For each file-name (must be in same directory)
            for(NSString* ImportFileName in ImportsList)
            {
                // What is the correct file location?
                NSString* FilePath = [NSString stringWithFormat:@"%@/%@", [JsonFile stringByDeletingLastPathComponent], ImportFileName];
                
                // Strip all comments
                NSMutableString* Source = [NSMutableString stringWithContentsOfFile:FilePath encoding:NSUTF8StringEncoding error:ErrorOut];
                Source = [CMParser StripComments:Source];
                
                // Parse as JSON object
                id ParseResult = [NSJSONSerialization JSONObjectWithData:[Source dataUsingEncoding:NSUTF8StringEncoding] options:0 error:ErrorOut];
                if(*ErrorOut != nil)
                    return nil;
                
                // The result should always be a dictionary.
                if(![ParseResult isKindOfClass:[NSDictionary class]])
                {
                    *ErrorOut = NSErrorMake(@"The given JSON file is not a dictionary data structure");
                    return nil;
                }
                
                // Any sort of globally-included file is not allowed to have imports...
                if([ParseResult objectForKey:CMKeyword_JSONImports] != nil)
                {
                    *ErrorOut = NSErrorMake(@"An important script may not have its own import");
                    return nil;
                }
                
                // Add all new key-values into the finalized dictionary
                for(NSString* Key in [ParseResult allKeys])
                {
                    // Is there any conflict?
                    if([ExpandedParseResult objectForKey:Key] != nil)
                    {
                        *ErrorOut = NSErrorMake(@"During script inclusion, a duplicate global key was found!");
                        return nil;
                    }
                    
                    // Save
                    [ExpandedParseResult setObject:[ParseResult objectForKey:Key] forKey:[NSString stringWithFormat:@"Globals.%@", Key]];
                }
            }
        }
        
        /*** Build Object-Hierarchy ***/
        
        // Generate an object-tree for the given json file
        RootObject = [[CMObject alloc] initWithJsonKeyValues:(NSDictionary*)ExpandedParseResult onError:ErrorOut];
        if(*ErrorOut != nil)
            return nil;
        
        // Save parsed object!
        [CMParser_CachedViews setObject:self forKey:CacheKey];
    }
    
    // Done!
    return self;
}

-(CMBaseView*)GenerateViews
{
    // We've built our scene in text and dictionaries, so let's now
    // start creating the actual UIView objects that derive from this all
    
    // Todo...
    UIView* RootView = [[UIView alloc] initWithFrame:];
    
    return nil;
}

/*** Private Functions ***/

// Return a comment-stripped source string; returns nil on error
+(NSMutableString*)StripComments:(NSMutableString*)Source
{
    // Replace all double-slash comments
    while(true)
    {
        // Active source length
        NSUInteger SourceLength = [Source length];
        
        // Is there a comment to replace?
        NSRange CommentRange = [Source rangeOfString:@"//"];
        if(CommentRange.location == NSNotFound)
            break;
        
        // Yes, there is! Let's find the associated end-of-line
        NSRange EndRange = [Source rangeOfString:@"\n" options:NSCaseInsensitiveSearch range:NSMakeRange(CommentRange.location, SourceLength - CommentRange.location - 1)];
        
        // If not found, then we are at the end of file (thus no new-lines)
        if(EndRange.location == NSNotFound)
            EndRange.location = SourceLength - 1;
        
        // Remove from comment start to end range
        [Source replaceCharactersInRange:NSMakeRange(CommentRange.location, EndRange.location - CommentRange.location + 1) withString:@""];
    }
    
    // Strip multi-line comments
    while(true)
    {
        // Opening
        NSRange OpenRange = [Source rangeOfString:@"/*"];
        if(OpenRange.location == NSNotFound)
            break;
        
        // Closing
        NSRange ClosedRange = [Source rangeOfString:@"*/"];
        if(ClosedRange.location == NSNotFound)
            return nil;
        
        // Replace with empty string
        [Source replaceCharactersInRange:NSMakeRange(OpenRange.location, ClosedRange.location - OpenRange.location + 2) withString:@""];
    }
    
    // Done parsed!
    return Source;
}

+(CMParser*)ReloadFromCache:(NSString*)JsonFile
{
    // If cache is nil, return nil
    if(CMParser_CachedParsed == nil)
        return nil;
    else
        return [CMParser_CachedParsed objectForKey:JsonFile];
}

@end
