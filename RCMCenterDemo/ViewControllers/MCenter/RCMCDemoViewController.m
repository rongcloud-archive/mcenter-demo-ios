//
//  RCMCDemoViewController.m
//  RCMCenterDemo
//
//  Created by Jue on 2018/7/13.
//  Copyright © 2018年 Jue. All rights reserved.
//

#import "RCMCDemoViewController.h"
#import "RCMCDChatViewController.h"

@interface RCMCDemoViewController ()<RCMCGotoMessageDisplayDelegate>

@end

@implementation RCMCDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.chatListVC.gotoMessageDisplayDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/**
 如需跳转到RCMCMessageDisplayViewController子类，重写这个方法。
 */
-(void)gotoChatView:(NSString *)targetId title:(NSString *)title {
    RCMCDChatViewController *chatVC = [RCMCDChatViewController new];
    chatVC.conversationType = ConversationType_SYSTEM;
    chatVC.targetId = targetId;
    chatVC.title = title;
    [self.navigationController pushViewController:chatVC animated:YES];
}

@end
