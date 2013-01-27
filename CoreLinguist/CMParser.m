/***************************************************************
 
 CoreMobile - A cross-platform GUI abstraction
 Copyright (c) 2013 'Core S2'. All rights reserved.
 
***************************************************************/

#import "CMParser.h"
#import "CMGlobals.h"

// Internal private cache of all Json files; the data structure is a
// dictionary where the key is the string "<JSON file address>.<last edit date of given file, in seconds since epoch>"
// and the data is simply a pre-parsed CMParser object
static NSMutableDictionary* CMParser_CachedParsed = nil;

@implementation CMParser

/*** Public Functions ***/

-(id)init:(NSString*)JsonFile onError:(NSError**)ErrorOut
{
    // Set error to nothing
    *ErrorOut = nil;
    
    // First, get date of last edit to the target file
    NSDictionary* FileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:JsonFile error:nil];
    uint64_t EpochToEditSeconds = (uint64_t)[[FileAttributes fileModificationDate] timeIntervalSince1970];
    
    // For the key for look-up
    NSString* CacheKey = [NSString stringWithFormat:@"%@.%llu", JsonFile, EpochToEditSeconds];
    
    // Allocate dictionary if needed
    if(CMParser_CachedParsed == nil)
        CMParser_CachedParsed = [[NSMutableDictionary alloc] init];
    
    // Has this been pre-processed?
    if([CMParser_CachedParsed objectForKey:CacheKey])
    {
        self = [CMParser_CachedParsed objectForKey:CacheKey];
    }
    
    // Else, create it!
    else if(self = [super init])
    {
        // Load source file into string
        NSMutableString* Source = [NSMutableString stringWithContentsOfFile:JsonFile encoding:NSUTF8StringEncoding error:ErrorOut];
        
        // Replace all double-slash comments
        while(true)
        {
            // Is there a comment to replace?
            NSRange CommentRange = [Source rangeOfString:@"//"];
            if(CommentRange.location == NSNotFound)
                break;
            
            // Yes, there is! Let's find the associated end-of-line
            NSRange EndRange = [Source rangeOfString:@"\n" options:NSCaseInsensitiveSearch range:CommentRange];
            
            // If not found, then we are at the end of file (thus no new-lines)
            if(EndRange.location == NSNotFound)
                EndRange.location = [Source length] - 1;
            
            // Remove from comment start to end range
            [Source replaceCharactersInRange:NSMakeRange(CommentRange.location, CommentRange.location - EndRange.location) withString:@""];
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
            {
                // An open comment must be closed; thus this is a critical error
                *ErrorOut = NSErrorMake(@"");
                return self;
            }
            
            // Replace with empty string
            [Source replaceCharactersInRange:NSMakeRange(OpenRange.location, ClosedRange.location - OpenRange.location + 2) withString:@""];
        }
        
        // Parse as JSON object
        id ParseResult = [NSJSONSerialization JSONObjectWithData:[Source dataUsingEncoding:NSUTF8StringEncoding] options:0 error:ErrorOut];
        if(*ErrorOut != nil)
            return self;
        
        // The result should always be a dictionary.
        if(![ParseResult isSubclassOfClass:[NSDictionary class]])
        {
            *ErrorOut = NSErrorMake(@"The given JSON file is not a dictionary data structure");
            return self;
        }
        
        // Retain this dictionary
        ParseDictionary = (NSDictionary*)ParseResult;
        
        // Save parsed object!
        [CMParser_CachedParsed setObject:self forKey:CacheKey];
    }
    
    // Done!
    return self;
}

-(NSDictionary*)GetParseDictionary
{
    return ParseDictionary;
}

/*** Private Functions ***/

+(CMParser*)ReloadFromCache:(NSString*)JsonFile
{
    // Initialize a static lib
}

@end
