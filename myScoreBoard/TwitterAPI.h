//
//  TwitterAPI.h
//  myScoreBoard
//
//  Created by Jannes on Jun/6/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TweetsCompletionHandler)(NSArray* tweets, NSError* error);


@interface TwitterAPI : NSObject

+ (TwitterAPI*)sharedInstance;
- (void)findTweetsForSearchTerms:(NSArray*)searchTerms withCompletionHandler:(TweetsCompletionHandler)completion;

@end
