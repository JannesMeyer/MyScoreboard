//
//  ScoreAPI.h
//  myScoreBoard
//
//  Created by stud on 10.05.13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreAPI : NSObject {
}

-(void) initialize {
    
    
}

+(Match *) getMatchesForToday;
+(Match *) getMatchesForMatchday;
+(void) setUpdateAction;
+(void) triggerUodate;


@end
