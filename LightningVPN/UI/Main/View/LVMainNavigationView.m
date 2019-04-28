//
//  LVMainNavigationView.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/26.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "LVMainNavigationView.h"

@interface LVMainNavigationView ()

@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UIButton *funcBtn;

@end

@implementation LVMainNavigationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = FitFont(16);
        self.titleLabel.text = @"闪连";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        
        self.funcBtn = [[UIButton alloc] init];
        self.funcBtn.backgroundColor = [UIColor redColor];
        [self.funcBtn addTarget:self action:@selector(showLeftMenuController:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.funcBtn];
    }
    return self;
}

- (void)showLeftMenuController:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(LVMainNavigationViewShowLeftMenuController)]) {
        [self.delegate LVMainNavigationViewShowLeftMenuController];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self).mas_offset(-11);
        make.size.mas_equalTo(CGSizeMake(FITSCALE(50), FITSCALE(22)));
    }];
    
    [self.funcBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(FITSCALE(18), FITSCALE(18)));
        make.left.mas_equalTo(self).mas_offset(FITSCALE(22));
        make.bottom.mas_equalTo(self).mas_offset(-13);
    }];
}

@end
