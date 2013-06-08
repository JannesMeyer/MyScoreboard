//
//  TweetCell.m
//  myScoreBoard
//
//  Created by Jannes on Jun/7/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell

- (void)awakeFromNib {
    [self setup];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setup];
    return self;
}

- (void)setup {
    UIImage* image = [[UIImage imageNamed:@"bg-cell-tweet-score"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 8, 9, 8)];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
    self.backgroundView = imageView;
//    cell.selectedBackgroundView = cell.backgroundView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundView.frame = CGRectInset(self.backgroundView.frame, 10, 5);
//    self.textLabel.bounds = CGRectInset(self.textLabel.bounds, 5, 0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

+ (CGFloat)calculateHeightWithText:(NSString*)text font:(UIFont*)font width:(CGFloat)width {
    static CGFloat margin = 20;
    
    // Compute height
    CGSize maxBounds = CGSizeMake(width - 2 * margin, CGFLOAT_MAX);
    CGSize size = [text sizeWithFont:font
                   constrainedToSize:maxBounds
                       lineBreakMode:NSLineBreakByWordWrapping];
    // Minimum height
    CGFloat height = MAX(60, size.height);
    
    return height + 2 * margin;
}

@end
