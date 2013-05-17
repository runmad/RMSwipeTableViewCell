//
//  RMSecondViewController.m
//  RMSwipeTableView
//
//  Created by Rune Madsen on 2013-05-17.
//  Copyright (c) 2013 The App Boutique. All rights reserved.
//

#import "RMSecondViewController.h"

@interface RMSecondViewController ()

@end

@implementation RMSecondViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1];
        [self.navigationItem setTitle:@"Second View"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
