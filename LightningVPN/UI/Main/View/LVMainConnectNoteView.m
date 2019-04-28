//
//  LVMainConnectNoteView.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/28.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "LVMainConnectNoteView.h"

@implementation LVMainConnectNoteView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kColor_56D043;
        
        self.font = FitBorderFont(13);
        self.textColor = [UIColor whiteColor];
        self.textAlignment = NSTextAlignmentCenter;
        
        self.layer.cornerRadius = frame.size.height/2;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setStatus:(LVConnectStatus)status {
    _status = status;
    
    if (LVConnectStatus_success == status) {
        self.hidden = NO;
        
        self.text = @"闪连成功";
        self.backgroundColor = kColor_56D043;
    }else if (LVConnectStatus_fail == status) {
        self.hidden = NO;
        
        self.text = @"闪连失败";
        self.backgroundColor = kColor_EC6161;
    }else {
        self.hidden = YES;
    }
}

@end
