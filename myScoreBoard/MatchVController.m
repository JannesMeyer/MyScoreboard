//
//  MatchViewController.m
//  myScoreBoard
//
//  Created by Jannes Meyer on 26.04.13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "MatchVController.h"

#import "MenuVController.h" // required for self.slidingViewController
#import "MatchTVController.h"
#import "SettingsTVController.h"

@interface MatchVController()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@end

@implementation MatchVController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Background image
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg"]];
    
    // Navigation bar
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar"] forBarMetrics:UIBarMetricsDefault];
    
    [self.menuButton setImage:[UIImage imageNamed:@"icon-navbar"]];
    [self.menuButton setBackgroundImage:[[UIImage alloc] init] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [self.settingsButton setImage:[UIImage imageNamed:@"teams"]];
    [self.settingsButton setBackgroundImage:[[UIImage alloc] init] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

- (IBAction)revealMenu:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Show settings"]) {
        // Show settings
        UINavigationController* navigationController = (UINavigationController*)segue.destinationViewController;
        SettingsTVController* settings = (SettingsTVController*)navigationController.topViewController;
        settings.teams = @[self.match.team1, self.match.team2];
    } else if ([segue.identifier isEqualToString:@"Embed MatchTableViewController"]) {
        // Embed TableViewController
        MatchTVController* matchTableView = (MatchTVController*)segue.destinationViewController;
        matchTableView.match = self.match; // could be nil
    }
}

// Unwind segue from settings
- (IBAction)exitTeamSelection:(UIStoryboardSegue*)segue {
    NSLog(@"Back in Match View");
}

#pragma mark - Twitter posting

- (IBAction)writeComment {
    static BOOL animated = YES;
    
	//  Create an instance of the Tweet Sheet
	SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType: SLServiceTypeTwitter];
	tweetSheet.completionHandler = ^(SLComposeViewControllerResult result) {
        // Any UI changes need to happen on the main queue
        dispatch_async(dispatch_get_main_queue(), ^{
            // Hide tweet sheet
            [self dismissViewControllerAnimated:animated completion:NULL];
            // Tweet sent
            if (result == SLComposeViewControllerResultDone) {
                // TODO: Refresh data
            }
        });
	};
    
    // Set the initial text to contain the appropriate hashtags
    // TODO: both teams
    [tweetSheet setInitialText:[self.match.team1 hashtagsAsString]];
	
    // Presents the tweet sheet to the user
    [self presentViewController:tweetSheet animated:animated completion:NULL];
}

@end
