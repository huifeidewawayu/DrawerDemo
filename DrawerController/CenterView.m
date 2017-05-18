//
//  CenterView.m
//  DrawerController
//
//  Created by wurui on 17/5/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "CenterView.h"

@interface CenterView ()

@end

@implementation CenterView
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(100, 250, 30, 30);
    [_button setBackgroundColor:[UIColor redColor]];
    [_button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
}

- (void)click {
    NSLog(@"点击了CenterView的按钮");
}

@end
