//
//  RKTweet.h
//  myScoreBoard
//
//  Created by Jannes on May/30/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject
@property (nonatomic, copy) NSNumber* userId;
@property (nonatomic, copy) NSString* userName;
@property (nonatomic, copy) NSString* text;
@property (nonatomic, copy) NSString* thumbnailUrl;
@end
