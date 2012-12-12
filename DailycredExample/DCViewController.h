//
//  DCViewController.h
//  DailycredExample
//
//  Created by Hank Stoever on 12/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCClient.h"

@interface DCViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>{
    NSString *selectedProvider;
}
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

- (IBAction)signUpButtonTouched:(id)sender;

@end
