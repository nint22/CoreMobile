/***************************************************************
 
 CoreMobile - A cross-platform GUI abstraction
 Copyright (c) 2013 'Core S2'. All rights reserved.
 
***************************************************************/

#import "CMGlobals.h"

NSError* NSErrorMake(const NSString* ErrorMessage)
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

CMPosition CMPositionParse(const NSString* string)
{
    NSString* Temp = [string stringByReplacingOccurrencesOfString:@"," withString:@" "];
    NSArray* Components = [Temp componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return CMPositionMake([[NSScanner scannerWithString:[Components objectAtIndex:0]] intValue], [[NSScanner scannerWithString:[Components objectAtIndex:1]] intValue]);
}

CMSize CMSizeMake(int32_t width, int32_t height)
{
    CMSize Size;
    Size.width = width;
    Size.height = height;
    return Size;
}

CMSize CMSizeParse(const NSString* string)
{
    // Same as position parse; simply change var names
    CMPosition Position = CMPositionParse(string);
    return CMSizeMake(Position.x, Position.y);
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

CMResizeType CMResizeParse(const NSString* string)
{
    // Simply look for the keywords of "wide" and "tall"
    CMResizeType Resize = CMResizeType_None;
    if([string rangeOfString:CMKeyword_JSONLayoutResizeWide options:NSCaseInsensitiveSearch].location != NSNotFound)
        Resize |= CMResizeType_Wide;
    if([string rangeOfString:CMKeyword_JSONLayoutResizeTall options:NSCaseInsensitiveSearch].location != NSNotFound)
        Resize |= CMResizeType_Tall;
    return Resize;
}

CMAnchorType CMAnchorParse(const NSString* string)
{
    // Simply look for the keywords of "right", "top", etc.
    CMAnchorType Anchor = CMAnchorType_None;
    if([string rangeOfString:CMKeyword_JSONLayoutAnchorRight options:NSCaseInsensitiveSearch].location != NSNotFound)
        Anchor |= CMAnchorType_Right;
    if([string rangeOfString:CMKeyword_JSONLayoutAnchorTop options:NSCaseInsensitiveSearch].location != NSNotFound)
        Anchor |= CMAnchorType_Top;
    if([string rangeOfString:CMKeyword_JSONLayoutAnchorLeft options:NSCaseInsensitiveSearch].location != NSNotFound)
        Anchor |= CMAnchorType_Left;
    if([string rangeOfString:CMKeyword_JSONLayoutAnchorBottom options:NSCaseInsensitiveSearch].location != NSNotFound)
        Anchor |= CMAnchorType_Bottom;
    return Anchor;
}

CMAnchorOffset CMAnchorOffsetParse(const NSString* type, const NSString* string)
{
    // Find the start and end of the target key
    // Todo: Error check
    NSRange Start = [string rangeOfString:[NSString stringWithFormat:@"%@:", type] options:NSCaseInsensitiveSearch];
    NSRange End = [string rangeOfCharacterFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] options:NSCaseInsensitiveSearch range:NSMakeRange(Start.location, [string length] - Start.location - 1)];
    
    // Substring it out
    NSString* substring = [string substringWithRange:NSMakeRange(Start.location, End.location - Start.location - 1)];
    
    // If percentage..
    if([substring rangeOfString:@"%" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        // Normalize
        return CMAnchorOffsetMakePercentage([[NSScanner scannerWithString:substring] floatValue] / 100.0f);
    }
    // Else, treat as integer
    else
    {
        // Simple integer
        return CMAnchorOffsetMakePixels([[NSScanner scannerWithString:substring] intValue]);
    }
}

CMLayout CMLayoutMake(CMAnchorType anchor, CMResizeType resize)
{
    CMLayout anch;
    anch.Anchor = anchor;
    anch.Resize = resize;
    return anch;
}
