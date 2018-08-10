//
//  RCMCDMessageManager.h
//  RCMCenterDemo
//
//  Created by Jue on 2018/6/21.
//  Copyright © 2018年 Jue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMKit/RongIMKit.h>

@interface RCMCDMessageManager : NSObject

+ (instancetype)sharedManager;

- (void)registerMessageClass;

@end
