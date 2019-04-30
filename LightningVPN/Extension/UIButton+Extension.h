//
//  UIButton+Extension.h
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/29.
//  Copyright © 2019 FKD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger , ImageDirection) {
    TOP,
    LEFT,
    BOTTOM,
    RIGHT,
    CENTER
};

@interface UIButton (Extension)

// 设置按钮中 图片相对于文字的方向
- (void)setImageDirection:(ImageDirection)direction;
// span 图片和文字之间的间距
- (void)setImageDirection:(ImageDirection)direction withSpan:(float)span;

@end

NS_ASSUME_NONNULL_END
