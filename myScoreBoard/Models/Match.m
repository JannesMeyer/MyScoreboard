//
//  Match.m
//  myScoreBoard
//
//  Created by Jannes on May/10/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "Match.h"

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

@end
