//
//  TweetCell.m
//  myScoreBoard
//
//  Created by Jannes on Jun/7/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell

// Creation from storyboard
- (void)awakeFromNib {
    [self setup];
}

// Creation from code
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setup];
    return self;
}

- (void)setup {
    UIImage* image = [[UIImage imageNamed:@"bg-cell-tweet-score"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 8, 9, 8)];
    self.backgroundView = [[UIImageView alloc] initWithImage:image];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // Add padding to the background image
    self.backgroundView.frame = CGRectInset(self.backgroundView.frame, 10, 5);
}

+ (CGFloat)calculateHeightWithText:(NSString*)text andTableView:(UITableView*)tableView {
    // These are the view's settings that we have set in the storyboard. Unfortunately it's too difficult to read those values from the storyboard so we just duplicate them
    UIFont* font = [UIFont systemFontOfSize:14];
    CGFloat marginLeft = 76;
    CGFloat marginTop = 33;
    CGFloat marginRight = 20;
    CGFloat marginBottom = 20;
    
    // Compute height with an infinite maximum height
    CGSize maxBounds = CGSizeMake(tableView.bounds.size.width - marginLeft - marginRight, CGFLOAT_MAX);
    CGSize size = [text sizeWithFont:font
                   constrainedToSize:maxBounds
                       lineBreakMode:NSLineBreakByWordWrapping];
    // Minimum height
    size.height = MAX(40, size.height);
    
    return size.height + marginTop + marginBottom;
}

@end
