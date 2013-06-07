//
//  MenuViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import "MenuVC.h"

#import "AppDelegate.h"
#import "MatchVC.h"
#import "MatchNC.h"
// Custom view
#import "CustomViews/MatchCell.h"
// Model
#import "Match.h"

@interface MenuVC()
//@property (strong, nonatomic) IBOutlet UITableView *menuTView;
@property (weak, nonatomic) NSMutableArray* matches;
@property (weak, nonatomic) NSString* groupName;
@end

@implementation MenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate* app = [[UIApplication sharedApplication] delegate];
    self.matches = app.matchgroup.matches;
    self.groupName = app.matchgroup.name;
    
    // Select first item
//    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
    
    // Custom style
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu-bg"]];
}

#pragma mark - TableView header

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.groupName uppercaseString];
}

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

#pragma mark - TableView rows

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
    return cell;
    
}

#pragma mark - Events

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    if (![self.slidingViewController.topViewController isKindOfClass:[MatchNC class]]) {
        // Something is wrong, do nothing
        return;
    }
    MatchNC* navigationController = (MatchNC*) self.slidingViewController.topViewController;
    
    // Prepare match view
    MatchVC* newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MatchView"];
    newViewController.match = self.matches[indexPath.row];

    // Replace view controller and slide out the menu
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        [navigationController setViewControllers:@[newViewController]];
        [self.slidingViewController resetTopView];
    }];
}

@end
