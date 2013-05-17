//
//  InitialSlidingViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/25/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import "InitialSlidingViewController.h"

@implementation InitialSlidingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIStoryboard* storyboard;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        storyboard = [UIStoryboard storyboardWithName:@"iPhone" bundle:nil];
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        storyboard = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    }

    self.topViewController = [storyboard instantiateViewControllerWithIdentifier:@"Match"];
    
//    ECSlidingViewController* slidingViewController = (ECSlidingViewController *)self.window.rootViewController;
//    slidingViewController.topViewController = [storyboard instantiateViewControllerWithIdentifier:@"Test"];

    // Navbar background image
    UIImage *navBackgroundImage = [UIImage imageNamed:@"navbar"];
    [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
  return YES;
}

@end
