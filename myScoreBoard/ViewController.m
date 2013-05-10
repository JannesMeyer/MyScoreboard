//
//  ViewController.m
//  myScoreBoard
//
//  Created by Jannes Meyer on 03.05.13.
//  Copyright (c) 2013 28Apps. All rights reserved.
//

#import "ViewController.h"
#import "ScoreAPI.h"

@interface ViewController()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    ScoreAPI* api = [[ScoreAPI alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
