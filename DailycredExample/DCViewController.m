//
//  DCViewController.m
//  DailycredExample
//
//  Created by Hank Stoever on 12/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DCViewController.h"

@interface DCViewController ()

@end

@implementation DCViewController
@synthesize signUpButton;
@synthesize displayText;
@synthesize avatar;

- (void)viewDidLoad
{
    [self updateForUser];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setSignUpButton:nil];
    [self setDisplayText:nil];
    [self setAvatar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)signUpButtonTouched:(id)sender {
    NSLog(@"button touched!");
    if ([signUpButton titleLabel].text == @"logout"){
        [DCClient logout];
        [self updateForUser];
    } else {
        [[DCClient getClient] authorize];
    }
    
}

-(void)updateForUser {
    DCUser *user = [DCClient getCurrentUser];
    if ([DCClient getCurrentUser] != nil){
        
        displayText.text = [NSString stringWithFormat:@"Hello %@",user.display];
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: user.picture]];
        avatar.image = [UIImage imageWithData: imageData];
        [avatar setFrame:CGRectMake(0, 0, 50, 50)];
        avatar.hidden = NO;
        NSString *title = @"logout";
        [signUpButton setTitle: title forState: UIControlStateNormal];
        [signUpButton setTitle: title forState: UIControlStateApplication];
        [signUpButton setTitle: title forState: UIControlStateHighlighted];
        [signUpButton setTitle: title forState: UIControlStateReserved];
        [signUpButton setTitle: title forState: UIControlStateSelected];
        [signUpButton setTitle: title forState: UIControlStateDisabled];
    } else {
        avatar.hidden = YES;
        NSString *title = @"Sign Up";
        [signUpButton setTitle: title forState: UIControlStateNormal];
        [signUpButton setTitle: title forState: UIControlStateApplication];
        [signUpButton setTitle: title forState: UIControlStateHighlighted];
        [signUpButton setTitle: title forState: UIControlStateReserved];
        [signUpButton setTitle: title forState: UIControlStateSelected];
        [signUpButton setTitle: title forState: UIControlStateDisabled];
        displayText.text = @"Hello Person";
    }
}
@end
