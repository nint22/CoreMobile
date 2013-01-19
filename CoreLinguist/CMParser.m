/***************************************************************
 
 CoreMobile - A cross-platform GUI abstraction
 Copyright (c) 2013 'Core S2'. All rights reserved.
 
***************************************************************/

#import "CMParser.h"

@implementation CMParser

-(id)init:(NSString*)JsonFile onError:(NSError**)ErrorOut
{
    if(self = [super init])
    {
        // Set error to nothing
        *ErrorOut = nil;
        
        // Load file into string
        NSMutableString* Source = [NSString stringWithContentsOfFile:JsonFile encoding:NSUTF8StringEncoding error:ErrorOut];
        
        // Replace all double-slash comments
        
        // Open this file and strip all comments to their line-endings
        
        // Parse as JSON object
    }
    return self;
}

-(NSDictionary*)GetForm
{
    return nil;
}

@end
