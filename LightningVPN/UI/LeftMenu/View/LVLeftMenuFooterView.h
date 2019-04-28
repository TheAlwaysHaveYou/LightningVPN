//
//  LVLeftMenuFooterView.h
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/28.
//  Copyright © 2019 FKD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LVLeftMenuFooterViewDelegate <NSObject>

- (void)LVLeftMenuFooterViewFunctionAboutUS;

@end

@interface LVLeftMenuFooterView : UIView

@property (nonatomic , weak) id <LVLeftMenuFooterViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
