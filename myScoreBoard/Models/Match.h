//
//  Match.h
//  myScoreBoard
//
//  Created by Jannes on May/10/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Team.h"

@interface Match : NSObject
@property (nonatomic) int matchId;
@property (nonatomic, strong) Team* team1;
@property (nonatomic, strong) Team* team2;
@property (nonatomic, strong) NSDate* startTime;
@property (nonatomic, strong) NSMutableArray* goals; // of Goal
@property (nonatomic) int team1Score;
@property (nonatomic) int team2Score;
@property (nonatomic, strong) NSString* stadiumName;
@property (nonatomic, strong) NSString* locationName;
@end
