//
//  SettingsTVController.m
//  myScoreBoard
//
//  Created by Jannes on Jun/9/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "SettingsTVController.h"

#import "MatchVController.h"
#import "Team.h"

@implementation SettingsTVController

- (void)viewDidLoad {
    // Set the names and selection of the teams
    NSInteger i = 0;
    for (Team* team in self.teams) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell* cell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.text = team.name;
        if ([self.selectedTeams containsObject:team]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        ++i;
    }
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell* cell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    // Toggle checkmark
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        //cell.textLabel.textColor = [UIColor blackColor];
        [self.selectedTeams removeObject:self.teams[indexPath.row]];
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        //cell.textLabel.textColor = [UIColor colorWithRed:56/255.0 green:84/255.0 blue:135/255.0 alpha:1];
        [self.selectedTeams addObject:self.teams[indexPath.row]];
    }
    // Fade out blue selection
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Settings done"]) {
        MatchVController* matchVC = (MatchVController*)segue.destinationViewController;
        // Make a non-mutable copy
        matchVC.selectedTeams = [self.selectedTeams copy];
    }
}

@end
