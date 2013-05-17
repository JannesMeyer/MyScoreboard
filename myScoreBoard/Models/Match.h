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
@property (readonly, nonatomic) int team1Score;
@property (readonly, nonatomic) int team2Score;
@property (nonatomic) NSString* stadiumName;
@property (nonatomic) NSString* locationName;

-(id)initWithId:(int) matchId;

@end
