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
    m.team1 = [[Team alloc] initWithId: 0 andName:@"Werder Bremen"];
    m.team2 = [[Team alloc] initWithId: 1 andName:@"Bayern München"];
    m.startTime = [NSDate date];
    m.stadiumName = @"Weserstadion";
    m.locationName = @"Bremen";
    [matchArr addObject:m];

    m = [[Match alloc] initWithId:1];
    m.team1 = [[Team alloc] initWithId: 2 andName:@"Eintracht Frankfurt"];
    m.team2 = [[Team alloc] initWithId: 3 andName:@"VfL Wolfsburg"];
    m.startTime = [NSDate date];
    m.stadiumName = @"Commerzbank-Arena";
    m.locationName = @"Frankfurt";
    [matchArr addObject:m];

    m = [[Match alloc] initWithId:2];
    m.team1 = [[Team alloc] initWithId: 4 andName:@"VfB Stuttgart"];
    m.team2 = [[Team alloc] initWithId: 5 andName:@"1. FSV Mainz 05"];
    m.startTime = [NSDate date];
    m.stadiumName = @"Mercedes-Benz Arena";
    m.locationName = @"Stuttgart";
    [matchArr addObject:m];
    
    MatchGroup* matches = [[MatchGroup alloc] initWithMatches:matchArr];
    matches.name = @"1. Bundesliga";
    return matches;
}

@end
