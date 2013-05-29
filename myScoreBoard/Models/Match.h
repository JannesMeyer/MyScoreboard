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
@property (nonatomic) Team* team1;
@property (nonatomic) Team* team2;
@property (nonatomic) NSDate* startTime;
@property (nonatomic) NSMutableArray* goals; // of Goal
@property (nonatomic) NSString* stadiumName;
@property (nonatomic) NSString* locationName;

// designated initializer
- (id)initWithId:(int) matchId;

- (int)team1Score;
- (int)team2Score;
- (int)currentMinute;

@end
