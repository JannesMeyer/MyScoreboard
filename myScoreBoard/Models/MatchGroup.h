//
//  MatchGroup.h
//  myScoreBoard
//
//  Created by Jannes on May/17/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Match.h"

@interface MatchGroup : NSObject

@property (readonly, nonatomic) NSMutableArray* matches;
@property (nonatomic) NSString* name;

-(id) initWithMatches:(NSMutableArray*) matches;
-(void) add:(Match*) match;
-(Match*) matchAtIndex:(NSInteger) index;

@end
