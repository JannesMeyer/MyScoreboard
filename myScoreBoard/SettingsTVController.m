//
//  SettingsTVController.m
//  myScoreBoard
//
//  Created by Jannes on Jun/9/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "SettingsTVController.h"

#import "Team.h"

@implementation SettingsTVController

- (void)viewDidLoad {
    // Set the names of the teams
    NSInteger i = 0;
    for (Team* team in self.teams) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell* cell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.text = team.name;
        ++i;
    }
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell* cell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    // Toggle checkmark
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
//        cell.textLabel.textColor = [UIColor blackColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
//        cell.textLabel.textColor = [UIColor colorWithRed:56/255.0 green:84/255.0 blue:135/255.0 alpha:1];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    // Fade out blue selection
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end