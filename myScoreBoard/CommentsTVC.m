//
//  CommentsTVC.m
//  myScoreBoard
//
//  Created by Jannes on May/30/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "CommentsTVC.h"

#import <RestKit/RestKit.h>
#import "RKTweet.h"

@interface CommentsTVC ()
@property (nonatomic) NSArray* tweets;
@property (nonatomic) UITableViewCell* prototypeCell;
@end

@implementation CommentsTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Save comment cell prototype
    static NSString* CellIdentifier = @"Comment cell";
    self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Background image
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg"]];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main-bg"]];
    
    // Describe object mapping
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[RKTweet class]];
    [mapping addAttributeMappingsFromDictionary:@{
     @"from_user": @"username",
     @"from_user_id": @"userID",
     @"text": @"text"
     }];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping pathPattern:@"/search.json" keyPath:@"results" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://search.twitter.com/search.json?q=%23fcb"]];
    
    // Create operation
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation* operation, RKMappingResult* results) {
        self.tweets = [results array];
        [self.tableView reloadData];
    } failure:nil];
    // Execute operation
    [operation start];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (self.tweets) {
        return [self.tweets count];
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"Comment cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    RKTweet* tweet = self.tweets[indexPath.row];
    cell.textLabel.text = tweet.text;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = ((RKTweet*) self.tweets[indexPath.row]).text;
    
    // Compute height
    CGFloat marginLeft = self.prototypeCell.textLabel.frame.origin.x;
    CGSize size = [text sizeWithFont:self.prototypeCell.textLabel.font
                   constrainedToSize:CGSizeMake(self.view.bounds.size.width - 2 * marginLeft, CGFLOAT_MAX)
                       lineBreakMode:NSLineBreakByWordWrapping];
//    CGFloat height = MAX(size.height, 44);
    CGFloat height = size.height;
    
    return height + 2 * marginLeft;
}

@end
