//
//  RCMCDMeViewController.m
//  RCMCenterDemo
//
//  Created by Jue on 2018/6/20.
//  Copyright © 2018年 Jue. All rights reserved.
//

#import "RCMCDMeViewController.h"
#import "RCMCDemoViewController.h"
#import <RongMCenter/RCMCUtility.h>
#import <RongIMKit/RongIMKit.h>

#define IconWidth 24.f
#define UnreadCountWidth 8.f

@interface RCMCDMeViewController ()

@property (nonatomic, strong)UIScrollView *mainScrollView;

@property (nonatomic, strong)UIButton *envelopeBtn;

@end

@implementation RCMCDMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我";
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveMessageNotification:)
                                                 name:RCKitDispatchMessageNotification
                                               object:nil];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1.f];
    [self.view addSubview:self.mainScrollView];
    self.mainScrollView.contentSize = CGSizeMake(0, 553.5 * (self.view.bounds.size.width / 375));
    
    UIBarButtonItem *rightBtn = [UIBarButtonItem new];
    rightBtn.customView = self.envelopeBtn;
    self.navigationItem.rightBarButtonItem = rightBtn;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[RCMCUtility sharedManager] addUnreadCount:_envelopeBtn viewWidth:IconWidth unreadCountWidth:UnreadCountWidth count:[[RCIMClient sharedRCIMClient] getTotalUnreadCount]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIScrollView *)mainScrollView {
    if (_mainScrollView == nil) {
        _mainScrollView = [UIScrollView new];
        _mainScrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        
        UIImageView *imageView = [UIImageView new];
        imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 553.5 * (self.view.bounds.size.width / 375));
        imageView.image = ImageFor(@"me_image");
        
        [_mainScrollView addSubview:imageView];
    }
    return _mainScrollView;
}

- (UIButton *)envelopeBtn {
    if (_envelopeBtn == nil) {
        _envelopeBtn = [UIButton new];
        _envelopeBtn.frame = CGRectMake(0, 0, IconWidth, IconWidth);
        [_envelopeBtn setImage:ImageFor(@"envelope_blue_default") forState:UIControlStateNormal];
        [_envelopeBtn setImage:ImageFor(@"envelope_blue_touched") forState:UIControlStateHighlighted];
        [_envelopeBtn setImage:ImageFor(@"envelope_blue_touched") forState:UIControlStateSelected];
        _envelopeBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [_envelopeBtn addTarget:self action:@selector(clickEnvelopeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [[RCMCUtility sharedManager] addUnreadCount:self.envelopeBtn viewWidth:IconWidth unreadCountWidth:UnreadCountWidth count:[[RCIMClient sharedRCIMClient] getTotalUnreadCount]];
    }
    return _envelopeBtn;
}

- (void)clickEnvelopeBtn:(id)sender {
    RCMCDemoViewController *demoVC = [RCMCDemoViewController new];
    demoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:demoVC animated:YES];
}

- (void)didReceiveMessageNotification:(NSNotification *)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[RCMCUtility sharedManager] addUnreadCount:self.envelopeBtn viewWidth:IconWidth unreadCountWidth:UnreadCountWidth count:[[RCIMClient sharedRCIMClient] getTotalUnreadCount]];
    });
}


@end
