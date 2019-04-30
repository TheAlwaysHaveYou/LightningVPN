//
//  LVMainLineSelecteView.h
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/28.
//  Copyright © 2019 FKD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LVMainLineModel.h"

NS_ASSUME_NONNULL_BEGIN

@class LVMainLineSelecteView;
@protocol LVMainLineSelecteViewDelegate <NSObject>
//传递弹出过程中Y的比例，用来改变蒙版的透明度
- (void)LVMainLineSelecteView:(LVMainLineSelecteView *)view frameYChangePercent:(CGFloat)percent;

@end

@interface LVMainLineSelecteView : UIView

@property (nonatomic , weak) id <LVMainLineSelecteViewDelegate> delegate;

@property (nonatomic , assign , getter=isShow) BOOL show;

- (void)show;

- (void)dismiss;


@end

@interface LVMainLineSelecteHeaderView : UITableViewHeaderFooterView

@property (nonatomic , assign) NSInteger section;

@end

@interface LVMainLineSelecteCell : UITableViewCell

@property (nonatomic , strong) LVMainLineModel *model;

@end

NS_ASSUME_NONNULL_END
