/***************************************************************
 
 CoreMobile - A cross-platform GUI abstraction
 Copyright (c) 2013 'Core S2'. All rights reserved.
 
 This source file is developed and maintained by:
 + Jeremy Bridon jbridon@cores2.com
 
 File: CMViewController.h/m
 Desc: A base class that represents a rendered scene (i.e. screen)
 based on either a derives class or generated from a json file.
 
***************************************************************/

#import <UIKit/UIKit.h>
#import "CMParser.h"

@interface CMViewController : UIViewController

// Initialization with a given JSON file name
-(id)initWithJson:(NSString*)JsonFile withKeyName:(NSString*)KeyName onError:(NSError**)ErrorOut;

// Get any given view and view property using the dot-notation
-(id)GetView:(NSString*)KeyName;

@end
