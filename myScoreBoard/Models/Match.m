//
//  Match.m
//  myScoreBoard
//
//  Created by Jannes on May/10/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "Match.h"
#import "Goal.h"

@interface Match()
@property (readwrite, nonatomic) int matchId;
@end

@implementation Match

-(id)initWithId:(int) matchId {
    self = [super init];
    if (self) {
        self.matchId = matchId;
    }
    return self;
}

// Getter for goals
-(NSMutableArray*)goals {
    if (!_goals) _goals = [[NSMutableArray alloc] init];
    return _goals;
}

- (int)team1Score {
    return [[self.goals indexesOfObjectsPassingTest:^BOOL(Goal* goal, NSUInteger idx, BOOL *stop) {
        return goal.byTeam.teamId == self.team1.teamId;
    }] count];
}

- (int)team2Score {
    return [[self.goals indexesOfObjectsPassingTest:^BOOL(Goal* goal, NSUInteger idx, BOOL *stop) {
        return goal.byTeam.teamId == self.team2.teamId;
    }] count];
}

- (int)currentMinute {
    return arc4random() % 90;
}

@end
