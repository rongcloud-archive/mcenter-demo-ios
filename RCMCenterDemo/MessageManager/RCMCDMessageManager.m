//
//  RCMCDMessageManager.m
//  RCMCenterDemo
//
//  Created by Jue on 2018/6/21.
//  Copyright © 2018年 Jue. All rights reserved.
//


#import "RCMCDMessageManager.h"
#import <RongMCenter/RCML.h>

@implementation RCMCDMessageManager

+ (instancetype)sharedManager {
    static RCMCDMessageManager *pManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pManager = [[[self class] alloc] init];
    });
    return pManager;
}

- (void)registerMessageClass {
    [[RCIM sharedRCIM] registerMessageType:[RCMLInteractionComment class]];
    [[RCIM sharedRCIM] registerMessageType:[RCMLInteractionFollowed class]];
    [[RCIM sharedRCIM] registerMessageType:[RCMLInteractionLiked class]];
    [[RCIM sharedRCIM] registerMessageType:[RCMLWelfareGift class]];
    [[RCIM sharedRCIM] registerMessageType:[RCMLWelfareRedPacket class]];
    [[RCIM sharedRCIM] registerMessageType:[RCMLOfficialUpgrade class]];
    [[RCIM sharedRCIM] registerMessageType:[RCMLOfficialEvent class]];
    [[RCIM sharedRCIM] registerMessageType:[RCMLOfficialWelcomeImgTxt class]];
    [[RCIM sharedRCIM] registerMessageType:[RCMLOfficialMaintenance class]];
    [[RCIM sharedRCIM] registerMessageType:[RCMLOfficialWelcomeTxt class]];
    [[RCIM sharedRCIM] registerMessageType:[RCMLOfficialHelpTxt class]];
    [[RCIM sharedRCIM] registerMessageType:[RCMLOfficialHelpImgTxt class]];
    [[RCIM sharedRCIM] registerMessageType:[RCMLInteractionAwaken class]];
    [[RCIM sharedRCIM] registerMessageType:[RCMLInteractionStartLive class]];
    [[RCIM sharedRCIM] registerMessageType:[RCMLTradingOrderProcessing class]];
    [[RCIM sharedRCIM] registerMessageType:[RCMLTradingOrderFailed class]];
    [[RCIM sharedRCIM] registerMessageType:[RCMLTradingOrderSuccess class]];
    [[RCIM sharedRCIM] registerMessageType:[RCMLTradingNotPaid class]];
    [[RCIM sharedRCIM] registerMessageType:[RCMLTradingPaid class]];
    [[RCIM sharedRCIM] registerMessageType:[RCMLTradingOrderDistribution class]];
    [[RCIM sharedRCIM] registerMessageType:[RCMLTradingOrderCompleteAndComment class]];
    [[RCIM sharedRCIM] registerMessageType:[RCMLOfficialDiscountsExpire class]];
    [[RCIM sharedRCIM] registerMessageType:[RCMLOfficialNews class]];
    [[RCIM sharedRCIM] registerMessageType:[RCMLCommunityHelpInfo class]];
}

@end
