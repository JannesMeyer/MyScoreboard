//
//  TwitterAPI.m
//  myScoreBoard
//
//  Created by Jannes on Jun/6/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "TwitterAPI.h"

#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <RestKit/RestKit.h>
#import "Models/Tweet.h"
#import "Util.h"

@implementation TwitterAPI

SINGLETON_GCD(TwitterAPI);

- (void)findTweetsForHashtag:(NSString*)searchTerms withCompletionHandler:(TWTweetsCompletionHandler)completion {
    // Describe RestKit object mapping
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[Tweet class]];
    [mapping addAttributeMappingsFromDictionary:@{
         @"user.id": @"userId",
         @"user.screen_name": @"userName",
         @"user.profile_image_url": @"thumbnailUrl",
         @"text": @"text"
    }];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                                                       pathPattern:@"/1.1/search/tweets.json"
                                                                                           keyPath:@"statuses"
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    // Request access to the Twitter accounts
    ACAccountStore* accountStore = [[ACAccountStore alloc] init];
    ACAccountType* accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError* error) {
        if (granted) {
            NSArray* twitterAccounts = [accountStore accountsWithAccountType:accountType];
            if ([twitterAccounts count] > 0) {
                // Use the most recently added Twitter account. Is this really a good idea with multiple accounts?
                ACAccount* twitterAccount = [twitterAccounts lastObject];
                
                // Create a request to get the tweets for a hashtag on Twitter
                NSDictionary* parameters = @{
                                             @"q": [searchTerms stringByAppendingString:@" exclude:retweets"]
//                                             @"lang": @"de",
//                                             @"result_type": @"recent"
                                            };
                SLRequest *twitterRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                               requestMethod:SLRequestMethodGET
                                                                         URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/search/tweets.json"]
                                                                  parameters:parameters];
                [twitterRequest setAccount:twitterAccount];
                
                // Log Twitter username
//                NSLog(@"Twitter Account configured: %@ %@", twitterAccount.username, [twitterAccount valueForKeyPath:@"properties.user_id"]);
                
                // Log response
//                [twitterRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
//                    NSString* response = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//                    NSLog(@"%@", response);
//                }];

                // Use RestKit to perform the request
                RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:[twitterRequest preparedURLRequest]
                                                                                    responseDescriptors:@[responseDescriptor]];
                // Completion handler on the UI thread
                [operation setSuccessCallbackQueue:dispatch_get_main_queue()];
                [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation* operation, RKMappingResult* results) {
                    completion([results array], nil);
                } failure:nil];
                
                // Do the request
                [operation start];
            } else {
                NSLog(@"No Twitter Account configured");
            }
        } else {
            NSLog(@"No Twitter Access Error");
        }
    }];
}
//    dispatch_async(dispatch_get_main_queue(), ^{
//    });
    
//    // Get the profile image in the original resolution
//    profileImageStringURL = [profileImageStringURL stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
//    [self getProfileImageForURLString:profileImageStringURL];
//    // Get the banner image, if the user has one
//    if (bannerImageStringURL) {
//        NSString *bannerURLString = [NSString stringWithFormat:@"%@/mobile_retina", bannerImageStringURL];
//        [self getBannerImageForURLString:bannerURLString];
//    } else {
//        bannerImageView.backgroundColor = [UIColor underPageBackgroundColor];
//    }

@end
