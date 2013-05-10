//
//  Match.m
//  myScoreBoard
//
//  Created by Jannes on May/10/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "Match.h"

@interface Match()
@property (nonatomic, readwrite) int matchId;
@end

@implementation Match

-(id)initWithId:(int) newId {
    self = [super init];
    if (self) {
        self.matchId = newId;
    }
    return self;
}

-(NSMutableArray*)goals {
    if (!_goals) _goals = [[NSMutableArray alloc] init];
    return _goals;
}

@end
