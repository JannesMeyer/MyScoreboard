//
//  InitialSlidingViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/25/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import "InitialSlidingViewController.h"
#import "ScoreAPI.h"

@implementation InitialSlidingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIStoryboard* storyboard;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        storyboard = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    }

    self.topViewController = [storyboard instantiateViewControllerWithIdentifier:@"Test"];
    
//    ECSlidingViewController* slidingViewController = (ECSlidingViewController *)self.window.rootViewController;
//    slidingViewController.topViewController = [storyboard instantiateViewControllerWithIdentifier:@"Test"];

    // Navbar background image
    UIImage *navBackgroundImage = [UIImage imageNamed:@"navbar"];
    [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];

    // Test score API
    ScoreAPI* api = [[ScoreAPI alloc] init];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
  return YES;
}

@end
