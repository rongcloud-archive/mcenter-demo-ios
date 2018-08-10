//
//  RCMCDMainTabBarViewController.m
//  RCMCenterDemo
//
//  Created by Jue on 2018/6/5.
//  Copyright © 2018年 Jue. All rights reserved.
//

#import "RCMCDMainTabBarViewController.h"
#import "RCMCDMeViewController.h"
#import "RCMCDMainPageViewController.h"
#import <RongMCenter/RCMCUtility.h>

@interface RCMCDMainTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation RCMCDMainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    [self setControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//默认选中最后一个tab
- (void)setControllers {
    RCMCDMainPageViewController *mainVC = [RCMCDMainPageViewController new];
   self.mainNav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    mainVC.title = @"主页";
    mainVC.tabBarItem.image = [ImageFor(@"main_tab_bar_main_page_default") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mainVC.tabBarItem.selectedImage = [ImageFor(@"main_tab_bar_main_page_selected") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIViewController *discoverVC2= [UIViewController new];
    discoverVC2.title = @"发现";
    discoverVC2.tabBarItem.image = [ImageFor(@"main_tab_bar_discover_default") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    discoverVC2.tabBarItem.selectedImage = [ImageFor(@"main_tab_bar_discover_selected") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    RCMCDMeViewController *meVC = [RCMCDMeViewController new];
    meVC.title = @"我的";
    meVC.tabBarItem.image = [ImageFor(@"main_tab_bar_me_default") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    meVC.tabBarItem.selectedImage = [ImageFor(@"main_tab_bar_me_selected") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *meNav = [[UINavigationController alloc] initWithRootViewController:meVC];
    
    NSMutableArray *VCArray = @[self.mainNav, discoverVC2, meNav].mutableCopy;
    
    self.viewControllers = [VCArray copy];
}

//前3个tab要求不能被点击
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0) {
    if ([viewController.title isEqualToString:@"发现"]) {
        return NO;
    }
    return YES;
}

@end
