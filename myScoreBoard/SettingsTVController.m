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

/*!
 * Initialize the list with both teams
 */
- (void)viewDidLoad {
    NSInteger i = 0;
    for (Team* team in self.teams) {
        // Find the cell
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell* cell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        
        // Set the team name
        cell.textLabel.text = team.name;
        
        // Set the checked state
        if ([self.selectedTeams containsObject:team]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        ++i;
    }
}

/*!
 * The selected state of a row should be toggled when it is tapped.
 * This seems to be the proper way to implement 'radio buttons'
 */
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell* cell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    
    // Toggle checkmark accessory
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        //cell.textLabel.textColor = [UIColor blackColor];
        [self.selectedTeams removeObject:self.teams[indexPath.row]];
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        //cell.textLabel.textColor = [UIColor colorWithRed:56/255.0 green:84/255.0 blue:135/255.0 alpha:1];
        [self.selectedTeams addObject:self.teams[indexPath.row]];
    }
    
    // Fade out the blue background
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*!
 * This pretty much only handles the unwind segue that goes back to MatchVController
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Settings done"]) {
        MatchVController* matchVC = (MatchVController*)segue.destinationViewController;
        // Make a non-mutable copy
        matchVC.selectedTeams = [self.selectedTeams copy];
    }
}

@end
