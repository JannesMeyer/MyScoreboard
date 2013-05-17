//
//  MenuViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import "MenuViewController.h"
#import "CustomMenuCell.h"

@interface MenuViewController()
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) NSArray *catPics;
@end

@implementation MenuViewController
@synthesize menuItems;
@synthesize catPics;
@synthesize menuTView;


- (void)awakeFromNib
{
    self.menuItems = [NSArray arrayWithObjects:@"Test", @"Test2", nil];
    self.catPics = [NSArray arrayWithObjects:@"", nil];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menu-bg"]];  
  
    [self.slidingViewController setAnchorRightRevealAmount:276.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    self.menuTView.backgroundColor = [UIColor clearColor];
    self.menuTView.delegate = self;
    self.menuTView.dataSource = self;
    self.menuTView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.menuTView selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionTop];
    

    self.menuTView.rowHeight = 50;
    self.menuTView.sectionHeaderHeight = 27;
//    self.menuTView.allowsSelection = false;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"1. BUNDESLIGA";
    }
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0) {
        return self.menuItems.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        NSString *cellIdentifier = @"MenuItemCell";
        CustomMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[CustomMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
  
        return cell;
        
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
  NSString *identifier = [NSString stringWithFormat:@"%@", [self.menuItems objectAtIndex:indexPath.row]];

  UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
  
  [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
    CGRect frame = self.slidingViewController.topViewController.view.frame;
    self.slidingViewController.topViewController = newTopViewController;
    self.slidingViewController.topViewController.view.frame = frame;
    [self.slidingViewController resetTopView];
  }];
     
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
