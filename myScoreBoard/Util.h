//
//  Util.h
//  myScoreBoard
//
//  Created by Jannes on Jun/7/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * @function Singleton GCD macro
 */
#ifndef SINGLETON_GCD
#define SINGLETON_GCD(classname)                        \
+ (classname*)sharedInstance {                          \
    static dispatch_once_t token;                        \
    __strong static classname* _sharedInstance = nil;     \
    dispatch_once(&token, ^{                            \
        _sharedInstance = [[self alloc] init];\
    });        \
    return _sharedInstance;                               \
}
#endif


//static YourClassName * volatile sharedInstance = nil;

@interface Util : NSObject

@end
