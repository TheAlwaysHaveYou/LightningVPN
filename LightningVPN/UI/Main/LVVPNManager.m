//
//  LVVPNManager.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/5/8.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "LVVPNManager.h"
#import <NetworkExtension/NetworkExtension.h>

@interface LVVPNManager ()

@property (nonatomic, assign) BOOL observerAdded;

@end

@implementation LVVPNManager

+ (instancetype)sharedInstance{
    static LVVPNManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LVVPNManager alloc] init];
    });
    return manager;
}

- (instancetype)init{
    if (self = [super init]) {
        //默认出事赋值
        self.observerAdded = NO;
        self.VPNStatus = VPNStatus_off;
        self.rule = VPNConnectRule_HaveRule;
        
        __weak typeof(self) weakself = self;
        [self loadProviderManager:^(NETunnelProviderManager *manager) {
            
            [weakself updateVPNStatus:manager];
        }];
        
        [self addVPNStatusObserver];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - public method
- (void)connect {
    [self loadAndCreatePrividerManager:^(NETunnelProviderManager *manager) {
        if (!manager) {
            return ;
        }
        NSError *error;
        [manager.connection startVPNTunnelAndReturnError:&error];
//        [manager.connection startVPNTunnelWithOptions:@{} andReturnError:&error];
        if (error) {
            NSLog(@"初始化出错-----%@",error);
        }else{
            NSLog(@"startVPNTunnel---OK");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self updateVPNStatus:manager];
            });
        }
    }];
}

- (void)disconnect {
    [self loadProviderManager:^(NETunnelProviderManager *manager) {
        [manager.connection stopVPNTunnel];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self updateVPNStatus:manager];
        });
    }];
}

#pragma mark - private method

- (void)loadProviderManager:(void(^)(NETunnelProviderManager *manager))pm {
    [NETunnelProviderManager loadAllFromPreferencesWithCompletionHandler:^(NSArray<NETunnelProviderManager *> * _Nullable managers, NSError * _Nullable error) {
        if (managers.count > 0) {
            pm(managers.firstObject);
            return ;
        }
        return pm(nil);
    }];
}

- (NETunnelProviderManager *)createProviderManager {
    NETunnelProviderManager *manager = [[NETunnelProviderManager alloc] init];
    NETunnelProviderProtocol *conf = [[NETunnelProviderProtocol alloc] init];
    conf.serverAddress = app_DisplayName;
    manager.protocolConfiguration = conf;
    manager.localizedDescription = app_DisplayName;
    return manager;
}

- (void)loadAndCreatePrividerManager:(void(^)(NETunnelProviderManager *manager))compelte {
    [NETunnelProviderManager loadAllFromPreferencesWithCompletionHandler:^(NSArray<NETunnelProviderManager *> * _Nullable managers, NSError * _Nullable error) {
        NETunnelProviderManager *manager = [[NETunnelProviderManager alloc] init];
        if (managers.count>0) {
            manager = managers.firstObject;
            if (managers.count>1) {
                for (NETunnelProviderManager* manager in managers) {
                    [manager removeFromPreferencesWithCompletionHandler:^(NSError * _Nullable error) {
                        if (error == nil) {
                            NSLog(@"remove dumplicate VPN config successful!");
                        }else {
                            NSLog(@"remove dumplicate VPN config failed with %@", error);
                        }
                    }];
                }
            }
        }else{
            manager = [self createProviderManager];
        }
        manager.enabled = YES;
        
        NSMutableDictionary *conf = @{}.mutableCopy;
        conf[@"ss_address"] = @"103.95.207.14";
        conf[@"ss_port"] = @9876;//注意是number值、、、
        conf[@"ss_method"] = @"AES256CFB";
        conf[@"ss_password"] = @"test";
        
        conf[@"ymal_conf"] = [self getRuleConf];
        NETunnelProviderProtocol *orignConf = (NETunnelProviderProtocol *)manager.protocolConfiguration;
        orignConf.providerConfiguration = conf;
        manager.protocolConfiguration = orignConf;
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kConfigureSuccess];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //保存 vpn 参数信息
        [manager saveToPreferencesWithCompletionHandler:^(NSError * _Nullable error) {
            if (error == nil) {
                [[NSUserDefaults standardUserDefaults] setValue:kConfigureSuccess forKey:kConfigureSuccess];
                [[NSUserDefaults standardUserDefaults] synchronize];

                
//                注意这里保存配置成功后，一定要再次load，否则会导致后面StartVPN出异常
                [manager loadFromPreferencesWithCompletionHandler:^(NSError * _Nullable error) {
                    if (error == nil) {
                        NSLog(@"保存vpn设置成功 success");
                        
                        compelte(manager);return;
                    }
                    compelte(nil);return;
                }];
            }else{
                compelte(nil);return;
            }
        }];
    }];
}

- (NSString *)getRuleConf {
    NSString * Path = [[NSBundle mainBundle] pathForResource:(VPNConnectRule_HaveRule == self.rule)?@"NEKitRule":@"NEKitNoRule" ofType:@"conf"];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:Path]];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark - tool

- (void)updateVPNStatus:(NEVPNManager *)manager {
    switch (manager.connection.status) {
        case NEVPNStatusConnected://已连接
            self.VPNStatus = VPNStatus_on;
            break;
        case NEVPNStatusConnecting://正在连接
            self.VPNStatus = VPNStatus_connecting;
            break;
        case NEVPNStatusReasserting://正在重新连接
            self.VPNStatus = VPNStatus_connecting;
            break;
        case NEVPNStatusDisconnecting://正在断开连接
            self.VPNStatus = VPNStatus_disconnecting;
            break;
        case NEVPNStatusDisconnected://未连接
            self.VPNStatus = VPNStatus_off;
            break;
        case NEVPNStatusInvalid://连接无效
            self.VPNStatus = VPNStatus_fail;
            break;
        default:
            break;
    }
}

- (void)addVPNStatusObserver {
    if (self.observerAdded) {
        return;
    }
    
    [self loadProviderManager:^(NETunnelProviderManager *manager) {
        if (manager) {
            self.observerAdded = YES;
            [[NSNotificationCenter defaultCenter] addObserverForName:NEVPNStatusDidChangeNotification
                                                              object:manager.connection
                                                               queue:[NSOperationQueue mainQueue]
                                                          usingBlock:^(NSNotification * _Nonnull note) {
                                                              [self updateVPNStatus:manager];
                                                          }];
        }
    }];
}

@end
