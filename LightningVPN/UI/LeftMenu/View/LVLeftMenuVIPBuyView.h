//
//  LVLeftMenuVIPBuyView.h
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/29.
//  Copyright © 2019 FKD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LVLeftMenuVIPBuyModel.h"

NS_ASSUME_NONNULL_BEGIN

@class LVLeftMenuVIPBuyView;
@protocol LVLeftMenuVIPBuyViewDelegate <NSObject>

- (void)LVLeftMenuVIPBuyView:(LVLeftMenuVIPBuyView *)view didSelectedBuyModel:(LVLeftMenuVIPBuyModel *)model;

@end

@interface LVLeftMenuVIPBuyView : UIView

@property (nonatomic , weak) id <LVLeftMenuVIPBuyViewDelegate> delegate;

- (void)show;

- (void)dismiss;

@end

@interface LVLeftMenuVIPTypeView : UIControl

@property (nonatomic , strong) LVLeftMenuVIPBuyModel *model;

@end

NS_ASSUME_NONNULL_END
