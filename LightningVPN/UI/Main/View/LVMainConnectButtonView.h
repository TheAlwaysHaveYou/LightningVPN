//
//  LVMainConnectButtonView.h
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/28.
//  Copyright © 2019 FKD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger , LVConnectStatus) {
    LVConnectStatus_normal  = 0,//默认
    LVConnectStatus_ing     = 1,//连接中
    LVConnectStatus_success = 2,//链接成功
    LVConnectStatus_fail    = 3,//链接失败
};

@class LVMainConnectButtonView;
@protocol LVMainConnectButtonViewDelegate <NSObject>

- (void)LVMainConnectButtonView:(LVMainConnectButtonView *)connectView clickWithStatus:(LVConnectStatus)status;

@end

@interface LVMainConnectButtonView : UIView

@property (nonatomic , weak) id <LVMainConnectButtonViewDelegate> delegate;

@property (nonatomic , assign) LVConnectStatus status;



@end

NS_ASSUME_NONNULL_END
