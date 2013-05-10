//
//  ScoreAPI.h
//  myScoreBoard
//
//  Created by stud on 10.05.13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Models/Match.h"

@interface ScoreAPI : NSObject

+(Match *) getMatchesForToday;
+(Match *) getMatchesForMatchday;


//+(void) setUpdateAction;
//+(void) triggerUodate;


@end
