//
//  MainView.h
//  DrawerController
//
//  Created by wurui on 17/5/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainView : UIViewController

@property (nonatomic, assign) CGFloat leftViewWidth;
@property (nonatomic, assign) CGFloat rightViewWidth;
/*开放导航栏左侧按钮*/
@property (nonatomic, strong) UIButton *centerViewLeftItemButton;
/*开放导航栏右侧按钮*/
@property (nonatomic, strong) UIButton *centerViewRightItemButton;

- (instancetype)initWithCenterViewController:(UIViewController *)centerViewController  leftDrawerViewController:(UIViewController *)leftDrawerViewController
    rightDrawerViewController:(UIViewController *)rightDrawerViewController;
- (instancetype)initWithCenterViewController:(UIViewController *)centerViewController leftDrawerViewController:(UIViewController *)leftDrawerViewController;
- (instancetype)initWithCenterViewController:(UIViewController *)centerViewController rightDrawerViewController:(UIViewController *)rightDrawerViewController;

@end
