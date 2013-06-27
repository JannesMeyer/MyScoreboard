//
//  ScoreApi2.m
//  myScoreBoard
//
//  Created by Jannes on Jun/7/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "ScoreApi.h"

#import "DummyScoreAPI.h"
#import "OpenLigaScoreAPI.h"

@implementation ScoreApi

static id<ScoreApiProtocol> volatile _sharedInstance = nil;

// Hands out an OpenLigaScoreAPI object. This can be replaced with DummyScoreAPI if wanted
+ (id<ScoreApiProtocol>)sharedApi {
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        _sharedInstance = [[OpenLigaScoreAPI alloc] init];
    });
    return _sharedInstance;
}

@end
