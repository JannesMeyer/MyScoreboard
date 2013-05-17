//
//  ScoreAPI.m
//  myScoreBoard
//
//  Created by stud on 10.05.13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "ScoreAPI.h"
#import "TouchXML.h"

@interface ScoreAPI()
@property (strong, nonatomic) NSMutableData* webData;
@end

@implementation ScoreAPI

-(id) init {
    self = [super init];
    if (self) {
        // Do initialization
    }
    return self;
}

-(Match*) getMatchesForMatchday {
    return nil;
}

-(Match*) getMatchesForToday {
    return nil;
}

-(void) setUpdateAction {
    
}

-(void) triggerUodate {
    
}


@end
