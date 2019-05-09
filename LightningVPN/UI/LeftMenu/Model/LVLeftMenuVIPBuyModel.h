//
//  LVLeftMenuVIPBuyModel.h
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/29.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "LVBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LVLeftMenuVIPBuyModel : LVBaseModel

@property (nonatomic , strong) NSString *money;
@property (nonatomic , strong) NSString *time;

@property (nonatomic , strong) NSString *buyID;

@property (nonatomic , assign , getter=isSelected) BOOL selected;

@end

NS_ASSUME_NONNULL_END
