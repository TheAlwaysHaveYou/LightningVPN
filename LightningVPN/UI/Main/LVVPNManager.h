//
//  LVVPNManager.h
//  LightningVPN
//
//  Created by 范魁东 on 2019/5/8.
//  Copyright © 2019 FKD. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kConfigureSuccess @"kConfigureSuccess"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, VPNStatus){
    VPNStatus_off           = 0,//未连接
    VPNStatus_connecting    = 1,//正在连接
    VPNStatus_on            = 2,//连接成功
    VPNStatus_disconnecting = 3,//断开连接
    VPNStatus_fail          = 4,//连接失败
};

typedef NS_ENUM(NSInteger , VPNConnectRule) {
    VPNConnectRule_HaveRule = 0,//智能，有过滤规则
    VPNConnectRule_NoRule   = 1,//全局，所有流量都走VPN
};

@interface LVVPNManager : NSObject

@property (nonatomic , assign) VPNStatus VPNStatus;

@property (nonatomic , assign ) VPNConnectRule rule;

+ (instancetype)sharedInstance;

- (void)connect;
- (void)disconnect;

@end

NS_ASSUME_NONNULL_END
