//
//  ScoreApi2.h
//  myScoreBoard
//
//  Created by Jannes on Jun/7/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MatchGroup.h"

// Define a new type for the completion handler block
typedef void(^ScoreApiCompletionHandler)(void);


// Define the protocol that all APIs must implement
@protocol ScoreApiProtocol <NSObject>

- (void)setCompletionHandler:(ScoreApiCompletionHandler)completion;
- (void)loadMatchesForMatchday;
@property (nonatomic, readonly) MatchGroup* matchCache;

@optional
- (void)loadMatchesForToday;

@end


// Hands out a singleton
@interface ScoreApi : NSObject
+ (id<ScoreApiProtocol>)sharedApi;
@end
