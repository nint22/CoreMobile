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

// Base view implementation
@interface CMBaseView : UIView
{
    // Our active properties
    CMPosition ViewPosition;    // Defines our position, relative to our parent (in pixels or percentage)
    CMSize ViewSize;            // Defines our size, in pixels
    CMLayout ViewLayout;        // Defines our layout, which is a mix of scale-behavior and aanchor-offset
    
    // All sub-views
    NSArray* SubViews;
}

/*** Public Functions ***/

// Initialize a base view with ... todo ...
-(id)initWithName:(NSString*)ViewName andProperties:(NSDictionary*)Properties andSubViews:(NSDictionary*)SubViews;

// Access a sub-view by name; it is required you do so using the dot-delimited naming convention
-(CMBaseView*)GetSubView:(NSString*)SubViewName;

@end
