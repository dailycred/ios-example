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
@synthesize pickerView;

- (void)viewDidLoad
{
    [signUpButton setTitle:[NSString stringWithFormat:@"Sign Up with %@", [self getSelectedProvider]] forState:UIControlStateNormal];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setSignUpButton:nil];
    [self setPickerView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (IBAction)signUpButtonTouched:(id)sender {
    [[DCClient sharedClient] authorizeWithIdentityProvider:[self getSelectedProvider]];
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
    [signUpButton setTitle:[NSString stringWithFormat:@"Sign Up with %@", [self getSelectedProvider]] forState:UIControlStateNormal];
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
