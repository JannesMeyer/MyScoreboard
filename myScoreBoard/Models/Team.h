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
@property (nonatomic) NSString* name;
@property (nonatomic) NSString* teamIconURL;
@property (nonatomic) NSString* twitterHashTag;

- (id)initWithId:(int) teamId andName:(NSString*) name;

@end
