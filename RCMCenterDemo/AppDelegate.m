//
//  AppDelegate.m
//  RCMCenterDemo
//
//  Created by Jue on 2018/6/5.
//  Copyright © 2018年 Jue. All rights reserved.
//

#import "AppDelegate.h"
#import "RCMCDMainTabBarViewController.h"
#import <RongMCenter/RCMCenterKit.h>
#import "RCMCDMessageManager.h"
#import <RongMCenter/RCMCManager.h>
#import "RCMCDChatViewController.h"
#import <RongMCenter/RCML.h>

//生产环境
#define Appkey @"82hegw5u8y76x"
//当前连接的userId是MCTester，由于没有AppServer，所以token写死了。
#define MCTester_Token @"p231+cZXG2VzW+D7UpYmXF6rCy170azbkluZ+cdh/U74f94eExPm8SPWoUT4AZzoWpYi1LTJ1LCT/LmD+Lqo7A=="

@interface AppDelegate ()

@property (nonatomic, strong)RCMCDMainTabBarViewController *mainTabBarVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    self.mainTabBarVC = [RCMCDMainTabBarViewController new];
    self.window.rootViewController = self.mainTabBarVC;
    
    [self connectRongCloud];
    
    
    /**
     * 推送处理1
     */
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveMessageNotification:)
                                                 name:RCKitDispatchMessageNotification
                                               object:nil];
    
    /**
     * 推送处理1
     */
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, 用于iOS8以及iOS8之后的系统
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)
                                                categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
    // 远程推送的内容
    NSDictionary *remoteNotificationUserInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    
    [self clickNotificationEvent:remoteNotificationUserInfo];
    
    return YES;
}

/**
 * 推送处理2
 */
//注册用户通知设置
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    // register to receive notifications
    [application registerForRemoteNotifications];
}

/**
 * 推送处理3
 */
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""]
                        stringByReplacingOccurrencesOfString:@">"
                        withString:@""] stringByReplacingOccurrencesOfString:@" "
                       withString:@""];
    
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
#if TARGET_IPHONE_SIMULATOR
    // 模拟器不能使用远程推送
#else
    // 请检查App的APNs的权限设置，更多内容可以参考文档
    // http://www.rongcloud.cn/docs/ios_push.html。
    NSLog(@"获取DeviceToken失败！！！");
    NSLog(@"ERROR：%@", error);
#endif
}

/**
 * 推送处理4
 * userInfo内容请参考官网文档
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    /**
     * 统计推送打开率2
     */
    [[RCIMClient sharedRCIMClient] recordRemoteNotificationEvent:userInfo];
    /**
     * 获取融云推送服务扩展字段2
     */
    NSDictionary *pushServiceData = [[RCIMClient sharedRCIMClient] getPushExtraFromRemoteNotification:userInfo];
    if (pushServiceData) {
        NSLog(@"该远程推送包含来自融云的推送服务");
        for (id key in [pushServiceData allKeys]) {
            NSLog(@"key = %@, value = %@", key, pushServiceData[key]);
        }
    } else {
        NSLog(@"该远程推送不包含来自融云的推送服务");
    }
    
    
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [self clickNotificationEvent:notification.userInfo];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    RCConnectionStatus status = [[RCIMClient sharedRCIMClient] getConnectionStatus];
    if (status != ConnectionStatus_SignUp) {
        int unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
                                                                             @(ConversationType_PRIVATE), @(ConversationType_DISCUSSION), @(ConversationType_APPSERVICE),
                                                                             @(ConversationType_PUBLICSERVICE), @(ConversationType_GROUP), @(ConversationType_SYSTEM)
                                                                             ]];
        application.applicationIconBadgeNumber = unreadMsgCount;
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//融云SDK相关
- (void)connectRongCloud {
    [[RCIM sharedRCIM] initWithAppKey:Appkey];
    
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    
    [[RCIM sharedRCIM] connectWithToken:MCTester_Token success:^(NSString *userId) {
        NSLog(@"success");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self insertMessageForTheFirstTime];
        });
    } error:^(RCConnectErrorCode status) {
        NSLog(@"failed");
    } tokenIncorrect:^{
        NSLog(@"incorrect");
    }];
    
    [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
    [RCIM sharedRCIM].globalNavigationBarTintColor = [[UIColor alloc] initWithRed:6 / 255.f green:115 / 255.f blue:251 / 255.f alpha:1.f];
    
    //注册消息中心的消息
    [[RCMCDMessageManager sharedManager] registerMessageClass];
    
    //如果是第一次使用App，会插入两条消息，为了显示纵向的会话
//    [self insertMessageForTheFirstTime];
}

- (void)didReceiveMessageNotification:(NSNotification *)notification {
    NSNumber *left = [notification.userInfo objectForKey:@"left"];
    if ([RCIMClient sharedRCIMClient].sdkRunningMode == RCSDKRunningMode_Background && 0 == left.integerValue) {
        int unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
                                                                             @(ConversationType_PRIVATE), @(ConversationType_DISCUSSION), @(ConversationType_APPSERVICE),
                                                                             @(ConversationType_PUBLICSERVICE), @(ConversationType_GROUP), @(ConversationType_SYSTEM)
                                                                             ]];
        dispatch_async(dispatch_get_main_queue(),^{
            [UIApplication sharedApplication].applicationIconBadgeNumber = unreadMsgCount;
        });
    }
}

- (void)clickNotificationEvent:(NSDictionary*)userInfo{
    if (userInfo && userInfo[@"rc"] && [userInfo[@"rc"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *rcContent = userInfo[@"rc"];
        if (rcContent[@"cType"] && [rcContent[@"cType"] isEqual:@"SYS"]) {
            BOOL isMCenterTargetId = NO;
            for (NSString *targetId in [RCMCManager sharedManager].senderUserIdList) {
                if ([targetId isEqualToString: rcContent[@"tId"]]) {
                    RCMCDChatViewController *vc = [[RCMCDChatViewController alloc] initWithConversationType:ConversationType_SYSTEM targetId:rcContent[@"tId"]];
                    [self gotoVC:vc title:[[RCIM sharedRCIM] getUserInfoCache:rcContent[@"tId"]].name];
                    isMCenterTargetId = YES;
                    break;
                }
            }
            if (isMCenterTargetId == NO) {
                RCConversationViewController *vc = [[RCConversationViewController alloc] initWithConversationType:ConversationType_SYSTEM targetId:rcContent[@"tId"]];
                [self gotoVC:vc title:[[RCIM sharedRCIM] getUserInfoCache:rcContent[@"tId"]].name];
            }
        } else {
            RCConversationType conversationType = CoversationType_INVALID;
            if ([rcContent[@"cType"] isEqual:@"PR"]) {
                conversationType = ConversationType_PRIVATE;
            } else if ([rcContent[@"cType"] isEqual:@"GRP"]) {
                conversationType = ConversationType_GROUP;
            } else if ([rcContent[@"cType"] isEqual:@"CS"]) {
                conversationType = ConversationType_CUSTOMERSERVICE;
            } else if ([rcContent[@"cType"] isEqual:@"DS"]) {
                conversationType = ConversationType_DISCUSSION;
            }
            RCConversationViewController *vc = [[RCConversationViewController alloc] initWithConversationType:conversationType targetId:rcContent[@"tId"]];
            [self gotoVC:vc title:[[RCIM sharedRCIM] getUserInfoCache:rcContent[@"tId"]].name];
        }
    }
}

- (void)gotoVC:(RCConversationViewController *)targetVC title:(NSString *)title{
    targetVC.title = title;
    targetVC.hidesBottomBarWhenPushed = YES;
    self.mainTabBarVC.mainNav.navigationBar.backgroundColor = [UIColor whiteColor];
    [self.mainTabBarVC.mainNav pushViewController:targetVC animated:YES];
}

- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        NSLog(@"您当前登录的账号同时在别的移动设备上已登录，您已断开连接。");
    }
}

- (void)insertMessageForTheFirstTime {
    NSArray *VUsers = [RCMCManager sharedManager].VUsers;
    NSArray *conversations = [[RCIMClient sharedRCIMClient] getConversationList:@[@(ConversationType_SYSTEM)]];
    if (conversations.count == 0) {
        [self insertMessages];
    }
    else if (VUsers.count > 0 && conversations.count > 0) {
        BOOL isNeedInsert = YES;
        for (NSDictionary *userInfo in VUsers) {
            NSString *targetId = userInfo[@"id"];
            for (RCConversation *conversation in conversations) {
                if ([conversation.targetId isEqualToString:targetId]) {
                    isNeedInsert = NO;
                    break;
                }
            }
            if (isNeedInsert == NO) {
                break;
            }
        }
        if (isNeedInsert == YES) {
            [self insertMessages];
        }
    }
}

- (void)insertMessages {
    RCMLInteractionLiked *likedMessage = [RCMLInteractionLiked new];
    likedMessage.opreatorName = @"小胖";
    likedMessage.opreatorPortraitUrl = @"https://rongcloud-res.cn.ronghub.com/70cb59b054e5e7587ea1750adf074849";
    likedMessage.contentUrl = @"http://www.rongcloud.cn";
    [[RCIMClient sharedRCIMClient] insertIncomingMessage:ConversationType_SYSTEM targetId:@"rong_system_interaction" senderUserId:@"rong_system_interaction" receivedStatus:ReceivedStatus_READ content:likedMessage];
    
    RCMLCommunityHelpInfo *helpInfoMessage = [RCMLCommunityHelpInfo new];
    helpInfoMessage.opreatorName = @"小胖";
    helpInfoMessage.opreatorPortraitUrl = @"https://rongcloud-res.cn.ronghub.com/70cb59b054e5e7587ea1750adf074849";
    helpInfoMessage.contentUrl = @"http://www.rongcloud.cn";
    helpInfoMessage.content = @"有个问题向你求助：小唐山 有停车位吗？";
    [[RCIMClient sharedRCIMClient] insertIncomingMessage:ConversationType_SYSTEM targetId:@"rong_system_community" senderUserId:@"rong_system_community" receivedStatus:ReceivedStatus_READ content:helpInfoMessage];
}

@end
