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

/*!
 * The only purpose of this NavigationController is to give us a NavigationBar.
 * However, we don't really make use of the navigation part of it (i.e. push segues).
 * Nevertheless it's more future-proof to do it this way.
 */
@implementation MatchNController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Navigation bar shadow
    self.navigationBar.shadowImage = [UIImage imageNamed:@"navbar-shadow"];
    
    // Shadow over the sliding menu
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    // Create the left sliding menu if it doesn't exist yet
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuVController class]]) {
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftMenu"];
    }
    
    // Add a pan gesture recognizer
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    // Set reveal amount
    [self.slidingViewController setAnchorRightRevealAmount:276];
}

@end
