/***************************************************************
 
 CoreMobile - A cross-platform GUI abstraction
 Copyright (c) 2013 'Core S2'. All rights reserved.
 
***************************************************************/

#import "CMBaseView.h"

@implementation CMBaseView

/*** Public Functions ***/

-(id)initWithName:(NSString*)ViewName andProperties:(NSDictionary*)Properties andSubViews:(NSDictionary*)SubViews
{
    if(self = [super init])
    {
        // Do we have a defined position, size, or layout?
        NSString* Position = [Properties objectForKey:CMKeyword_JSONPosition];
        NSString* Size = [Properties objectForKey:CMKeyword_JSONSize];
        NSString* LayoutResize = [[Properties objectForKey:CMKeyword_JSONLayout] objectForKey:CMKeyword_JSONLayoutResize];
        NSString* LayoutAnchor = [[Properties objectForKey:CMKeyword_JSONLayout] objectForKey:CMKeyword_JSONLayoutAnchor];
        
        // Parse if valid
        if(Position != nil)
            ViewPosition = CMPositionParse(Position);
        if(Size != nil)
            ViewSize = CMSizeParse(Size);
        if(LayoutResize != nil)
            ViewLayout.Resize = CMResizeParse(Size);
        if(LayoutAnchor != nil)
        {
            ViewLayout.Anchor = CMAnchorParse(Size);
            if((ViewLayout.Anchor & CMAnchorType_Right) == CMAnchorType_Right)
                ViewLayout.Right = CMAnchorOffsetParse(CMKeyword_JSONLayoutAnchorRight, LayoutAnchor);
            if((ViewLayout.Anchor & CMAnchorType_Top) == CMAnchorType_Top)
                ViewLayout.Top = CMAnchorOffsetParse(CMKeyword_JSONLayoutAnchorTop, LayoutAnchor);
            if((ViewLayout.Anchor & CMAnchorType_Left) == CMAnchorType_Left)
                ViewLayout.Left = CMAnchorOffsetParse(CMKeyword_JSONLayoutAnchorLeft, LayoutAnchor);
            if((ViewLayout.Anchor & CMAnchorType_Bottom) == CMAnchorType_Bottom)
                ViewLayout.Bottom = CMAnchorOffsetParse(CMKeyword_JSONLayoutAnchorBottom, LayoutAnchor);
        }
        
        // Get parent object (view)
        UIView* ParentView = [self superview];
        
        // Translate the CoreMobile definitions into UIView properties
        [self setFrame:CGRectMake(ViewPosition.x, ViewPosition.y, ViewSize.width, ViewSize.height)];
        
        // We need to re-layout our view..
        // Todo: CMLayout ViewLayoutx
        
        UIViewAutoresizingNone                 = 0,
        UIViewAutoresizingFlexibleLeftMargin   = 1 << 0,
        UIViewAutoresizingFlexibleWidth        = 1 << 1,
        UIViewAutoresizingFlexibleRightMargin  = 1 << 2,
        UIViewAutoresizingFlexibleTopMargin    = 1 << 3,
        UIViewAutoresizingFlexibleHeight       = 1 << 4,
        UIViewAutoresizingFlexibleBottomMargin = 1 << 5
        [self setAutoresizingMask:<#(UIViewAutoresizing)#>]
    }
    return self;
}

-(CMBaseView*)GetSubView:(NSString*)SubViewName
{
    // Todo...
    return nil;
}

/*** Private Functions ***/



@end
