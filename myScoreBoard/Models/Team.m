//
//  Team.m
//  myScoreBoard
//
//  Created by Jannes on May/10/13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "Team.h"

@implementation Team

- (id)initWithId:(int) teamId {
    self = [super init];
    if (self) {
        _teamId = teamId;
    }
    return self;
}

+ (NSDictionary*) hashtagMapping {
    return @{ @"1. FC Nürnberg": @[@"#fcn"],
              @"1. FSV Mainz 05": @[@"#fsv"],
              @"Bayer 04 Leverkusen": @[@"#bayer"],
              @"Bayern München": @[@"#fcb"],
              @"Borussia Dortmund": @[@"#bvb"],
              @"Borussia Mönchengladbach": @[@"#bmg"],
              @"Eintracht Frankfurt": @[@"#eintracht"],
              @"FC Augsburg": @[@"#FCAUGSBURG", @"#fca"],
              @"FC Schalke 04": @[@"#s04"],
              @"Fortuna Düsseldorf": @[@"#fortuna"],
              @"Hamburger SV": @[@"#hsv"],
              @"Hannover 96": @[@"#h96"],
              @"SC Freiburg": @[@"#scf"],
              @"SpVgg Greuther Fuerth": @[@"#sgf"],
              @"TSG 1899 Hoffenheim": @[@"hoffenheim"],
              @"VfB Stuttgart": @[@"#vfb"],
              @"VfL Wolfsburg": @[@"#vfl"],
              @"Werder Bremen": @[@"#svw", @"werder"] };
}

- (void)setName:(NSString *)name {
    _name = name;
    _hashtags = [[Team hashtagMapping] objectForKey:self.name];
}

- (NSString*)hashtagsAsString {
    return [self.hashtags componentsJoinedByString:@" "];
}

@end
