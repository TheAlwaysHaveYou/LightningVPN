//
//  LVLeftMenuHeaderView.h
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/26.
//  Copyright © 2019 FKD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LVLeftMenuHeaderViewDelegate <NSObject>

- (void)LVLeftMenuHeaderViewUpMemberShip;

@end


@interface LVLeftMenuHeaderView : UIView

@property (nonatomic , weak) id <LVLeftMenuHeaderViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
