//
//  Team.m
//  myScoreBoard
//
//  Created by Jannes on May/10/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "Team.h"

@implementation Team
    
- (id)initWithId:(int) teamId andName:(NSString*) name {
    self = [super init];
    if (self) {
        self.teamId = teamId;
        self.name = name;
    }
    return self;
}

@end
