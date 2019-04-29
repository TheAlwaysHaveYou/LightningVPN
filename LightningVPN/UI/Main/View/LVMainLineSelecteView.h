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

@interface LVMainLineSelecteView : UIView

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
