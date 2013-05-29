//
//  NewCell.h
//  myScoreBoard
//
//  Created by Jannes on May/24/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchCell : UITableViewCell

- (void)setTeam1Name:(NSString *)team1Name;
- (void)setTeam2Name:(NSString *)team2Name;
- (void)setTeam1Score:(int)team1Score;
- (void)setTeam2Score:(int)team2Score;
- (void)setMinutes:(int)minutes;
- (void)setCommentCount:(int)commentCount;

@end
