//
//  Team.h
//  myScoreBoard
//
//  Created by Jannes on May/10/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Team : NSObject
@property (nonatomic) int teamId;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* teamIconURL;
@property (nonatomic, strong) NSString* twitterHashTag;
@end
