//
//  LeftView.m
//  DrawerController
//
//  Created by wurui on 17/5/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "LeftView.h"

@interface LeftView ()

@end

@implementation LeftView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"LeftViewControl";
    self.view.backgroundColor = [UIColor orangeColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 250, 30, 30);
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)click {
    NSLog(@"点击了LeftView按钮");
}

@end
