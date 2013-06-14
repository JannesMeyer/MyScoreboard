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
    
    if (self.match) {
        // Display data
        [self updateUI];
    }
}

- (void)viewDidLayoutSubviews {
    // Background image size
    CGRect fullSize = [self.backgroundImageView superview].bounds;
    self.backgroundImageView.frame = UIEdgeInsetsInsetRect(fullSize, UIEdgeInsetsMake(12, 10, 5, 10));
}

- (void)updateUI {
    self.minuteLabel.text = [NSString stringWithFormat:@"%d min", self.match.currentMinute];
    
    self.team1Label.text = self.match.team1.name;
    self.team2Label.text = self.match.team2.name;
    
    self.scoreLabel1.text = [NSString stringWithFormat:@"%d", self.match.team1Score];
    self.scoreLabel2.text = [NSString stringWithFormat:@"%d", self.match.team2Score];
//    NSString* goalText = @"";
//    for (Goal* goal in self.match.goals) {
//        goalText = [goalText stringByAppendingFormat:@"%@ - %d min\n", goal.byPlayer, goal.time];
//    }
//    self.goalsLabel1.text = goalText;
    
    // Ask the Twitter API for comments
    [[TwitterAPI sharedInstance] findTweetsForHashtag:[self.match.team1 hashtagsAsString] withCompletionHandler:^(NSArray* tweets, NSError* error) {
        self.tweets = tweets;
        [self.tableView reloadData];
    }];
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
    TweetCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    Tweet* tweet = self.tweets[indexPath.row];
    cell.tweetLabel.text = tweet.text;
    // Using AFNetworking's category on UIImageView
    [cell.profileImage setImageWithURL:[NSURL URLWithString:tweet.thumbnailUrl]];
    
    // Calculate frame of the text label. This frame never changes and is used in calculate
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TweetCell calculateHeightWithText:((Tweet*)self.tweets[indexPath.row]).text
                                 andTableView:tableView];
}

// For Debugging
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    cell.backgroundColor = indexPath.row%2 ? [UIColor blackColor] : [UIColor redColor];
//}

@end
