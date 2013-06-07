//
//  CommentsTVC.m
//  myScoreBoard
//
//  Created by Jannes on May/30/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "CommentsTVC.h"

#import "RKTweet.h"
#import "TwitterAPI.h"

@interface CommentsTVC ()
@property (nonatomic) NSArray* tweets; // of RKTweet
@property (nonatomic) CGFloat cellMarginLeft;
@property (nonatomic) UIFont* cellFont;
@end

@implementation CommentsTVC

// Designated initializer
- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Get a temporary comment cell prototype so that we can pull out the font that's used on the label
    UITableViewCell* prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"Comment cell"];
    self.cellMarginLeft = prototypeCell.textLabel.frame.origin.x;
    self.cellFont = prototypeCell.textLabel.font;
    
    // Ask the Twitter API for data
    TwitterAPI* twApi = [TwitterAPI sharedInstance];
    [twApi findTweetsForHashtag:@"fcb" withCompletionHandler:^(NSArray* tweets, NSError* error) {
        // Reload tableview data
        self.tweets = tweets;
        [self.tableView reloadData];
    }];
    
    // Background image
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg"]];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main-bg"]];
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
    cell.textLabel.text = tweet.text;
    
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
    NSString* text = ((RKTweet*) self.tweets[indexPath.row]).text;
    
    // Compute height
    CGSize maxBounds = CGSizeMake(self.view.bounds.size.width - 2 * self.cellMarginLeft, CGFLOAT_MAX);
    CGSize size = [text sizeWithFont:self.cellFont
                   constrainedToSize:maxBounds
                       lineBreakMode:NSLineBreakByWordWrapping];
    
    return size.height + 2 * self.cellMarginLeft;
}

@end
