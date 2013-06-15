//
//  MatchViewController.m
//  myScoreBoard
//
//  Created by Jannes on 26.04.13.
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

// Lazy instantiation
- (NSArray*)selectedTeams {
    if (!_selectedTeams) _selectedTeams = (self.match != nil) ? @[self.match.team1, self.match.team2] : @[];
    return _selectedTeams;
}

// Show menu
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
        settings.selectedTeams = [self.selectedTeams mutableCopy];
    } else if ([segue.identifier isEqualToString:@"Embed MatchTableViewController"]) {
        // Embed TableViewController
        MatchTVController* matchTableView = (MatchTVController*)segue.destinationViewController;
        matchTableView.match = self.match; // could be nil
        matchTableView.selectedTeams = self.selectedTeams; // could be nil
    }
}

// Unwind segue from settings
- (IBAction)exitTeamSelection:(UIStoryboardSegue*)segue {
    // Find the embedded TableViewController
    for (UIViewController* viewController in self.childViewControllers) {
        if ([viewController isKindOfClass:[MatchTVController class]]) {
            // Found the embedded TableViewController
            MatchTVController* matchTVC = (MatchTVController*)viewController;
            // self.selectedTeams was set by the unwind segue, now we just need to tell the embedded TableViewController in case it changed
            if (![self.selectedTeams isEqualToArray:matchTVC.selectedTeams]) {
                NSLog(@"Settings changed");
                // The selection changed, so we need to update it in the TableViewController
//                matchTVC.tweets = @[];
//                [matchTVC.tableView reloadData];
                matchTVC.selectedTeams = self.selectedTeams;
            } else {
                NSLog(@"Settings didn't change");
            }
        }
    }
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
            if (result == SLComposeViewControllerResultDone) {
                // TODO: Refresh data after a certain timeout?
            }
        });
	};
    
    // Set the text to contain the appropriate hashtags
    NSString* text = @"";
    if ([self.selectedTeams count] == 1) {
        Team* team1 = self.selectedTeams[0];
        text = [NSString stringWithFormat:@"%@", team1.hashtags[0]];
    } else if ([self.selectedTeams count] == 2) {
        Team* team1 = self.selectedTeams[0];
        Team* team2 = self.selectedTeams[1];
        text = [NSString stringWithFormat:@"%@ %@", team1.hashtags[0], team2.hashtags[0]];
    }
    [tweetSheet setInitialText:text];
	
    // Presents the tweet sheet to the user
    [self presentViewController:tweetSheet animated:animated completion:NULL];
}

@end
