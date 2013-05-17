//
//  MatchGroup.m
//  myScoreBoard
//
//  Created by Jannes on May/17/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "MatchGroup.h"

@interface MatchGroup()
@property (nonatomic, readwrite) NSMutableArray* matches;
@end

@implementation MatchGroup

// Initializes with an existing array
-(id) initWithMatches:(NSMutableArray*) matches {
    self = [super init];
    if (self) {
        self.matches = matches;
    }
    return self;
}

// Adds a match to the list
-(void) add:(Match*) match {
    [self.matches addObject:match];
}

// Returns the match at index
-(Match*) matchAtIndex:(NSInteger) index {
    return [self.matches objectAtIndex:index];
}

@end
