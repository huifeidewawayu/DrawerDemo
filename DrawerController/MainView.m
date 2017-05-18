//
//  MainView.m
//  DrawerController
//
//  Created by wurui on 17/5/10.
//  Copyright © 2017年 wurui. All rights reserved.
//
#import "MainView.h"

#define halfOfLeftViewWidth   (self.leftViewWidth / 2)

@interface MainView ()

@property (nonatomic, strong) UIViewController *centerView;
@property (nonatomic, strong) UIViewController *leftView;
@property (nonatomic, strong) UIViewController *rightView;
//用来标记菜单是否打开
@property(nonatomic,assign) BOOL isShowLeftView;

@end

@implementation MainView
-(instancetype)initWithCenterViewController:(UIViewController *)centerViewController leftDrawerViewController:(UIViewController *)leftDrawerViewController
    rightDrawerViewController:(UIViewController *)rightDrawerViewController {
    self = [super init];
    if (self) {
        [self setCenterViewController:centerViewController];
        [self setLeftViewController:leftDrawerViewController];
        [self setRightViewController:rightDrawerViewController];
    }
    return self;
}

-(instancetype)initWithCenterViewController:(UIViewController *)centerViewController leftDrawerViewController:(UIViewController *)leftDrawerViewController {
    self.isShowLeftView = NO;
    return [self initWithCenterViewController:centerViewController leftDrawerViewController:leftDrawerViewController rightDrawerViewController:nil];
}

- (instancetype)initWithCenterViewController:(UIViewController *)centerViewController rightDrawerViewController:(UIViewController *)rightDrawerViewController {
    return [self initWithCenterViewController:centerViewController leftDrawerViewController:nil rightDrawerViewController:rightDrawerViewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doLeftRightAction:)];
    [self.centerView.view addGestureRecognizer:panGesture];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doCenterAction:)];
    [self.centerView.view addGestureRecognizer:tapGesture];
}

- (void)setCenterViewController:(UIViewController *)centerView {
    self.centerView = centerView;
    if (self.centerView) {
        self.centerView.view.frame = self.view.bounds;
        [self.view addSubview:self.centerView.view];
    }
}

- (void)setLeftViewController:(UIViewController *)leftView {
    self.leftView = leftView;
    if (self.leftView) {
        [self.view insertSubview:self.leftView.view atIndex:0];
    }
}

- (void)setRightViewController:(UIViewController *)rightView {
    
}

#pragma mark  --- 遍历父视图上的子视图
- (void)sendLeftScroll {
    for (UIView *subView in self.centerView.view.subviews) {
        subView.userInteractionEnabled = YES;
    }
}

- (void)sendRightScroll {
    for (UIView *subView in self.centerView.view.subviews) {
        subView.userInteractionEnabled = NO;
    }
}

#pragma mark  --- Action
- (void)doLeftRightAction:(UIPanGestureRecognizer *)pan {
    //  手指在视图上移动产生的相对点
    CGPoint movePoint = [pan translationInView:self.centerView.view];
    UIView *centerView = self.centerView.view;
    UIView *leftView = self.leftView.view;
    centerView.center = CGPointMake(centerView.center.x + movePoint.x, self.view.center.y);
    CGFloat leftViewContentOffset_X = centerView.frame.origin.x / 2;
    leftView.transform = CGAffineTransformMakeTranslation(leftViewContentOffset_X, 0);
    if (self.isShowLeftView == 0 || self.isShowLeftView == 1) {
        if (centerView.center.x >= self.view.center.x + self.leftViewWidth) {
            centerView.center = CGPointMake(self.view.center.x + self.leftViewWidth, self.view.center.y);
            leftView.transform = CGAffineTransformMakeTranslation(halfOfLeftViewWidth, 0);
        }
        if (centerView.center.x <= self.view.center.x) {
            centerView.center = CGPointMake(self.view.center.x, self.view.center.y);
        }
        if (pan.state == UIGestureRecognizerStateBegan) {
            self.leftView.view.userInteractionEnabled = NO;
        }
        if (pan.state == UIGestureRecognizerStateEnded) {
            self.leftView.view.userInteractionEnabled = YES;
            if (centerView.center.x <= self.view.center.x + halfOfLeftViewWidth) {
                [UIView animateWithDuration:0.15 animations:^{
                    centerView.center = CGPointMake(self.view.center.x, self.view.center.y);
                    leftView.transform = CGAffineTransformMakeTranslation(-halfOfLeftViewWidth, 0);
                }];
                self.isShowLeftView = NO;
                [self sendLeftScroll];
            } else {
                [UIView animateWithDuration:0.15 animations:^{
                    centerView.center = CGPointMake(self.view.center.x + self.leftViewWidth, self.view.center.y);
                    leftView.transform = CGAffineTransformMakeTranslation(halfOfLeftViewWidth, 0);
                }];
                self.isShowLeftView = YES;
                [self sendRightScroll];
            }
        }
    }
        //  每次移动过后要置零
    [pan setTranslation:CGPointZero inView:self.centerView.view];
}

#pragma mark   点击中间视图的方法
- (void)doCenterAction:(UITapGestureRecognizer *)tap {
    [UIView animateWithDuration:0.3 animations:^{
        self.centerView.view.center = self.view.center;
        self.leftView.view.transform = CGAffineTransformMakeTranslation(-halfOfLeftViewWidth, 0);
    }];
    [self sendLeftScroll];
    self.isShowLeftView = NO;
}

#pragma mark   点击按钮弹出左视图方法
- (void)showLeftView {
    UIView *left = self.leftView.view;
    CGRect centerFrame = self.centerView.view.frame;
    if (self.isShowLeftView == NO) {
        centerFrame.origin.x = self.leftViewWidth;
        [UIView animateWithDuration:0.3 animations:^{
            self.centerView.view.frame = centerFrame;
            left.transform = CGAffineTransformMakeTranslation(halfOfLeftViewWidth, 0);
        }];
        self.isShowLeftView = YES;
        [self sendRightScroll];
    }else{
        centerFrame.origin.x = 0;
        [UIView animateWithDuration:0.3 animations:^{
            self.centerView.view.frame = centerFrame;
            left.transform = CGAffineTransformMakeTranslation(-halfOfLeftViewWidth, 0);
        }];
        self.isShowLeftView = NO;
        [self sendLeftScroll];
    }
}

#pragma mark  --- setter & getter
- (void)setLeftViewWidth:(CGFloat)leftViewWidth {
    _leftViewWidth = leftViewWidth;
    self.leftView.view.frame = CGRectMake(-halfOfLeftViewWidth, 0, leftViewWidth, self.view.frame.size.height);
}

- (void)setCenterViewLeftItemButton:(UIButton *)centerViewLeftItemButton {
    _centerViewLeftItemButton = centerViewLeftItemButton;
    [_centerViewLeftItemButton addTarget:self action:@selector(showLeftView) forControlEvents:UIControlEventTouchUpInside];
    if ([self.centerView isKindOfClass:[UINavigationController class]]) {
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_centerViewLeftItemButton];
        UINavigationController *centerNa = (UINavigationController *)self.centerView;
        UIViewController *centerCo = [[centerNa viewControllers]objectAtIndex:0];
        centerCo.navigationItem.leftBarButtonItem = leftButton;
    }
}

@end
