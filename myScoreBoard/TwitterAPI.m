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

- (void)findTweetsForSearchTerms:(NSArray*)searchTerms withCompletionHandler:(TweetsCompletionHandler)completion {
    // Describe the RestKit object mapping
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[Tweet class]];
    [mapping addAttributeMappingsFromDictionary:@{
         @"user.id":                @"userId",
         @"user.screen_name":       @"userName",
         @"user.profile_image_url": @"thumbnailUrl",
         @"text":                   @"text"
    }];
    RKResponseDescriptor* responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                                                       pathPattern:@"/1.1/search/tweets.json"
                                                                                           keyPath:@"statuses"
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    // Request access to iOS's Twitter accounts
    ACAccountStore* accountStore = [[ACAccountStore alloc] init];
    ACAccountType* accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError* error) {
        if (granted) {
            NSArray* twitterAccounts = [accountStore accountsWithAccountType:accountType];
            if ([twitterAccounts count] > 0) {
                // Use the most recently added Twitter account. Is this really a good idea with multiple accounts?
                ACAccount* twitterAccount = [twitterAccounts lastObject];
                // Twitter user id
                //[twitterAccount valueForKeyPath:@"properties.user_id"]
                
                // Figure out what the search terms are
                NSString* q;
                if ([searchTerms count] == 1) {
                    q = searchTerms[0];
                } else if ([searchTerms count] == 2) {
                    q = [NSString stringWithFormat:@"(%@ OR %@)", searchTerms[0], searchTerms[1]];
                } else {
                    // I don't even know how to deal with this shit. Return immediately.
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(@[], [[NSError alloc] initWithDomain:@"Twitter" code:400 userInfo:nil]);
                    });
                    return;
                }
                
                // Prepare a search request to get the tweets
                NSDictionary* parameters = @{ @"q": [q stringByAppendingString:@" exclude:retweets"],
                                              //@"lang": @"de",
                                              @"result_type": @"recent"
                                            };
                SLRequest* twitterRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                               requestMethod:SLRequestMethodGET
                                                                         URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/search/tweets.json"]
                                                                  parameters:parameters];
                [twitterRequest setAccount:twitterAccount];

                // Use RestKit to perform the request
                RKObjectRequestOperation* operation = [[RKObjectRequestOperation alloc] initWithRequest:[twitterRequest preparedURLRequest]
                                                                                    responseDescriptors:@[responseDescriptor]];

                // Set the completion handler to be executed on the main thread
                [operation setSuccessCallbackQueue:dispatch_get_main_queue()];
                [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation* operation, RKMappingResult* results) {
                    completion([results array], nil);
                } failure:nil];
                
                // Perform the request
                [operation start];
            } else {
                NSLog(@"No Twitter account configured");
            }
        } else {
            NSLog(@"No Twitter access");
        }
    }];
}

@end
