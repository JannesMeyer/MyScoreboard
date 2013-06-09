//
//  MenuViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import "MenuVController.h"

#import "Models/Match.h"
#import "MatchVController.h"
#import "MatchNController.h"
#import "CustomViews/MatchCell.h"
#import "ScoreApi.h"

@interface MenuVController()
@property (weak, nonatomic) NSMutableArray* matches;
@property (weak, nonatomic) NSString* groupName;
@end

@implementation MenuVController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Load data
    [self refreshData:nil];
    
    // Manually connect refresh control because connecting in the Storyboard is buggy
    [self.refreshControl addTarget:self
                            action:@selector(refreshData:)
                  forControlEvents:UIControlEventValueChanged];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    
    // Custom background imge
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu-bg"]];
}

#pragma mark - Load data

- (IBAction)refreshData:(id)sender {
    id<ScoreApiProtocol> api = [ScoreApi sharedApi];
    [api setCompletionHandler:^{
        MatchGroup* group = [ScoreApi sharedApi].matchCache;
        self.matches = group.matches;
        self.groupName = group.name;
        [self.refreshControl endRefreshing];
        
        // Stupid
        [self.tableView reloadData];
        
        // Select first item if this request is not coming from a call to ScoreAPI
        if (!sender && [self.matches count] > 0) {
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self showMatch:[self.matches objectAtIndex:indexPath.row]];
            [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
        }
    }];
    // Execute the request
    [api loadMatchesForMatchday];
}

- (void)showMatch:(Match*)match {
    // Get the top view controller (it has to be a UINavigationController)
    UINavigationController* viewController = (UINavigationController*) self.slidingViewController.topViewController;
    
    // Initialize the new view
    MatchVController* newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MatchView"];
    newViewController.match = match;
    
    // Replace the view
    [viewController setViewControllers:@[newViewController]];
}

#pragma mark - TableView datasource

//- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
//    return 1;
//}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.groupName uppercaseString];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    return self.matches.count;
}

- (UITableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    MatchCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MatchCell"];
    if (cell == nil) {
        // It's a new cell
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MatchCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    // Set the data
    Match* match = [self.matches objectAtIndex:indexPath.row];
    [cell setTeam1Name:match.team1.name];
    [cell setTeam2Name:match.team2.name];
    [cell setTeam1Score:match.team1Score];
    [cell setTeam2Score:match.team2Score];
    [cell setMinutes:match.currentMinute];
    [cell setCommentCount:match.commentCount];
    return cell;
}

#pragma mark - TableView delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    int paddingLeft = 10;
    
    CGRect frame = CGRectMake(0, 0, 320, 27);
    UIView* headerView = [[UIView alloc] initWithFrame: frame];
    headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menu-hsection"]];
    
    int textColor = 0x6b6e6b;
    float r = ((textColor & 0xFF0000) >> 16) / 255.0;
    float g = ((textColor & 0x00FF00) >> 8) / 255.0;
    float b = ((textColor & 0x0000FF) >> 0) / 255.0;
    
    UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(paddingLeft, 0, frame.size.width - paddingLeft, frame.size.height)];
    title.font = [UIFont systemFontOfSize:11];
    title.textColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    title.backgroundColor = [UIColor clearColor];
    title.text = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    
    [headerView addSubview:title];
    
    return headerView;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    // Make sure that the top view controller is of the right class
    if ([self.slidingViewController.topViewController isKindOfClass:[MatchNController class]]) {
        MatchNController* navigationController = (MatchNController*) self.slidingViewController.topViewController;
        
        // Prepare match view
        MatchVController* newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MatchView"];
        newViewController.match = self.matches[indexPath.row];
        
        // Replace view controller and slide out the menu
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            [navigationController setViewControllers:@[newViewController]];
            [self.slidingViewController resetTopView];
        }];
    }
}

@end
