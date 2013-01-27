/***************************************************************
 
 CoreMobile - A cross-platform GUI abstraction
 Copyright (c) 2013 'Core S2'. All rights reserved.
 
***************************************************************/

#import "CMBaseView.h"

@implementation CMBaseView

/*** Public Functions ***/

-(id)initViewName:(NSString*)BaseName fromJSONFile:(NSString*)FileName
{
    if(self = [super init])
    {
        // Parse the given file name
        NSError* Error = nil;
        CMParser* Parser = [[CMParser alloc] init:FileName onError:&Error];
        NSDictionary* ParseDictionary = [Parser GetParseDictionary];
        
        // Simple initialization
        ObjectName = BaseName;
        ParentTypeName = [[ParseDictionary objectForKey:BaseName] objectForKey:CMKeyword_JSONParent];
        
        // Empty init
        ViewPosition = CMPositionMake(0, 0);
        ViewSize = CMSizeMake(0, 0);
        ViewLayout = CMLayoutMake(CMResizeType_None, CMResizeType_None);
        
        // Keep seeking down the parent's properties to copy over positions
        NSMutableArray* ParentObjects = [[NSMutableArray alloc] init];
        [ParentObjects addObject:[ParseDictionary objectForKey:ParentTypeName]];
        
        // Keep pushing on the stack (top is on the right) all parents-of-parents
        while(true)
        {
            NSString* ParentName = [[ParentObjects lastObject] objectForKey:CMKeyword_JSONParent];
            if(ParentName == nil)
                break;
            else
                [ParentObjects addObject:[ParseDictionary objectForKey:ParentName]];
        }
        
        // Parse from the top-most parent back to this child object
        while([ParentObjects count] > 0)
        {
            // Pop-off last object
            NSDictionary* ParentObject = [ParentObjects lastObject];
            [ParentObjects removeLastObject];
            
            // Do we have a defined position, size, or layout?
            NSString* Position = [ParentObject objectForKey:CMKeyword_JSONPosition];
            NSString* Size = [ParentObject objectForKey:CMKeyword_JSONSize];
            NSString* LayoutResize = [[ParentObject objectForKey:CMKeyword_JSONLayout] objectForKey:CMKeyword_JSONLayoutResize];
            NSString* LayoutAnchor = [[ParentObject objectForKey:CMKeyword_JSONLayout] objectForKey:CMKeyword_JSONLayoutAnchor];
            
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
        }
    }
    return self;
}

-(void)dealloc
{
    // Explicitly release all obj-c objects
    ObjectName = nil;
    ParentTypeName = nil;
}

/*** Private Functions ***/



@end
