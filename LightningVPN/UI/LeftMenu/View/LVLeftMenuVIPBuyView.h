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

@interface LVLeftMenuVIPBuyView : UIView


- (void)show;

- (void)dismiss;

@end

@interface LVLeftMenuVIPTypeView : UIControl

@property (nonatomic , strong) LVLeftMenuVIPBuyModel *model;

@end

NS_ASSUME_NONNULL_END
