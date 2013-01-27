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

@interface CMParser : NSObject
{
    // What is actually parsed
    NSDictionary* ParseDictionary;
}

// Standard constructor; generates a form / screen with the Json-defined
// layout. Also loads image files, etc.
-(id)init:(NSString*)JsonFile onError:(NSError**)ErrorOut;

// Access the root object
// All objects can be of a special CM-based type (such as CMImage, etc.)
-(NSDictionary*)GetParseDictionary;

@end
