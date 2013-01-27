/***************************************************************
 
 CoreMobile - A cross-platform GUI abstraction
 Copyright (c) 2013 'Core S2'. All rights reserved.
 
 This source file is developed and maintained by:
 + Jeremy Bridon jbridon@cores2.com
 
 File: CMObject.h/m
 Desc: A parsed Json object.
 
 ***************************************************************/

#import <Foundation/Foundation.h>
#import "CMGlobals.h"

// All view types
static const int CMViewTypeCount = 20;
typedef enum __CMViewType
{
    CMViewType_BaseWindow,
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
static const NSString* CMViewNames[CMViewTypeCount] =
{
    @"BaseWindow",
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

@interface CMObject : NSObject

// Initialize the object with a given Json text-source object
-(id)init:(NSDictionary*)JsonObject;

@end
