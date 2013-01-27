/***************************************************************
 
 CoreMobile - A cross-platform GUI abstraction
 Copyright (c) 2013 'Core S2'. All rights reserved.
 
 This source file is developed and maintained by:
 + Jeremy Bridon jbridon@cores2.com
 
 File: CMBaseView.h/m
 Desc: The base class of all CoreMobile views.
 
***************************************************************/

#import <Foundation/Foundation.h>
#import "CMGlobals.h"
#import "CMParser.h"

/*** BaseView Delegate ***/

// Handles all events that could be recieved to the code base
// ... todo ...

/*** BaseView Class ***/

@interface CMBaseView : NSObject
{
    // Name of this object
    NSString* ObjectName;
    
    // Parent name of object (i.e. what it derives from)
    NSString* ParentTypeName;
    
    // Position and size, in pixels
    CMPosition ViewPosition;
    CMSize ViewSize;
    
    // Layout behavior; if a layout (anchor) is defined, then position is ignored
    CMLayout ViewLayout;
}

/*** Public Functions ***/

// Initialize a base view with ... todo ...
-(id)initViewName:(NSString*)BaseName fromJSONFile:(NSString*)FileName;

@end
