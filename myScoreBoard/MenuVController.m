//
//  MenuViewController.m
//  ECSlidingViewController
//
//  Created by Jannes on 03.05.13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "MenuVController.h"

#import "MatchVController.h"
#import "MatchNController.h"
#import "CustomViews/MatchCell.h"
#import "ScoreApi.h"
#import "Models/MatchGroup.h"

@interface MenuVController()
@property (nonatomic) MatchGroup* group;
@end

@implementation MenuVController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Custom background imge
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu-bg"]];
    
    // Load data
    [self refreshData:nil];
    
    // Manually connect the refresh control because connecting it in the storyboard
    // is buggy (i.e. the action will never be called)
    [self.refreshControl addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - Load data

- (IBAction)refreshData:(id)sender {
    id<ScoreApiProtocol> api = [ScoreApi sharedApi];
    [api setCompletionHandler:^{
        // GCD doesn't support any parameters so we just pull the latest data out of the
        // ScoreApi singleton instead. This certainly isn't the cleanest solution.
        self.group = [ScoreApi sharedApi].matchCache;

        [self.refreshControl endRefreshing];
        
        // Stupid
        [self.tableView reloadData];
        
        
        // Show the first item's details if this was an initial request
        if (!sender && [self.group.matches count] > 0) {
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self showMatch:[self.group.matches objectAtIndex:indexPath.row]];
            [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
        }
    }];
    // Execute the request
    [api loadMatchesForMatchday];
}

/*!
 * Replaces the ViewController on the MatchNavigationController's navigation stack
 */
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
    return [self.group.name uppercaseString];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    return [self.group.matches count];
}

- (UITableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    MatchCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Match cell"];

    // Set the data
    Match* match = [self.group.matches objectAtIndex:indexPath.row];
    [cell setTeam1Name:match.team1.name];
    [cell setTeam2Name:match.team2.name];
    [cell setTeam1Score:match.team1Score];
    [cell setTeam2Score:match.team2Score];
    [cell setMinutes:match.currentMinute];
    [cell setCommentCount:match.commentCount];
    
    return cell;
}

#pragma mark - TableView delegate

/*!
 * Builds a view that is to be used as section header in the menu
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static int paddingLeft = 10;
    static int height = 27;
    
    static int textColor = 0x6b6e6b;
    float r = ((textColor & 0xFF0000) >> 16) / 255.0;
    float g = ((textColor & 0x00FF00) >> 8) / 255.0;
    float b = ((textColor & 0x0000FF) >> 0) / 255.0;
    
    // Create a fresh new UIView
    CGRect frame = CGRectMake(0, 0, tableView.bounds.size.width, height);
    UIView* headerView = [[UIView alloc] initWithFrame: frame];
    headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menu-hsection"]];
    
    // Add an UILabel
    UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(paddingLeft, 0, frame.size.width - paddingLeft, frame.size.height)];
    [headerView addSubview:title];
    
    // Font size
    title.font = [UIFont systemFontOfSize:11];
    
    // Text color
    title.textColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    
    // Translucent background
    title.backgroundColor = [UIColor clearColor];
    
    // Section header text
    title.text = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    
    return headerView;
}

/*!
 * When a row is tapped, the topViewController (of ECSlidingViewController) should be updated
 */
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    // Make sure that the top view controller is of the right class
    if ([self.slidingViewController.topViewController isKindOfClass:[MatchNController class]]) {
        MatchNController* navigationController = (MatchNController*) self.slidingViewController.topViewController;
        
        // Prepare match view
        MatchVController* newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MatchView"];
        newViewController.match = self.group.matches[indexPath.row];
        
        // Replace view controller and slide out the menu
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            [navigationController setViewControllers:@[newViewController]];
            [self.slidingViewController resetTopView];
        }];
    }
}

@end
