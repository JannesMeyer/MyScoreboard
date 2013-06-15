//
//  MatchTVController.m
//  myScoreBoard
//
//  Created by Jannes on Jun/14/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "MatchTVController.h"

#import <RestKit/RestKit.h> // Gives us AFNetworking
#import "TwitterAPI.h"
#import "CustomViews/TweetCell.h"
#import "Goal.h"
#import "Tweet.h"

@interface MatchTVController () <UITableViewDataSource, UITableViewDelegate>
@end

@implementation MatchTVController

// Creation originating from code
- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    [self setup];
    return self;
}

// Creation originating from storyboard
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    // Reset the background color so that it is see-through
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // Background image of the header
    UIImage* image = [[UIImage imageNamed:@"bg-cell-tweet-score"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 8, 9, 8)];
    self.backgroundImageView = [[UIImageView alloc] initWithImage:image];
    [self.tableView.tableHeaderView addSubview:self.backgroundImageView];
    [self.tableView.tableHeaderView sendSubviewToBack:self.backgroundImageView];
    
    // Divider
    self.dividerLine.image = [[UIImage imageNamed:@"trennlinie"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 2, 0, 2)];
    
    // Display the match data. Match could be nil
    [self updateScoreView];
    
    // Setup the UIRefreshControl to reload all tweets
    [self.refreshControl addTarget:self action:@selector(loadTweets:) forControlEvents:UIControlEventValueChanged];
}

- (void)setSelectedTeams:(NSArray*)selectedTeams {
    _selectedTeams = selectedTeams;
    // Team selection changed. Reload tweets.
    [self loadTweets:nil];
}

- (IBAction)loadTweets:(id)sender {
    if (self.match == nil || self.selectedTeams == nil) {
        return;
    }
    
    // Ask the Twitter API for comments for the selected teams (by default both teams)
    NSMutableArray* searchTerms = [[NSMutableArray alloc] init];
    for (Team* team in self.selectedTeams) {
        [searchTerms addObject:[team hashtagsAsString]];
    }
    // When the searchTerms are empty no results are returned
    [[TwitterAPI sharedInstance] findTweetsForSearchTerms:[searchTerms copy] withCompletionHandler:^(NSArray* tweets, NSError* error) {
        self.tweets = tweets;
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    }];
}

- (void)updateScoreView {
    // Show minute of the game
    self.minuteLabel.text = [NSString stringWithFormat:@"%d min", self.match.currentMinute];
    
    // Show team names
    self.team1Label.text = self.match.team1.name;
    self.team2Label.text = self.match.team2.name;
    
    // Show scores
    self.scoreLabel1.text = [NSString stringWithFormat:@"%d", self.match.team1Score];
    self.scoreLabel2.text = [NSString stringWithFormat:@"%d", self.match.team2Score];

    // Show goals
    NSString* goalText1 = @"";
    NSString* goalText2 = @"";
    CGFloat goalsHeight1 = 0;
    CGFloat goalsHeight2 = 0;
    // Warning: Hardcoded value from the storyboard because reading it out is a pain
    CGFloat lineHeight = 15;
    for (Goal* goal in self.match.goals) {
        if (goal.byTeam.teamId == self.match.team1.teamId) {
            goalText1 = [goalText1 stringByAppendingFormat:@"%@ - %d min\n", goal.byPlayer, goal.time];
            goalsHeight1 += lineHeight;
        } else if (goal.byTeam.teamId == self.match.team2.teamId) {
            goalText2 = [goalText2 stringByAppendingFormat:@"%@ - %d min\n", goal.byPlayer, goal.time];
            goalsHeight2 += lineHeight;
        }
    }
    self.goalsListLabel1.text = goalText1;
    self.goalsListLabel2.text = goalText2;
    [self updateHeaderHeight:MAX(goalsHeight1, goalsHeight2)];
}

/*!
 * Adjust the size of the tableHeaderView to dynamically fit all goals
 */
- (void)updateHeaderHeight:(CGFloat)goalsHeight {
    CGFloat paddingBottom = 17;
    CGRect headerFrame = self.tableView.tableHeaderView.frame;
    
    // Minimum height
    goalsHeight = MAX(15, goalsHeight);
    
    // Warning: Hardcoded values from the storyboard because reading them out is a pain
    headerFrame.size.height = 187 + goalsHeight + paddingBottom;
    
    // Set frame
    self.tableView.tableHeaderView.frame = headerFrame;
    
    // Set background image frame
    CGRect fullSize = self.tableView.tableHeaderView.bounds;
    self.backgroundImageView.frame = UIEdgeInsetsInsetRect(fullSize, UIEdgeInsetsMake(12, 10, 5, 10));
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
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    // Get a recycled cell
    static NSString* cellIdentifier = @"Comment cell";
    TweetCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    Tweet* tweet = self.tweets[indexPath.row];
    cell.tweetLabel.text = tweet.text;
    // Using AFNetworking's category on UIImageView
    [cell.profileImage setImageWithURL:[NSURL URLWithString:tweet.thumbnailUrl]];
    
    // Calculate frame of the text label
//    UIView* topview = (UIView*) [cell.tweetLabel superview];
//    CGFloat marginTop = topview.frame.origin.y;
//    CGFloat marginLeft = topview.frame.origin.x;
//    CGFloat marginBottom = cell.bounds.size.height - marginTop - topview.bounds.size.height;
//    CGFloat marginRight = cell.bounds.size.width - marginLeft - topview.bounds.size.width;
//    NSLog(@"UIEdgeInsetsMake(%g, %g, %g, %g)", marginTop, marginLeft, marginBottom, marginRight);
    
    return cell;
}

/*!
 * Computes the height for each row of the UITableView.
 * This method is called before tableView:cellForRowAtIndexPath: so we have to calculate
 * the height using NSString's methods
 *
 * @return Height of the row at the specified index path
 */
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return [TweetCell calculateHeightWithText:((Tweet*)self.tweets[indexPath.row]).text
                                 andTableView:tableView];
}

// For Debugging
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    cell.backgroundColor = indexPath.row%2 ? [UIColor blackColor] : [UIColor redColor];
//}

@end
