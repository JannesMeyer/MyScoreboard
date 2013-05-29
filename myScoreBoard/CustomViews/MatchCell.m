//
//  NewCell.m
//  myScoreBoard
//
//  Created by Jannes on May/24/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "MatchCell.h"

@interface MatchCell()
@property (weak, nonatomic) IBOutlet UILabel *team1NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *team2NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *team1ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *team2ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *minutesLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;

@end

@implementation MatchCell

- (void)setTeam1Name:(NSString *)team1Name {
    self.team1NameLabel.text = team1Name;
}
- (void)setTeam2Name:(NSString *)team2Name {
    self.team2NameLabel.text = team2Name;
}
- (void)setTeam1Score:(int)team1Score {
    self.team1ScoreLabel.text = [NSString stringWithFormat:@"%d", team1Score];
}
- (void)setTeam2Score:(int)team2Score {
    self.team2ScoreLabel.text = [NSString stringWithFormat:@"%d", team2Score];
}
- (void)setMinutes:(int)minutes {
    self.minutesLabel.text = [NSString stringWithFormat:@"%d", minutes];
}
- (void)setCommentCount:(int)commentCount {
    self.commentCountLabel.text = [NSString stringWithFormat:@"%d", commentCount];
}

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];
//    // Configure the view for the selected state
//}

@end
