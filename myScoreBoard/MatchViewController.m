//
//  MatchViewController.m
//  myScoreBoard
//
//  Created by Jannes Meyer on 26.04.13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "MatchViewController.h"
#import "MenuViewController.h"
#import "Goal.h"

@interface MatchViewController()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@property (weak, nonatomic) IBOutlet UIImageView *scoreContainer;
@property (weak, nonatomic) IBOutlet UILabel *minuteLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel1;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel2;
@property (weak, nonatomic) IBOutlet UILabel *goalsLabel1;
@end

@implementation MatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.match) {
        [self updateUI];
    }
    
    [self sharingStatus];
    
    // Background image
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg"]];
    // Navigation bar button
    [self.menuButton setImage:[UIImage imageNamed:@"icon-navbar"]];
    [self.menuButton setBackgroundImage:[[UIImage alloc] init] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    // Score container
    self.scoreContainer.image = [[UIImage imageNamed:@"score-bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 7, 8, 7)];
}

- (void)updateUI {
    self.minuteLabel.text = [NSString stringWithFormat:@"%d", self.match.currentMinute];
    self.locationLabel.text = self.match.stadiumName;
    self.matchNameLabel.text = [NSString stringWithFormat:@"%@ vs. %@", self.match.team1.name, self.match.team2.name];
    self.scoreLabel1.text = [NSString stringWithFormat:@"%d", self.match.team1Score];
    self.scoreLabel2.text = [NSString stringWithFormat:@"%d", self.match.team2Score];
    NSString* goalText = @"";
    for (Goal* goal in self.match.goals) {
        goalText = [goalText stringByAppendingFormat:@"%@ - %d min\n", goal.byPlayer, goal.time];
    }
    self.goalsLabel1.text = goalText;
}

- (IBAction)revealMenu:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

#pragma mark - Twitter stuff

- (void)sharingStatus {
//    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
//        NSLog(@"Twitter available");
//    }
    
    // Request access to the Twitter accounts
    ACAccountStore* accountStore = [[ACAccountStore alloc] init];
    ACAccountType* accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];

    
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError* error) {
         if (granted) {
             // Permissions needed?
             NSArray* twitterAccounts = [accountStore accountsWithAccountType:accountType];
             if ([twitterAccounts count] > 0) {
                 ACAccount* twitterAccount = [twitterAccounts lastObject];
                 NSLog(@"Twitter Account configured: %@ %@", twitterAccount.username, [twitterAccount valueForKeyPath:@"properties.user_id"]);
             } else {
                 NSLog(@"No Twitter Account configured");
             }
         } else {
             NSLog(@"No Twitter Access Error");
         }
     }];
    
}

- (IBAction)shareComment {
    static BOOL animated = YES;
    
	//  Create an instance of the Tweet Sheet
	SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType: SLServiceTypeTwitter];
	tweetSheet.completionHandler = ^(SLComposeViewControllerResult result) {
        if (result == SLComposeViewControllerResultDone) {
            // Tweet sent
        }
		// Any UI changes need to happen on the main queue
		dispatch_async(dispatch_get_main_queue(), ^{
			[self dismissViewControllerAnimated:animated completion:NULL];
		});
	};
    // Initial text contains the appropriate hashtag
	[tweetSheet setInitialText:[NSString stringWithFormat:@" #%@", self.match.team1.twitterHashTag]];
	//  Presents the Tweet Sheet to the user
	[self presentViewController:tweetSheet animated:animated completion:NULL];
}

- (void)addScoreView {
    //    UIImageView* container = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 300, 100)];
    //    container.opaque = NO;
    //    container.image = [[UIImage imageNamed:@"score-bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 7, 8, 7)];
    //
    //    UILabel* team1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, container.bounds.size.width / 2, 30)];
    //    team1.text = @"Werder Bremen";
    //    team1.opaque = NO;
    //    team1.backgroundColor = nil;
    //    team1.textColor = [UIColor whiteColor];
    //    team1.shadowColor = [UIColor blackColor];
    //    team1.shadowOffset = CGSizeMake(0, 1);
    //    team1.font = [UIFont boldSystemFontOfSize:18];
    //
    //    UILabel* team2 = [[UILabel alloc] initWithFrame:CGRectMake(145, 5, container.bounds.size.width / 2, 30)];
    //    team2.text = @"TSG Hoffenheim";
    //    team2.opaque = NO;
    //    team2.backgroundColor = nil;
    //    team2.textColor = [UIColor whiteColor];
    //    team2.shadowColor = [UIColor blackColor];
    //    team2.shadowOffset = CGSizeMake(0, 1);
    //    team2.font = [UIFont boldSystemFontOfSize:18];
    //    team2.textAlignment = NSTextAlignmentRight;
    //
    //    [container addSubview:team1];
    //    [container addSubview:team2];
    //    [self.view addSubview:container];
}

@end
