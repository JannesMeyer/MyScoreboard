//
//  AppDelegate.m
//  myScoreBoard
//
//  Created by Artur Malek on 03.05.13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "AppDelegate.h"
#import "OpenLigaScoreAPI.h"
#import "DummyScoreAPI.h"

@interface AppDelegate()
@property (readwrite, nonatomic) bool dummyApiEnabled;
@property (readwrite, nonatomic) id<ScoreAPI> api;
@property (readwrite, nonatomic) MatchGroup* matchgroup;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Detect whether to use dummy data or live data
    NSArray* args = [[NSProcessInfo processInfo] arguments];
    self.dummyApiEnabled = [args[1] isEqual: @"UseDummyApi"];

    return YES;
}

// Lazy instantiation of the API socket
- (id<ScoreAPI>)api {
    if (!_api) {
        if (self.dummyApiEnabled) {
            _api = [[DummyScoreAPI alloc] init];
        } else {
            _api = [[OpenLigaScoreAPI alloc] init];
        }
    }
    return _api;
}

// Lazy instantiation of the MatchGroup
- (MatchGroup*)matchgroup {
    if (!_matchgroup) _matchgroup = [self.api getMatchesForMatchday];
    return _matchgroup;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
