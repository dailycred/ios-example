//
//  DCUserViewController.m
//  DailycredExample
//
//  Created by Hank Stoever on 12/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DCUserViewController.h"
#import "DCClient.h"
#import "DCViewController.h"
#import "DCJsonViewController.h"

@implementation DCUserViewController
@synthesize avatar;
@synthesize displayLabel;
@synthesize emailLabel;
@synthesize dataField;
@synthesize pickerView;
@synthesize connectButton;

- (void)viewDidLoad
{
    [self updateForUser];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)connectButtonPressed:(id)sender {
    [[DCClient sharedClient] authorizeWithIdentityProvider:[self getSelectedProvider]];
}

- (IBAction)logoutButtonPressed:(id)sender {
    [DCClient logout];
    DCViewController *vc = [[DCViewController alloc] initWithNibName:@"DCViewController" bundle:nil];
    [[UIApplication sharedApplication].delegate window].rootViewController = vc;
    [[[UIApplication sharedApplication].delegate window] makeKeyAndVisible];
}

- (IBAction)jsonButtonPressed:(id)sender {
    DCJsonViewController *vc = [[DCJsonViewController alloc] initWithNibName:@"DCJsonViewController" bundle:nil];
    [[UIApplication sharedApplication].delegate window].rootViewController = vc;
    [[[UIApplication sharedApplication].delegate window] makeKeyAndVisible];
}

- (IBAction)chooseButtonPressed:(id)sender {
    [pickerView setHidden:NO];
}

-(void)updateForUser {
    user = [DCClient getCurrentUser];
    displayLabel.text = user.display;
    if (user.email != nil && user.email != user.display){
        emailLabel.hidden = NO;
        emailLabel.text = user.email;
    } else {
        emailLabel.hidden = YES;
    }
    dataField.text = [user.identities description];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: user.picture]];
    avatar.image = [UIImage imageWithData: imageData];
    [avatar setFrame:CGRectMake(0, 0, 150, 150)];
    avatar.hidden = NO;
    [self updatePickerButton];
}

-(void)updatePickerButton{
    [connectButton setTitle:[NSString stringWithFormat:@"Connect with %@",[self getSelectedProvider]] forState:UIControlStateNormal];
}

- (void)viewDidUnload {
    [self setAvatar:nil];
    [self setDisplayLabel:nil];
    [self setEmailLabel:nil];
    [self setDataField:nil];
    [self setPickerView:nil];
    [self setConnectButton:nil];
    [super viewDidUnload];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return [[DCClient sharedClient].identityProviders count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[[DCClient sharedClient].identityProviders objectAtIndex:row] capitalizedString];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    selectedProvider = [[[DCClient sharedClient].identityProviders objectAtIndex:row] capitalizedString];
    [self updatePickerButton];
    [pickerView setHidden:YES];
}
-(NSString *)getSelectedProvider{
    if (selectedProvider == nil){
        return [[[DCClient sharedClient].identityProviders objectAtIndex:0] capitalizedString];
    } else {
        return selectedProvider;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
