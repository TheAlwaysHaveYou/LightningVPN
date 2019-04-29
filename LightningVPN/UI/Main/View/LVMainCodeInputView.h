//
//  LVMainCodeInputView.h
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/29.
//  Copyright © 2019 FKD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectCodeBlock)(NSString *);

@interface LVMainCodeInputView : UIView

@property (nonatomic , strong) NSString *codeNumberStr;

- (void)clean;

@end

NS_ASSUME_NONNULL_END
