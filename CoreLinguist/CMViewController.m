/***************************************************************
 
 CoreMobile - A cross-platform GUI abstraction
 Copyright (c) 2013 'Core S2'. All rights reserved.
 
***************************************************************/

#import "CMViewController.h"

@implementation CMViewController

-(id)initWithJson:(NSString*)JsonFile withKeyName:(NSString*)KeyName onError:(NSError**)ErrorOut
{
    // Initialize as an empty json file
    self = [super init];
    if (self)
    {
        // Default error to nil
        *ErrorOut = nil;
        
        // Attempt to parse the JSON file
        CMParser* Parser = [[CMParser alloc] initWithJson:JsonFile withKeyName:KeyName onError:ErrorOut];
        if(*ErrorOut != nil)
            return nil;
        
        // With the parse result, generate all views, and add it to our root
        CMBaseView* RootView = [Parser GenerateViews];
        [[self view] addSubview:RootView];
        
        // Done!
    }
    return self;
}

/*** UIViewController Overloads ***/

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*** Public Functions ***/

-(id)GetView:(NSString*)KeyName
{
    // Todo...
    return nil;
}

@end
