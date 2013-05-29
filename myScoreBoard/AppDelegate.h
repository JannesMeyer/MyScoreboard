//
//  AppDelegate.h
//  myScoreBoard
//
//  Created by Jannes Meyer on 03.05.13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreAPI.h"
#import "MatchGroup.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic) UIWindow *window;
// API handle
@property (readonly, nonatomic) id <ScoreAPI> api;
@property (readonly, nonatomic) MatchGroup* matchgroup;

@end
