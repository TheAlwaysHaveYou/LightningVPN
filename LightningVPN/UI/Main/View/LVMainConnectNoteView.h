//
//  LVMainConnectNoteView.h
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/28.
//  Copyright © 2019 FKD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LVMainConnectButtonView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LVMainConnectNoteView : UILabel

@property (nonatomic , assign) LVConnectStatus status;

@end

NS_ASSUME_NONNULL_END
