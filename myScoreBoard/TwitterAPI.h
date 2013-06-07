//
//  TwitterAPI.h
//  myScoreBoard
//
//  Created by Jannes on Jun/6/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TWTweetsCompletionHandler)(NSArray* tweets, NSError* error);


@interface TwitterAPI : NSObject

+ (TwitterAPI*)sharedInstance;
- (void)findTweetsForHashtag:(NSString*)hashtag withCompletionHandler:(TWTweetsCompletionHandler)completion;

@end
