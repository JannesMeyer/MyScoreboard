//
//  TestViewController.m
//  MenuTut
//
//  Created by Artur Malek on 26.04.13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController
@synthesize testSlider,textField,navBar,menuButton,navItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    testSlider.maximumValue = 100;
    testSlider.minimumValue = 0;
    testSlider.value = 20;
    textField.delegate = self;
    
    NSArray *array = [[NSArray alloc]initWithObjects:@"asdsadsa",@"dsasddsa", nil];
    
    
    NSArray *array2 = [NSArray arrayWithObjects:@"asddsadsa",@"dsfdssd",@"dfdfsdf", nil];
    
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"menu_umsatz"]];
    navItem.titleView = imgView;
    
}

- (void)textFieldDidEndEditing:(UITextField *)aTextField {
    

    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)aTextField{
    NSString *textFieldtext = aTextField.text;
    int value = [textFieldtext intValue];
    testSlider.value = value;
    [aTextField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

@end
