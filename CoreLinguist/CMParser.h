/***************************************************************
 
 CoreMobile - A cross-platform GUI abstraction
 Copyright (c) 2013 'Core S2'. All rights reserved.
 
 This source file is developed and maintained by:
 + Jeremy Bridon jbridon@cores2.com
 
 File: CMParser.h/m
 Desc: Parse a JSON file but with special rules: mainly before
 passing the source file to the Apple JSON parser, we remove all
 comments. Comments are in the C / Javascript style of single-line
 double-slash comments "//" and the multi-line slash-star comment.
 
***************************************************************/

#import <Foundation/Foundation.h>
#import "CMBaseView.h"
#import "CMObject.h"

@interface CMParser : NSObject
{
    // Our root parse object (which points to a parsed tree of objects)
    CMObject* RootObject;
}

// Given a json file name (absolute file name) and the view key's name, attempt to parse
// and load the views' data, without explicitly generating any overhead data (i.e. parse into the strict types)
-(id)initWithJson:(NSString*)JsonFile withKeyName:(NSString*)KeyName onError:(NSError**)ErrorOut;

// Generate the root object view that was the target to parse in the given json file and given key-name
-(CMBaseView*)GenerateViews;

@end
