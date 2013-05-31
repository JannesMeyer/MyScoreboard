//
//  Team.m
//  myScoreBoard
//
//  Created by Jannes on May/10/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "Team.h"

@implementation Team

- (id)initWithId:(int) teamId {
    self = [super init];
    if (self) {
        _teamId = teamId;
#warning Should be replaced by actual hashtag
        _twitterHashTag = @"fcb";
    }
    return self;
}

@end
