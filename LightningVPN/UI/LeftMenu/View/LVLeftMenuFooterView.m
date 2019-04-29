//
//  LVLeftMenuFooterView.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/28.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "LVLeftMenuFooterView.h"

@interface LVLeftMenuFooterView ()

@property (nonatomic , strong) UIImageView *imgV;
@property (nonatomic , strong) UIButton *btn;

@end

@implementation LVLeftMenuFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imgV = [[UIImageView alloc] init];
        self.imgV.contentMode = UIViewContentModeScaleAspectFit;
        self.imgV.image = IMGNAME(@"icon_menu_about");
        [self addSubview:self.imgV];
        
        self.btn = [[UIButton alloc] init];
        [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btn setTitle:@"关于我们" forState:UIControlStateNormal];
        self.btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.btn.titleLabel.font = FitBorderFont(12);
        [self.btn addTarget:self action:@selector(functionClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btn];
    }
    return self;
}

- (void)functionClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(LVLeftMenuFooterViewFunctionAboutUS)]) {
        [self.delegate LVLeftMenuFooterViewFunctionAboutUS];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(FITSCALE(18), FITSCALE(18)));
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(FITSCALE(45));
    }];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(FITSCALE(80));
        make.size.mas_equalTo(CGSizeMake(FITSCALE(100), FITSCALE(22)));
        make.top.mas_equalTo(self);
    }];
}

@end
