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
@property (strong, nonatomic) IBOutlet UISlider *testSlider;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;
- (IBAction)revealMenu:(id)sender;
@end
