//
//  AppDelegate.h
//  myScoreBoard
//
//  Created by Artur Malek on 03.05.13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreAPIProtocol.h"
#import "MatchGroup.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic) UIWindow *window;
// API
@property (readonly, nonatomic) id<ScoreAPIProtocol> api;
@property (readonly, nonatomic) MatchGroup* matchgroup;

@end
