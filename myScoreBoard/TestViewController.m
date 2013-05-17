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
    self.testSlider.maximumValue = 100;
    self.testSlider.minimumValue = 0;
    self.testSlider.value = 20;
    self.textField.delegate = self;
    
    [self.menuButton setImage:[UIImage imageNamed:@"icon-navbar"]];
    
    [self.menuButton setBackgroundImage:[[UIImage alloc] init] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    // Navigation bar shadow
    self.navBar.shadowImage = [UIImage imageNamed:@"navbar-shadow"];
    
//    NSArray *array = [[NSArray alloc]initWithObjects:@"asdsadsa",@"dsasddsa", nil];
//    NSArray *array2 = [NSArray arrayWithObjects:@"asddsadsa",@"dsfdssd",@"dfdfsdf", nil];
    
    
//    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"menu_umsatz"]];
//    navItem.titleView = imgView;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg"]];
    
}

- (void)textFieldDidEndEditing:(UITextField *)aTextField {
    

    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)aTextField{
    NSString *textFieldtext = aTextField.text;
    int value = [textFieldtext intValue];
    self.testSlider.value = value;
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

- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
