//
//  MatchNC.m
//  myScoreBoard
//
//  Created by Jannes on May/29/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "MatchNController.h"
#import "MenuVController.h"

@interface MatchNController ()

@end

@implementation MatchNController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Shadow
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    // Navigation bar shadow
    self.navigationBar.shadowImage = [UIImage imageNamed:@"navbar-shadow"];
    
    // Create left menu if it doesn't exist yet
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuVController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftMenu"];
    }
    
    // Add gesture recognizer
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    // Set reveal amount
    [self.slidingViewController setAnchorRightRevealAmount:276];
}

@end
