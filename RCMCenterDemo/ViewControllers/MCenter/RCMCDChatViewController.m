//
//  RCMCDChatViewController.m
//  RCMCenterDemo
//
//  Created by Jue on 2018/6/6.
//  Copyright © 2018年 Jue. All rights reserved.
//

#import "RCMCDChatViewController.h"
#import <SafariServices/SafariServices.h>
#import <RongMCenter/RCMCenterKit.h>
#import "RCMCDMessageManager.h"

@interface RCMCDChatViewController ()

@end

@implementation RCMCDChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didTapUrlInMessageCell:(NSString *)url model:(RCMessageModel *)model {
    if ([self checkIsHttpUrl:url]) {
        [self openUrl:url];
    }
}

- (void)openUrl:(NSString *)url {
    NSURL *finalUrl = [NSURL URLWithString:url];
    if (finalUrl == nil) {
        NSLog(@"url地址有误");
        return;
    }
    UIViewController *viewController = nil;
    if (![RCIM sharedRCIM].embeddedWebViewPreferred && ([[[UIDevice currentDevice] systemVersion] compare:@"9.0" options:NSNumericSearch] != NSOrderedAscending)) {
        if (@available(iOS 9.0, *)) {
            viewController = [[SFSafariViewController alloc] initWithURL:finalUrl];
        } else {
            // Fallback on earlier versions
        }
    } else {
        viewController = [[RCIMClient sharedRCIMClient] getPublicServiceWebViewController:url];
        [viewController setValue:[RCIM sharedRCIM].globalNavigationBarTintColor forKey:@"backButtonTextColor"];
    }
    [self didTapImageTxtMsgCell:url webViewController:viewController];
}

- (void)didTapImageTxtMsgCell:(NSString *)tapedUrl webViewController:(UIViewController *)rcWebViewController {
    if (@available(iOS 9.0, *)) {
        if ([rcWebViewController isKindOfClass:[SFSafariViewController class]]) {
            [self presentViewController:rcWebViewController animated:YES completion:nil];
        } else {
            UIWindow *window = [[UIApplication sharedApplication] delegate].window;
            UINavigationController *navigationController = (UINavigationController *)window.rootViewController;
            [navigationController pushViewController:rcWebViewController animated:YES];
        }
    } else {
        // Fallback on earlier versions
    }
}

- (BOOL)checkIsHttpUrl:(NSString *)url {
    BOOL isHttpUrl = NO;
    if ([[url lowercaseString] hasPrefix:@"http://"] || [[url lowercaseString] hasPrefix:@"https://"]) {
        isHttpUrl = YES;
    }
    return isHttpUrl;
}

@end
