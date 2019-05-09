//
//  LVMainGetFreeView.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/29.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "LVMainGetFreeView.h"
#import "LVMainCodeInputView.h"

@interface LVMainGetFreeView ()

@property (nonatomic , assign) CGFloat originY;

@property (nonatomic , strong) UIView *contentView;

@property (nonatomic , strong) LVMainCodeInputView *codeView;

@end

@implementation LVMainGetFreeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        self.originY = frame.origin.y;
        
        self.alpha = 0;
        self.hidden = YES;
        
        self.contentView = [[UIView alloc] initWithFrame:frame];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = FITSCALE(20);
        self.contentView.layer.masksToBounds = YES;
        [self addSubview:self.contentView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.contentView.width-FITSCALE(80))/2, FITHEIGHTSCALE(30.82), FITSCALE(80), FITSCALE(26))];
        titleLabel.font = FitBorderFont(19);
        titleLabel.textColor = kColor_404852;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"合作推广";
        [self.contentView addSubview:titleLabel];
        
        [self creatSomeLabel:@[@"微信关注公众号——",@"后台回复",@"按照提示操作"] colorText:@[@"申请圈AppCircle",@"“闪连”",@"免费领取一个月VIP兑换码"] y:@[@(86.82),@(117.82),@(147.82)]];
        
        self.codeView = [[LVMainCodeInputView alloc] initWithFrame:CGRectMake(FITSCALE(39), FITHEIGHTSCALE(198.24), self.contentView.width-FITSCALE(78), FITSCALE(64))];
        [self.contentView addSubview:self.codeView];
        
        UIButton *enterBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.contentView.width-FITSCALE(278))/2, FITHEIGHTSCALE(302.48), FITSCALE(278), FITSCALE(56))];
        [enterBtn setTitle:@"确认领取" forState:UIControlStateNormal];
        [enterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        enterBtn.titleLabel.font = FitFont(17);
        enterBtn.layer.backgroundColor = kColor_4872FF.CGColor;
        enterBtn.layer.cornerRadius = enterBtn.frame.size.height/2;
        enterBtn.layer.shadowColor = kColor_4872FF.CGColor;
        enterBtn.layer.shadowOffset = CGSizeMake(0, 5);
        enterBtn.layer.shadowOpacity = 0.5;
        enterBtn.tag = 10;
        [enterBtn addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:enterBtn];
        
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.contentView.width-FITSCALE(40))/2, FITHEIGHTSCALE(378.24), FITSCALE(40), FITSCALE(24))];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:kColor_4872FF forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = FitFont(17);
        cancelBtn.tag = 11;
        [cancelBtn addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:cancelBtn];
    }
    return self;
}

- (void)creatSomeLabel:(NSArray <NSString *> *)firstArr colorText:(NSArray <NSString *> *)secondArr y:(NSArray <NSNumber *> *)yArr {
    [firstArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSAttributedString *firstAtt = [[NSAttributedString alloc] initWithString:obj attributes:@{NSForegroundColorAttributeName:kColor_939AA8,NSFontAttributeName:FitFont(15)}];
        NSMutableAttributedString *secondAtt = [[NSMutableAttributedString alloc] initWithString:secondArr[idx] attributes:@{NSForegroundColorAttributeName:kColor_4872FF,NSFontAttributeName:FitFont(15)}];
        [secondAtt insertAttributedString:firstAtt atIndex:0];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((self.contentView.width-FITSCALE(270))/2, FITHEIGHTSCALE([yArr[idx] floatValue]), FITSCALE(270), FITSCALE(21))];
        label.textAlignment = NSTextAlignmentCenter;
        label.attributedText = secondAtt;
        [self.contentView addSubview:label];
    }];
}

- (void)functionButtonClick:(UIButton *)sender {
    if (sender.tag == 10) {//确认
        NSLog(@"验证码----%@",self.codeView.codeNumberStr);
    }else if (sender.tag == 11) {//取消
        [self.codeView clean];
        
        [self dismiss];
    }
}

- (void)changeContentViewBottom:(CGFloat)bottom {
    self.contentView.bottom = bottom;
}

- (void)recoverOriginFrame {
    self.contentView.top = self.originY;
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
        self.hidden = NO;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
        self.hidden = YES;
    }];
    
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3];
}

@end
