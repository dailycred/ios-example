//
//  DCViewController.h
//  DailycredExample
//
//  Created by Hank Stoever on 12/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCClient.h"

@interface DCViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;
@property (strong, nonatomic) IBOutlet UILabel *displayText;
@property (strong, nonatomic) IBOutlet UIImageView *avatar;

- (IBAction)signUpButtonTouched:(id)sender;
-(void)updateForUser;

@end
