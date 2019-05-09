//
//  LVMainConnectButtonView.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/28.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "LVMainConnectButtonView.h"

@interface LVMainConnectButtonView ()

@property (nonatomic , strong) UILabel *nameLabel;

@property (nonatomic , strong) UIImageView *imgV;

@property (nonatomic , strong) UITapGestureRecognizer *tap;

@end

@implementation LVMainConnectButtonView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [self addGestureRecognizer:self.tap];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.nameLabel.font = FitBorderFont(17);
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.text = @"立即闪连";
        [self addSubview:self.nameLabel];
        
        self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(FITSCALE(305.41-24), (frame.size.height-FITSCALE(37.18))/2, FITSCALE(37.18), FITSCALE(37.18))];
        self.imgV.contentMode = UIViewContentModeScaleAspectFit;
        self.imgV.image = IMGNAME(@"icon_main_connect_lightning");
        [self addSubview:self.imgV];
        
        self.status = LVConnectStatus_normal;

//        self.layer.backgroundColor = kColor_4872FF.CGColor;
//        self.layer.cornerRadius = 4;
//        self.layer.shadowColor = kColor_4872FF.CGColor;
//        self.layer.shadowOffset = CGSizeZero;
//        self.layer.shadowOpacity = 1;
//        self.layer.shadowRadius = 6;
    }
    return self;
}

- (void)setStatus:(LVConnectStatus)status {
    _status = status;
    
    if (LVConnectStatus_normal == status) {
        self.nameLabel.text = @"立即闪连";
        self.nameLabel.textColor = [UIColor whiteColor];
        self.imgV.hidden = NO;
        
        self.layer.backgroundColor = kColor_4872FF.CGColor;
        self.layer.cornerRadius = self.frame.size.height/2;
        self.layer.shadowColor = kColor_4872FF.CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 5);
        self.layer.shadowOpacity = 0.5;
        
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.layer.borderWidth = 0;
    }else if (LVConnectStatus_ing == status) {
        self.nameLabel.text = @"连接中";
        self.nameLabel.textColor = kColor_404852;
        self.imgV.hidden = YES;
        
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.layer.cornerRadius = self.frame.size.height/2;
        self.layer.shadowColor = [UIColor clearColor].CGColor;
        self.layer.shadowOffset = CGSizeZero;
        self.layer.shadowOpacity = 0;
        
        self.layer.borderColor = kColor_404852.CGColor;
        self.layer.borderWidth = 1;
    }else if (LVConnectStatus_success == status) {
        self.nameLabel.text = @"断开链接";
        self.nameLabel.textColor = kColor_404852;
        self.imgV.hidden = YES;
        
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.layer.cornerRadius = self.frame.size.height/2;
        self.layer.shadowColor = [UIColor clearColor].CGColor;
        self.layer.shadowOffset = CGSizeZero;
        self.layer.shadowOpacity = 0;
        
        self.layer.borderColor = kColor_404852.CGColor;
        self.layer.borderWidth = 1;
    }else if (LVConnectStatus_fail == status) {
        self.nameLabel.text = @"重新闪连";
        self.nameLabel.textColor = kColor_EC6161;
        self.imgV.hidden = YES;
        
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.layer.cornerRadius = self.frame.size.height/2;
        self.layer.shadowColor = [UIColor clearColor].CGColor;
        self.layer.shadowOffset = CGSizeZero;
        self.layer.shadowOpacity = 0;
        
        self.layer.borderColor = kColor_404852.CGColor;
        self.layer.borderWidth = 1;
    }
}

- (void)tapClick:(UIGestureRecognizer *)gesture {
    if ([self.delegate respondsToSelector:@selector(LVMainConnectButtonView:clickWithStatus:)]) {
        [self.delegate LVMainConnectButtonView:self clickWithStatus:self.status];
    }
    
    if (LVConnectStatus_normal == self.status) {
        [UIView animateWithDuration:0.5 animations:^{
            self.status = LVConnectStatus_ing;
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5 animations:^{
                self.status = LVConnectStatus_success;
            }];
        });
    }else if (LVConnectStatus_ing == self.status) {
        
    }else if (LVConnectStatus_success == self.status) {
        [UIView animateWithDuration:0.5 animations:^{
            self.status = LVConnectStatus_normal;
        }];
    }else if (LVConnectStatus_fail == self.status) {
        
    }
}

@end
