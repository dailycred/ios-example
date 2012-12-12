//
//  DCJsonViewController.m
//  DailycredExample
//
//  Created by Hank Stoever on 12/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DCJsonViewController.h"
#import "DCClient.h"
#import "DCUserViewController.h"

@interface DCJsonViewController ()

@end

@implementation DCJsonViewController
@synthesize textView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [textView setText:[[DCClient getCurrentUser].json description]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)backButtonPressed:(id)sender {
    DCUserViewController *vc = [[DCUserViewController alloc] initWithNibName:@"DCUserViewController" bundle:nil];
    [[UIApplication sharedApplication].delegate window].rootViewController = vc;
    [[[UIApplication sharedApplication].delegate window] makeKeyAndVisible];
}
@end
