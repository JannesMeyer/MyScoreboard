//
//  XMLConnectionStub.h
//  myScoreBoard
//
//  Created by stud on 17.05.13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLConnectionStub : NSObject

@property (strong, nonatomic) NSData* webData;
@property (strong, nonatomic) NSString* xmlResponse;



- (NSString* ) getSOAPResponse: (NSString*) completeString AndNamespace: (NSString*) nameSpace;

@end
