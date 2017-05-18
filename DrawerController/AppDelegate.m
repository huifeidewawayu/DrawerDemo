//
//  AppDelegate.m
//  DrawerController
//
//  Created by wurui on 17/5/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "AppDelegate.h"
#import "MainView.h"
#import "CenterView.h"
#import "LeftView.h"

@interface AppDelegate ()

@property (nonatomic, strong) MainView *mainView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    LeftView *left = [[LeftView alloc] init];
    CenterView *center = [[CenterView alloc] init];
    UINavigationController *leftNa = [[UINavigationController alloc] initWithRootViewController:left];
    UINavigationController *centerNa = [[UINavigationController alloc] initWithRootViewController:center];
    self.mainView = [[MainView alloc] initWithCenterViewController:centerNa
                                          leftDrawerViewController:leftNa];
    self.mainView.leftViewWidth = 200;
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 30, 30);
    [leftButton setBackgroundColor:[UIColor whiteColor]];
    self.mainView.centerViewLeftItemButton = leftButton;
    
    self.window.rootViewController = self.mainView;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
