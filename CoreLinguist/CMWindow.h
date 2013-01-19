/***************************************************************
 
 CoreMobile - A cross-platform GUI abstraction
 Copyright (c) 2013 'Core S2'. All rights reserved.
 
 This source file is developed and maintained by:
 + Jeremy Bridon jbridon@cores2.com
 
 File: CMWindow.h/m
 Desc: The base controller that contains a stack of views; only
 the top-most view is visible to the user, though modals can be
 rendered temporarily ontop with the second-to-top still visible.
 
***************************************************************/

#import <Foundation/Foundation.h>

@interface CMWindow : NSObject

@end
