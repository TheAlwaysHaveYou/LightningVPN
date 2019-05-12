//
//  LVLeftMenuVIPBuyView.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/29.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "LVLeftMenuVIPBuyView.h"

#define kBuyMonthID @"LightingVPNVipMonth"  //一个月
#define kBuySeasonID @"LightingVPNVipSeason"//一季度
#define kBuyYearID @"LightingVPNVipYear"    //一年
//#define kBuyYearID @"com.test.restore.Temp"


@interface LVLeftMenuVIPBuyView ()

@property (nonatomic , strong) UIView *contentView;

@property (nonatomic , strong) NSMutableArray <LVLeftMenuVIPTypeView *> *typeArr;

@end

@implementation LVLeftMenuVIPBuyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        self.alpha = 0;
        self.hidden = YES;
        
        self.contentView = [[UIView alloc] initWithFrame:frame];
        self.contentView.backgroundColor = [UIColor whiteColor];
//        self.contentView.layer.cornerRadius = FITSCALE(20);
        self.contentView.layer.masksToBounds = YES;
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, frame.size.width, frame.size.height) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(FITSCALE(20), FITSCALE(20))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        maskLayer.path = maskPath.CGPath;
        self.contentView.layer.mask = maskLayer;
        
        [self addSubview:self.contentView];
        
        UIImageView *bgImgV = [[UIImageView alloc] initWithFrame:CGRectMake(-FITSCALE(148.63), -FITSCALE(568.34), FITSCALE(637.25), FITSCALE(725.76))];
        bgImgV.contentMode = UIViewContentModeScaleAspectFit;
        bgImgV.image = IMGNAME(@"icon_main_backGround_empty");
//        bgImgV.transform = CGAffineTransformMakeRotation(-M_PI/15);
        [self.contentView addSubview:bgImgV];
        
        UIImageView *rocketImgV = [[UIImageView alloc] initWithFrame:CGRectMake(FITSCALE(164.62), FITSCALE(50.41), FITSCALE(168.84), FITSCALE(198.83))];
        rocketImgV.contentMode = UIViewContentModeScaleAspectFit;
        rocketImgV.image = IMGNAME(@"icon_main_rocket");
        rocketImgV.transform = CGAffineTransformMakeRotation(M_PI/3);
        [self.contentView addSubview:rocketImgV];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(FITSCALE(50), FITHEIGHTSCALE(120), FITSCALE(80), FITSCALE(26))];
        titleLabel.font = FitBorderFont(19);
        titleLabel.textColor = kColor_404852;
        titleLabel.text = @"VIP会员";
        [self.contentView addSubview:titleLabel];
        
        [self creatSomeLabel:@[@"免广告",@"不限速 防拥挤",@"海外专享节点",@"3设备同事在线"] pointYArr:@[@(162),@(188),@(214),@(240)] strYarr:@[@(155),@(181),@(207),@(233)]];
        
        NSArray *oneArr = @[@"$3.99",@"$10.99",@"$34.99"];
        NSArray *twoArr = @[@"一个月",@"一季度",@"一年"];
        NSArray *idArr = @[kBuyMonthID,kBuySeasonID,kBuyYearID];
        
        self.typeArr = [[NSMutableArray alloc] init];
        
        CGFloat space = FITSCALE(18);
        CGFloat w = (frame.size.width-FITSCALE(40)-space*2)/3;
        [oneArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LVLeftMenuVIPBuyModel *model = [[LVLeftMenuVIPBuyModel alloc] init];
            model.money = obj;
            model.time = twoArr[idx];
            model.buyID = idArr[idx];
            
            if (idx == 0) {
                model.selected = YES;
            }else {
                model.selected = NO;
            }
            
            LVLeftMenuVIPTypeView *typeView = [[LVLeftMenuVIPTypeView alloc] initWithFrame:CGRectMake(FITSCALE(20)+(w+space)*idx, FITHEIGHTSCALE(300), FITSCALE(100), FITSCALE(120.19))];
            typeView.model = model;
            [typeView addTarget:self action:@selector(typeControlClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:typeView];
            
            [self.typeArr addObject:typeView];
        }];
        
        
        UIButton *enterBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.contentView.width-FITSCALE(327))/2, FITHEIGHTSCALE(480), FITSCALE(327), FITSCALE(56))];
        [enterBtn setTitle:@"立刻升级VIP" forState:UIControlStateNormal];
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
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(FITSCALE(305.41-24), (enterBtn.size.height-FITSCALE(37.18))/2, FITSCALE(37.18), FITSCALE(37.18))];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        imgV.image = IMGNAME(@"icon_main_connect_lightning");
        [enterBtn addSubview:imgV];
        
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.contentView.width-FITSCALE(40))/2, FITHEIGHTSCALE(564), FITSCALE(40), FITSCALE(24))];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:kColor_4872FF forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = FitFont(17);
        cancelBtn.tag = 11;
        [cancelBtn addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:cancelBtn];
    }
    return self;
}

- (void)creatSomeLabel:(NSArray <NSString *> *)firstArr pointYArr:(NSArray <NSNumber *> *)pointYArr strYarr:(NSArray <NSNumber *> *)strYarr {
    [firstArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *point = [[UIView alloc] initWithFrame:CGRectMake(FITSCALE(50), FITHEIGHTSCALE([pointYArr[idx] floatValue]), FITSCALE(6), FITSCALE(6))];
        point.backgroundColor = kColor_4872FF;
        point.layer.cornerRadius = FITSCALE(3);
        point.layer.masksToBounds = YES;
        [self.contentView addSubview:point];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(FITSCALE(66), FITHEIGHTSCALE([strYarr[idx] floatValue]), FITSCALE(110), FITSCALE(21))];
        label.font = FitFont(15);
        label.textColor = kColor_939AA8;
        label.text = obj;
        [self.contentView addSubview:label];
    }];
}

- (void)typeControlClick:(LVLeftMenuVIPTypeView *)control {
    [self.typeArr enumerateObjectsUsingBlock:^(LVLeftMenuVIPTypeView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([control isEqual:obj]) {
            obj.model.selected = YES;
        }else {
            obj.model.selected = NO;
        }
        
        obj.model = obj.model;
    }];
}

- (void)functionButtonClick:(UIButton *)sender {
    if (sender.tag == 10) {//确认
        __block LVLeftMenuVIPBuyModel *model;
        [self.typeArr enumerateObjectsUsingBlock:^(LVLeftMenuVIPTypeView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.model.isSelected) {
                model = obj.model;
            }
        }];
        
        if ([self.delegate respondsToSelector:@selector(LVLeftMenuVIPBuyView:didSelectedBuyModel:)]) {
            [self.delegate LVLeftMenuVIPBuyView:self didSelectedBuyModel:model];
        }
    }else if (sender.tag == 11) {//取消
        
        
        [self dismiss];
    }
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

#pragma mark - LVLeftMenuVIPTypeView

@interface LVLeftMenuVIPTypeView ()

@property (nonatomic , strong) UILabel *priceLabel;
@property (nonatomic , strong) UILabel *timeLabel;
@property (nonatomic , strong) UIImageView *imgV;

@end

@implementation LVLeftMenuVIPTypeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = FITSCALE(10);
        self.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
        self.layer.shadowOffset = CGSizeZero;
        self.layer.shadowOpacity = 1;
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, FITSCALE(18), frame.size.width, FITSCALE(25))];
        self.priceLabel.font = FitBorderFont(18);
        self.priceLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.priceLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, FITSCALE(45), frame.size.width, FITSCALE(21))];
        self.timeLabel.font = FitBorderFont(15);
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.timeLabel];
        
        self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-FITSCALE(16))/2, FITSCALE(85), FITSCALE(16), FITSCALE(16))];
        self.imgV.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imgV];
    }
    return self;
}

- (void)setModel:(LVLeftMenuVIPBuyModel *)model {
    _model = model;
    
    if (model.isSelected) {
        self.layer.backgroundColor = kColor_4872FF.CGColor;
        self.priceLabel.textColor = [UIColor whiteColor];
        self.timeLabel.textColor = [UIColor whiteColor];
    }else {
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.priceLabel.textColor = kColor_4872FF;
        self.timeLabel.textColor = kColor_404852;
    }
    self.priceLabel.text = model.money;
    self.timeLabel.text = model.time;
    self.imgV.image = IMGNAME(model.isSelected?@"icon_main_line_selected":@"icon_main_line_empty");
}

@end
