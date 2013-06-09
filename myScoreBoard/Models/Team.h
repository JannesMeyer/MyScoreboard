//
//  Team.h
//  myScoreBoard
//
//  Created by Jannes on May/10/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Team : NSObject

@property (readonly, nonatomic) NSUInteger teamId;
@property (nonatomic) NSString* name;
@property (nonatomic) NSString* teamIconURL;
@property (nonatomic) NSArray* hashtags; // of NSString

// Designated initializer
- (id)initWithId:(int) teamId;
- (NSString*)hashtagsAsString;

@end
