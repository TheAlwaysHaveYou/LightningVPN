//
//  LVMainGetFreeView.h
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/29.
//  Copyright © 2019 FKD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LVMainGetFreeView : UIView

- (void)changeContentViewBottom:(CGFloat)bottom;
- (void)recoverOriginFrame;

- (void)show;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
