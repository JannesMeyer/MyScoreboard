//
//  TweetCell.h
//  myScoreBoard
//
//  Created by Jannes on Jun/7/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *avatar;
// Do not ever overwrite the property textLabel. It will put you in a world of pain.
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
+ (CGFloat)calculateHeightWithText:(NSString*)text font:(UIFont*)font width:(CGFloat)width;
@end
