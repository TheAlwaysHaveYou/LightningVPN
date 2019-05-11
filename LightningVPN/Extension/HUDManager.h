//
//  HUDManager.h
//  LightningVPN
//
//  Created by 范魁东 on 2019/5/11.
//  Copyright © 2019 FKD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HUDManager : NSObject

+ (instancetype)sharedInstance;

- (void)show;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
