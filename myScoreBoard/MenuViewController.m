//
//  MenuViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import "MenuViewController.h"
//#import "MenuCell.h"

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
  
    self.menuItems = [NSArray arrayWithObjects:@"Test", nil];
    
    self.catPics = [NSArray arrayWithObjects:@"", nil];
    
    
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  
    [self.slidingViewController setAnchorRightRevealAmount:276.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    self.menuTView.backgroundColor = [UIColor colorWithPatternImage:[[UIImage imageNamed:@"menu_bg.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0]];
    self.menuTView.delegate = self;
    self.menuTView.dataSource = self;
    self.menuTView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.menuTView selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionTop];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    
    return self.menuItems.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        NSString *cellIdentifier = @"MenuItemCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
    
        //cell.categoryPic.image = [UIImage imageNamed:[self.catPics objectAtIndex:indexPath.row]];
    cell.textLabel.text = [self.menuItems objectAtIndex:indexPath.row];
  
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
