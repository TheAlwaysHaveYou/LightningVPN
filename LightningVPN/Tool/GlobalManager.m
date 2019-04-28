//
//  GlobalManager.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/26.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "GlobalManager.h"

@implementation GlobalManager

+ (instancetype)sharedInstance {
    static GlobalManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GlobalManager alloc] init];
    });
    return manager;
}

@end
