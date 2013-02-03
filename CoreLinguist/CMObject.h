/***************************************************************
 
 CoreMobile - A cross-platform GUI abstraction
 Copyright (c) 2013 'Core S2'. All rights reserved.
 
 This source file is developed and maintained by:
 + Jeremy Bridon jbridon@cores2.com
 
 File: CMObject.h/m
 Desc: A parsed Json object. Though it does map directly to a
 CMBaseView (and all derived classes), it is not internally
 parsed to the equivalent data-types. Almost all internals of
 a CMObject is either a string or a dictionary of dictionaries / strings.
 
***************************************************************/

#import <Foundation/Foundation.h>
#import "CMGlobals.h"

// All view types
static const int CMViewTypeCount = 19;
typedef enum __CMViewType
{
    CMViewType_BaseView,
    CMViewType_LabelView,
    CMViewType_ButtonView,
    CMViewType_SegmentedButtonView,
    CMViewType_TextFieldView,
    CMViewType_SliderView,
    CMViewType_SwitchView,
    CMViewType_ProgressView,
    CMViewType_PageView,
    CMViewType_StepperView,
    CMViewType_TableView,
    CMViewType_ImageView,
    CMViewType_TextBlockView,
    CMViewType_WebView,
    CMViewType_MapView,
    CMViewType_ScrollView,
    CMViewType_DateView,
    CMViewType_PickerView,
    CMViewType_BarView,
} CMViewType;
static const NSString* const CMViewNames[CMViewTypeCount] =
{
    @"BaseView",
    @"LabelView",
    @"ButtonView",
    @"SegmentedButtonView",
    @"TextFieldView",
    @"SliderView",
    @"SwitchView",
    @"ProgressView",
    @"PageView",
    @"StepperView",
    @"TableView",
    @"ImageView",
    @"TextBlockView",
    @"WebView",
    @"MapView",
    @"ScrollView",
    @"DateView",
    @"PickerView",
    @"BarView",
};

// Object implementation
@interface CMObject : NSObject
{
    // Name of this object
    NSString* ObjectName;
    
    // Parent type of object (i.e. the base type that it derives from)
    CMViewType BaseType;
    
    // Properties (local properties will overwrite parent properties)
    NSMutableDictionary* Properties;
    
    // Sub-views (views owned by this object)
    NSMutableDictionary* SubViews;
}

// Initialize the object with a given Json-parsed source
// A tree of objects are built, representing the given view
-(id)initWithKeyName:(NSString*)KeyName withJsonDict:(NSDictionary*)JsonValues onError:(NSError**)ErrorOut;

// Get a reference (not copy) of all properties
-(NSDictionary*)GetProperties;

// Get a reference (not copy) of all sub-views
-(NSDictionary*)GetSubViews;

@end
