/***************************************************************
 
 CoreMobile - A cross-platform GUI abstraction
 Copyright (c) 2013 'Core S2'. All rights reserved.
 
***************************************************************/

#import "CMGlobals.h"

NSError* NSErrorMake(NSString* ErrorMessage)
{
    return [NSError errorWithDomain:@"world" code:200 userInfo:[NSDictionary dictionaryWithObject:ErrorMessage forKey:NSLocalizedDescriptionKey]];
}

CMPosition CMPositionMake(int32_t x, int32_t y)
{
    CMPosition Pos;
    Pos.x = x;
    Pos.y = y;
    return Pos;
}

CMPosition CMPositionParse(NSString* string)
{
    
}

CMSize CMSizeMake(int32_t width, int32_t height)
{
    CMSize Size;
    Size.width = width;
    Size.height = height;
    return Size;
}

CMSize CMSizeParse(NSString* string)
{
    
}

CMAnchorOffset CMAnchorOffsetMakePixels(int32_t pixels)
{
    CMAnchorOffset offset;
    offset.Type = CMAnchorOffsetType_Pixels;
    offset.Data.Pixels = pixels;
    return offset;
}

CMAnchorOffset CMAnchorOffsetMakePercentage(float percentage)
{
    CMAnchorOffset offset;
    offset.Type = CMAnchorOffsetType_Percentage;
    offset.Data.Percentage = percentage;
    return offset;
}

CMResizeType CMResizeParse(NSString* string)
{
    
}

CMAnchorType CMAnchorParse(NSString* string)
{
    
}

CMAnchorOffset CMAnchorOffsetParse(NSString* type, NSString* string)
{
    
}

CMLayout CMLayoutMake(CMAnchorType anchor, CMResizeType resize)
{
    CMLayout anch;
    anch.Anchor = anchor;
    anch.Resize = resize;
    return anch;
}
