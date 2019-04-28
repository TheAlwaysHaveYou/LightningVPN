//
//  LVMainNavigationView.h
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/26.
//  Copyright © 2019 FKD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LVMainNavigationViewDelegate <NSObject>

- (void)LVMainNavigationViewShowLeftMenuController;

@end

@interface LVMainNavigationView : UIView

@property (nonatomic , weak) id <LVMainNavigationViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
