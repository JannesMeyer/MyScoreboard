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
@property (readonly, nonatomic) int matchId;
@property (strong, nonatomic) Team* team1;
@property (strong, nonatomic) Team* team2;
@property (strong, nonatomic) NSDate* startTime;
@property (strong, nonatomic) NSMutableArray* goals; // of Goal
@property (nonatomic) int team1Score;
@property (nonatomic) int team2Score;
@property (strong, nonatomic) NSString* stadiumName;
@property (strong, nonatomic) NSString* locationName;
@end
