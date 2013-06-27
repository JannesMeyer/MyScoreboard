//
//  MatchTVController.h
//  myScoreBoard
//
//  Created by Jannes on Jun/14/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Match.h"

@interface MatchTVController : UITableViewController

@property (nonatomic) Match* match;
@property (nonatomic) NSArray* tweets; // of RKTweet
@property (nonatomic) NSArray* selectedTeams; // of Team

@property (weak, nonatomic) IBOutlet UILabel *minuteLabel;
@property (weak, nonatomic) IBOutlet UILabel *team1Label;
@property (weak, nonatomic) IBOutlet UILabel *team2Label;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel1;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel2;
@property (weak, nonatomic) IBOutlet UIImageView *dividerLine;
@property (weak, nonatomic) IBOutlet UILabel *goalsListLabel1;
@property (weak, nonatomic) IBOutlet UILabel *goalsListLabel2;

@property (nonatomic) UIImageView *backgroundImageView; // Background image in the header view

@end
