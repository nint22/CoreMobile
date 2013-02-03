/***************************************************************
 
 CoreMobile - A cross-platform GUI abstraction
 Copyright (c) 2013 'Core S2'. All rights reserved.
 
 ***************************************************************/

#import "CMObject.h"

@implementation CMObject

-(id)initWithKeyName:(NSString*)KeyName withJsonDict:(NSDictionary*)JsonValues onError:(NSError**)ErrorOut
{
    // Initialize
    if(self = [super init])
    {
        /*** Default Initialization ***/
        
        // Empty error
        *ErrorOut = nil;
        
        // Get root-view controller
        NSDictionary* RootView = [JsonValues objectForKey:KeyName];
        
        // Initialize with the given key-name and parent name
        ObjectName = [NSString stringWithString:KeyName];
        BaseType = CMViewType_BaseView; // Assume base-view for now
        
        // Initialize the internal properties and sub-views list
        Properties = [[NSMutableDictionary alloc] init];
        SubViews = [[NSMutableDictionary alloc] init];
        
        /*** Get Parent Properties ***/
        
        // Keep seeking down the parent's properties (*not* names) to use when popping the parent stack
        NSMutableArray* ParentObjects = [[NSMutableArray alloc] initWithObjects:RootView, nil];
        NSString* LastParent = [RootView objectForKey:CMKeyword_JSONParent];
        
        // Go up the parent tree (i.e. if "MyView" comes from "RootView" which comes from "BaseView", etc.)
        while(true)
        {
            // Is the last parent name is a base-type?
            for(int i = 0; i < CMViewTypeCount; i++)
            {
                if([LastParent compare:CMViewNames[i] options:NSCaseInsensitiveSearch] == 0)
                {
                    BaseType = (CMViewType)i;
                    break;
                }
            }
            
            // This parent isn't a base-type, so search the global's include
            NSDictionary* ParentProperties = [JsonValues objectForKey:[NSString stringWithFormat:@"Globals.%@", LastParent]];
            
            // Nothing left!
            if(ParentProperties == nil)
                break;
            
            // We need to traverse deeper to get this parent's properties as well
            [ParentObjects addObject:ParentProperties];
            LastParent = [ParentProperties objectForKey:CMKeyword_JSONParent];
        }
        
        // Parse from the top-most parent back to this child object
        while([ParentObjects count] > 0)
        {
            // Pop-off last object
            NSDictionary* ParentObject = [ParentObjects lastObject];
            [ParentObjects removeLastObject];
            
            // Over-write any properties and sub-views if it is the youngest
            for(NSString* Key in [ParentObject allKeys])
            {
                // If string object, it's a property
                if([[ParentObject objectForKey:Key] isKindOfClass:[NSString class]])
                {
                    [Properties setObject:[ParentObject objectForKey:Key] forKey:Key];
                }
                // Else, if it's a dictionary, then it's a new sub-view
                else if([[ParentObject objectForKey:Key] isKindOfClass:[NSDictionary class]])
                {
                    // Todo: has to be a CMObject parse
                    CMObject* SubView = [[CMObject alloc] initWithKeyName:Key withJsonDict:[RootView objectForKey:Key] onError:ErrorOut];
                    [SubViews setObject:SubView forKey:Key];
                }
            }
        }
    }
    
    return self;
}

-(NSDictionary*)GetProperties
{
    return Properties;
}

-(NSDictionary*)GetSubViews
{
    return SubViews;
}

@end
