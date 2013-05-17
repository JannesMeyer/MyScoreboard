//
//  TestViewController.h
//  MenuTut
//
//  Created by Artur Malek on 26.04.13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface TestViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UISlider *testSlider;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
- (IBAction)revealMenu:(id)sender;
@end
