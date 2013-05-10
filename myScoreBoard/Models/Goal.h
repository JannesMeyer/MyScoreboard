//
//  Goal.h
//  myScoreBoard
//
//  Created by Jannes on May/10/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Team.h"

@interface Goal : NSObject
@property (nonatomic, strong) NSDate* time;
@property (nonatomic) int halftime;
@property (nonatomic, strong) NSString* byPlayer;
@property (nonatomic, weak) Team* byTeam;
@end
