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
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
+ (CGFloat)calculateHeightWithText:(NSString*)text font:(UIFont*)font width:(CGFloat)width;
@end
