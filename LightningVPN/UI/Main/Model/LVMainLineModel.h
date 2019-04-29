//
//  LVMainLineModel.h
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/29.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "LVBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LVMainLineModel : LVBaseModel

@property (nonatomic , strong) NSString *title;
@property (nonatomic , strong) NSString *detail;
@property (nonatomic , assign , getter=isSelected) BOOL selected;

@end

NS_ASSUME_NONNULL_END
