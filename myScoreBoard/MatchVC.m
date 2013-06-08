//
//  MatchViewController.m
//  myScoreBoard
//
//  Created by Jannes Meyer on 26.04.13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "MatchVC.h"

#import "MenuVC.h"
#import "Goal.h"
#import "RKTweet.h"
#import "TwitterAPI.h"
#import "CustomViews/TweetCell.h"

@interface MatchVC() <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIImageView *scoreContainer;
@property (weak, nonatomic) IBOutlet UILabel *minuteLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel1;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel2;
@property (weak, nonatomic) IBOutlet UILabel *goalsLabel1;


@property (weak, nonatomic) IBOutlet UITableView* commentsTableView;
@property (nonatomic) NSArray* tweets; // of RKTweet
@property (nonatomic) UIFont* cellFont;

@end

@implementation MatchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.match) {
        // Load the data from the match
        [self updateUI];
        
        // Ask the Twitter API for data
        [[TwitterAPI sharedInstance] findTweetsForHashtag:@"fcb" withCompletionHandler:^(NSArray* tweets, NSError* error) {
            // Reload tableview data
            self.tweets = tweets;
            [self.commentsTableView reloadData];
        }];
    }
    
    // Get a temporary comment cell prototype so that we can pull out the font that's used on the label
    TweetCell* prototypeCell = [self.commentsTableView dequeueReusableCellWithIdentifier:@"Comment cell"];
    self.cellFont = prototypeCell.textLabel.font;
    
    // Custom UI
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg"]];
    
    [self.menuButton setImage:[UIImage imageNamed:@"icon-navbar"]];
    [self.menuButton setBackgroundImage:[[UIImage alloc] init] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [self.settingsButton setImage:[UIImage imageNamed:@"teams"]];
    [self.settingsButton setBackgroundImage:[[UIImage alloc] init] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    self.scoreContainer.image = [[UIImage imageNamed:@"score-bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 7, 8, 7)];
    
    // Change navigation bar style globally through the appearance proxy
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar"] forBarMetrics:UIBarMetricsDefault];
    // Change navigation bar style locally
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar"] forBarMetrics:UIBarMetricsDefault];
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

// Unwind segue
- (IBAction)exitTeamSelection:(UIStoryboardSegue*)segue {
    NSLog(@"Back in Match View");
}

#pragma mark - Twitter stuff
- (IBAction)writeComment {
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



#pragma mark - Table view data source

/*!
 * Returns the number of rows in the first section
 *
 * @return The number of tweets, or 0 if self.tweets is nil
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tweets count];
}

/*!
 * Retrieve a cell that's populated with data
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Get a recycled cell
    static NSString* cellIdentifier = @"Comment cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    RKTweet* tweet = self.tweets[indexPath.row];
//    cell.textLabel.text = tweet.text;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell* tweetCell = (TweetCell*)cell;
//    cell.backgroundColor = indexPath.row % 2 ? [UIColor blackColor] : [UIColor greenColor];
//    tweetCell.textLabel.backgroundColor = [UIColor redColor];
    tweetCell.avatar.backgroundColor = [UIColor grayColor];
}

/*!
 * Computes the height for each row of the UITableView.
 * This method is called before tableView:cellForRowAtIndexPath: so we have to calculate
 * the height using NSString's methods
 *
 * @return Height of the row at the specified index path
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* text = ((RKTweet*) self.tweets[indexPath.row]).text;
    return [TweetCell calculateHeightWithText:text font:self.cellFont width:self.view.bounds.size.width];
}

@end
