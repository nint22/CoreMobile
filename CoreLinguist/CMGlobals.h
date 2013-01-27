/***************************************************************
 
 CoreMobile - A cross-platform GUI abstraction
 Copyright (c) 2013 'Core S2'. All rights reserved.
 
 This source file is developed and maintained by:
 + Jeremy Bridon jbridon@cores2.com
 
 File: oDataInterface.h/m
 Desc: System-wide settings and helper functions.
 
***************************************************************/

#import <Foundation/Foundation.h>
#import <stdint.h>

/*** C-Style Definitions ***/

// C-style position (as integer)
typedef struct __CMPosition {
    int32_t x, y;
} CMPosition;

// Initialize a CMPosition object
inline CMPosition CMPositionMake(int32_t x, int32_t y);
CMPosition CMPositionParse(NSString* string);

// C-style size (as integer)
typedef struct __CMSize {
    int32_t width, height;
} CMSize;

// Initialize a CMSize object
inline CMSize CMSizeMake(int32_t width, int32_t height);
CMSize CMSizeParse(NSString* string);

// C-style definition of pixel or percentage
typedef enum __CMAnchorOffsetType {
    CMAnchorOffsetType_Pixels,
    CMAnchorOffsetType_Percentage,
} CMAnchorOffsetType;

// C-style pixel or percentage offset
typedef struct __CMAnchorOffset {
    CMAnchorOffsetType Type;
    union {
        float Percentage;
        int32_t Pixels;
    } Data;
} CMAnchorOffset;

// Initialization of anchor offsets
inline CMAnchorOffset CMAnchorOffsetMakePixels(int32_t pixels);
inline CMAnchorOffset CMAnchorOffsetMakePercentage(float percentage);

// C-style bitmasks to represent the scaling behavior (streches width or height)
enum __CMResizeType {
    CMResizeType_None   = 0,
    CMResizeType_Wide   = 1 << 0,
    CMResizeType_Tall   = 1 << 1,
};
typedef uint8_t CMResizeType;

// Produce a bit-mask based on a given string of the form "Resize": "[[Tall][Wide]]"
CMResizeType CMResizeParse(NSString* string);

// C-style bitmasks to represent the anchor sizes (streches width or height)
enum __CMAnchorType {
    CMAnchorType_None   = 0,
    CMAnchorType_Right  = 1 << 0,
    CMAnchorType_Top    = 1 << 1,
    CMAnchorType_Left   = 1 << 2,
    CMAnchorType_Bottom = 1 << 3,
};
typedef uint8_t CMAnchorType;

// Produce a bit-mask based on a given string of the form "Anchor":"[Right:<#px,#%>][Top:<#px,#%>][Left:<#px,#%>][Bottom:<#px,#%>]"
CMAnchorType CMAnchorParse(NSString* string);

// Produce an anchor offset value for the given string and the associated right/top/left/bottom value
CMAnchorOffset CMAnchorOffsetParse(NSString* type, NSString* string);

// C-style layout definitions
typedef struct __CMLayout {
    
    // The layout anchor and resize behavior
    CMAnchorType Anchor;    // Note: This is a bitmask
    CMResizeType Resize;    // Note: This is a bitmask
    
    // Right, top, left, and bottom offsets (pixels or pecentages), if applicable
    CMAnchorOffset Right, Top, Left, Bottom;
} CMLayout;

// Initialization of the layout types
inline CMLayout CMLayoutMake(CMAnchorType anchor, CMResizeType resize);

/*** Obj-C Definitions ***/

// Create and return an error
inline NSError* NSErrorMake(NSString* ErrorMessage);

/*** Obj-C Keywords ***/

static const NSString* CMKeyword_JSONParent = @"Parent";
static const NSString* CMKeyword_JSONSize = @"Size";
static const NSString* CMKeyword_JSONPosition = @"Position";
static const NSString* CMKeyword_JSONLayout = @"Layout";
static const NSString* CMKeyword_JSONLayoutAnchor = @"Anchor";
static const NSString* CMKeyword_JSONLayoutResize = @"Resize";
static const NSString* CMKeyword_JSONLayoutAnchorRight = @"Right";
static const NSString* CMKeyword_JSONLayoutAnchorTop = @"Top";
static const NSString* CMKeyword_JSONLayoutAnchorLeft = @"Left";
static const NSString* CMKeyword_JSONLayoutAnchorBottom = @"Bottom";

