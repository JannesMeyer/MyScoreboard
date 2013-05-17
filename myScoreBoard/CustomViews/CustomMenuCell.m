//
//  CustomMenuCell.m
//  myScoreBoard
//
//  Created by Jannes on May/10/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "CustomMenuCell.h"

@interface CustomMenuCell()
@property (strong, nonatomic) UILabel* team1;
@end

@implementation CustomMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

        self.textLabel.hidden = true;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.categoryPic.image = [UIImage imageNamed:[self.catPics objectAtIndex:indexPath.row]];
        self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell-transparency"]];

        self.team1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 20)];
        self.team1.textColor = [UIColor whiteColor];
        self.team1.text = @"Test";
        self.team1.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.team1];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
