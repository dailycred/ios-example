//
//  DCUserViewController.h
//  DailycredExample
//
//  Created by Hank Stoever on 12/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCUser.h"

@interface DCUserViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource> {
    NSString *selectedProvider;
    DCUser *user;
}

@property (strong, nonatomic) IBOutlet UIImageView *avatar;
@property (strong, nonatomic) IBOutlet UILabel *displayLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UITextField *dataField;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UIButton *connectButton;

- (IBAction)connectButtonPressed:(id)sender;

- (IBAction)logoutButtonPressed:(id)sender;
- (IBAction)jsonButtonPressed:(id)sender;
- (IBAction)chooseButtonPressed:(id)sender;

-(void)updateForUser;
@end
