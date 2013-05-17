//
//  ScoreAPIProtocol.h
//  myScoreBoard
//
//  Created by Jannes on May/17/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MatchGroup.h"

@protocol ScoreAPIProtocol <NSObject>

//- (id)init;
- (MatchGroup*)getMatchesForToday;
- (MatchGroup*)getMatchesForMatchday;
//- (void)setUpdateAction;
//- (void)triggerUodate;

@end
