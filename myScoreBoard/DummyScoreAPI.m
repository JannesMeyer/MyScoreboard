//
//  DummyScoreAPI.m
//  myScoreBoard
//
//  Created by Jannes on May/17/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "DummyScoreAPI.h"
#import "Match.h"

@implementation DummyScoreAPI

- (MatchGroup*)getMatchesForToday {
    return nil;
}

- (MatchGroup*)getMatchesForMatchday {
    NSMutableArray* matchArr = [[NSMutableArray alloc] init];
    Match* m;
    
    m = [[Match alloc] initWithId:0];
    m.team1 = [[Team alloc] initWithId: 0];
    m.team1.name = @"Werder Bremen";
    m.team2 = [[Team alloc] initWithId: 1];
    m.team2.name = @"Bayern München";
    m.startTime = [NSDate date];
    m.stadiumName = @"Weserstadion";
    m.locationName = @"Bremen";
    [matchArr addObject:m];

    m = [[Match alloc] initWithId:1];
    m.team1 = [[Team alloc] initWithId: 2];
    m.team1.name = @"Eintracht Frankfurt";
    m.team2 = [[Team alloc] initWithId: 3];
    m.team2.name = @"VfL Wolfsburg";
    m.startTime = [NSDate date];
    m.stadiumName = @"Commerzbank-Arena";
    m.locationName = @"Frankfurt";
    [matchArr addObject:m];

    m = [[Match alloc] initWithId:2];
    m.team1 = [[Team alloc] initWithId: 4];
    m.team1.name = @"VfB Stuttgart";
    m.team2 = [[Team alloc] initWithId: 5];
    m.team2.name = @"1. FSV Mainz 05";
    m.startTime = [NSDate date];
    m.stadiumName = @"Mercedes-Benz Arena";
    m.locationName = @"Stuttgart";
    [matchArr addObject:m];
    
    MatchGroup* matches = [[MatchGroup alloc] initWithMatches:matchArr];
    matches.name = @"1. Bundesliga";
    return matches;
}

- (void)setUpdateAction:(void (^)(void))action {
    
}

- (void)triggerUpdate {
    [NSThread sleepForTimeInterval:2];
    // Send a notification through NotificationCenter
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Score API updated" object:nil];
}

@end
