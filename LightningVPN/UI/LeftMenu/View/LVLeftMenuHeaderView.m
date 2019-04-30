//
//  LVLeftMenuHeaderView.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/26.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "LVLeftMenuHeaderView.h"

@interface LVLeftMenuHeaderView ()

@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UILabel *detailLabel;
@property (nonatomic , strong) UIButton *functionBtn;

@end

@implementation LVLeftMenuHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = FitBorderFont(19);
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.text = @"普通会员";
        [self addSubview:self.titleLabel];
        
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:FITSCALE(4)];
        NSAttributedString *detailStr = [[NSAttributedString alloc] initWithString:@"普通会员永久免费\n升级VIP尊享更多特权" attributes:@{NSFontAttributeName:FitFont(12),NSForegroundColorAttributeName:[UIColor whiteColor],NSParagraphStyleAttributeName:paragraphStyle}];
        
        self.detailLabel = [[UILabel alloc] init];
        self.detailLabel.numberOfLines = 0;
        self.detailLabel.attributedText = detailStr;
        [self addSubview:self.detailLabel];
        
        self.functionBtn = [[UIButton alloc] initWithFrame:CGRectMake(FITSCALE(48), FITSCALE(220), FITSCALE(127), FITSCALE(25))];
        [self.functionBtn setTitleColor:kColor_4872FF forState:UIControlStateNormal];
        [self.functionBtn setTitle:@"升级一个月会员" forState:UIControlStateNormal];
        [self.functionBtn setImage:IMGNAME(@"icon_menu_leftArrow") forState:UIControlStateNormal];
        self.functionBtn.backgroundColor = [UIColor whiteColor];
        self.functionBtn.titleLabel.font = FitBorderFont(12);
        self.functionBtn.layer.cornerRadius = FITSCALE(12.5);
        self.functionBtn.layer.masksToBounds = YES;
        [self.functionBtn setImageDirection:RIGHT withSpan:FITSCALE(12.25)];
        [self.functionBtn addTarget:self action:@selector(upUserMemberShip:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.functionBtn];
    }
    return self;
}

- (void)upUserMemberShip:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(LVLeftMenuHeaderViewUpMemberShip)]) {
        [self.delegate LVLeftMenuHeaderViewUpMemberShip];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(FITSCALE(48));
        make.top.mas_equalTo(self).mas_offset(FITSCALE(123));
        make.size.mas_equalTo(CGSizeMake(FITSCALE(121), 23));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(FITSCALE(48));
        make.top.mas_equalTo(self).mas_offset(FITSCALE(166));
        make.size.mas_equalTo(CGSizeMake(FITSCALE(200), FITSCALE(36)));
    }];
}

@end
