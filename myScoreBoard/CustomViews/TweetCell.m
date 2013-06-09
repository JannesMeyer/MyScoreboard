//
//  TweetCell.m
//  myScoreBoard
//
//  Created by Jannes on Jun/7/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell

- (void)setup {
    UIImage* image = [[UIImage imageNamed:@"bg-cell-tweet-score"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 8, 9, 8)];
    self.backgroundView = [[UIImageView alloc] initWithImage:image];
}
- (void)awakeFromNib {
    [self setup];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setup];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // Add padding to the background image
    self.backgroundView.frame = CGRectInset(self.backgroundView.frame, 10, 5);
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//    // Configure the view for the selected state
//}

+ (CGFloat)calculateHeightWithText:(NSString*)text andTableView:(UITableView*)tableView {
    // View configuration
    UIFont* font = [UIFont systemFontOfSize:14];
    UIEdgeInsets margin = UIEdgeInsetsMake(43, 76, 21, 20);
    CGFloat width = tableView.bounds.size.width;
    
    // Compute height
    CGSize maxBounds = CGSizeMake(width - margin.left - margin.right, CGFLOAT_MAX);
    CGSize size = [text sizeWithFont:font
                   constrainedToSize:maxBounds
                       lineBreakMode:NSLineBreakByWordWrapping];
    
    return size.height + margin.top + margin.bottom;
}

@end
