//
//  TweetCell.h
//  myScoreBoard
//
//  Created by Jannes on Jun/7/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetCell : UITableViewCell
// Do NOT accidentally use the name textLabel. It will put you in a world of pain, because that will overwrite UITableViewCell's label
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

+ (CGFloat)calculateHeightWithText:(NSString*)text andTableView:(UITableView*)tableView;
@end
