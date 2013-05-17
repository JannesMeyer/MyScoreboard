//
//  TestViewController.h
//  MenuTut
//
//  Created by Jannes Meyer on 26.04.13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"

@interface MatchViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *matchLabel;
@property (weak, nonatomic) IBOutlet UISlider *testSlider;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;

@property (strong, nonatomic) NSString* matchName;

- (IBAction)revealMenu:(id)sender;

@end
