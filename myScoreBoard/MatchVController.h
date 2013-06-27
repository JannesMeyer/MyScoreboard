//
//  MatchViewController.h
//  myScoreBoard
//
//  Created by Jannes Meyer on 26.04.13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Match.h"

@interface MatchVController : UIViewController

@property (nonatomic) Match* match;
@property (nonatomic) NSArray* selectedTeams;  // of Team

@end
