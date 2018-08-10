//
//  RCMCDMainPageViewController.m
//  RCMCenterDemo
//
//  Created by Jue on 2018/6/20.
//  Copyright © 2018年 Jue. All rights reserved.
//

#import "RCMCDMainPageViewController.h"
#import "RCMCDemoViewController.h"
#import <RongMCenter/RCMCUtility.h>
#import <RongIMKit/RongIMKit.h>

#define IconWidth 24.f
#define UnreadCountWidth 8.f

@interface RCMCDMainPageViewController ()

@property (nonatomic, strong)UIScrollView *mainScrollView;

@property (nonatomic, strong)UIButton *envelopeBtn;

@end

@implementation RCMCDMainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1.f];
    [self.view addSubview:self.mainScrollView];
    self.mainScrollView.contentSize = CGSizeMake(0, 618 * (self.view.bounds.size.width / 375));
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveMessageNotification:)
                                                 name:RCKitDispatchMessageNotification
                                               object:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [[RCMCUtility sharedManager] addUnreadCount:_envelopeBtn viewWidth:IconWidth unreadCountWidth:UnreadCountWidth count:[[RCIMClient sharedRCIMClient] getTotalUnreadCount]];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIScrollView *)mainScrollView {
    if (_mainScrollView == nil) {
        _mainScrollView = [UIScrollView new];
        if (KIsiPhoneX) {
            _mainScrollView.frame = CGRectMake(0, -45, self.view.bounds.size.width, self.view.bounds.size.height);
        } else {
           _mainScrollView.frame = CGRectMake(0, -20, self.view.bounds.size.width, self.view.bounds.size.height);
        }
        
        _mainScrollView.userInteractionEnabled = YES;
        
        UIImageView *statusView = [UIImageView new];
        statusView.image = ImageFor(@"status_image");
        statusView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 20);
        statusView.backgroundColor = [UIColor colorWithRed:40 / 255.0 green:85 / 255.0 blue:187 / 255.0 alpha:1.f];
        [_mainScrollView addSubview:statusView];
        
        UIImageView *imageView = [UIImageView new];
        imageView.frame = CGRectMake(0, 20, self.view.bounds.size.width, 618 * (self.view.bounds.size.width / 375));
        imageView.image = ImageFor(@"main_page_image");
        imageView.userInteractionEnabled = YES;
        
        [imageView addSubview:self.envelopeBtn];
        
        [imageView
         addConstraints:[NSLayoutConstraint
                         constraintsWithVisualFormat:@"H:[_envelopeBtn(24)]-12-|"
                         options:0
                         metrics:nil
                         views:NSDictionaryOfVariableBindings(_envelopeBtn)]];
        
        [imageView
         addConstraints:[NSLayoutConstraint
                         constraintsWithVisualFormat:@"V:|-12-[_envelopeBtn(24)]"
                         options:0
                         metrics:nil
                         views:NSDictionaryOfVariableBindings(_envelopeBtn)]];
        
        [_mainScrollView addSubview:imageView];
    }
    return _mainScrollView;
}

-(UIButton *)envelopeBtn {
    if (_envelopeBtn == nil) {
        _envelopeBtn = [UIButton new];
        [_envelopeBtn setImage:ImageFor(@"envelope_white_default") forState:UIControlStateNormal];
        [_envelopeBtn setImage:ImageFor(@"envelope_white_touched") forState:UIControlStateHighlighted];
        [_envelopeBtn setImage:ImageFor(@"envelope_white_touched") forState:UIControlStateSelected];
        _envelopeBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [_envelopeBtn addTarget:self action:@selector(clickEnvelopeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [[RCMCUtility sharedManager] addUnreadCount:_envelopeBtn viewWidth:IconWidth unreadCountWidth:UnreadCountWidth count:[[RCIMClient sharedRCIMClient] getTotalUnreadCount]];
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
