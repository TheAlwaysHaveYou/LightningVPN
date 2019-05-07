//
//  KeyChainHelper.h
//  LightningVPN
//
//  Created by 范魁东 on 2019/5/7.
//  Copyright © 2019 FKD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyChainHelper : NSObject

+ (OSStatus)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (OSStatus)delete:(NSString *)service;

@end

NS_ASSUME_NONNULL_END
