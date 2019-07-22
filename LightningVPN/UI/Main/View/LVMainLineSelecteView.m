//
//  LVMainLineSelecteView.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/28.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "LVMainLineSelecteView.h"

@interface LVMainLineSelecteView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UIButton *arrowBtn;
@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , assign) CGFloat minY;
@property (nonatomic , assign) CGFloat showY;

@property (nonatomic , strong) NSArray <NSArray <LVMainLineModel *> *> *modelArr;

@property (nonatomic , strong) UIPanGestureRecognizer *panGesture;

@property (nonatomic , strong) UISwitch *switchControl;

@end

@implementation LVMainLineSelecteView

static NSString * const cellIdentifier = @"cell";
static NSString * const headerIdentifier = @"header";

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.show = NO;
        self.minY = frame.origin.y;
        self.showY = kSCREEN_HEIGHT-frame.size.height;
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, frame.size.width, frame.size.height) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(FITSCALE(20), FITSCALE(20))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
        
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        [self addGestureRecognizer:self.panGesture];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.width-FITSCALE(334))/2, FITSCALE(30), FITSCALE(334), FITSCALE(26))];
        self.titleLabel.font = FitBorderFont(19);
        self.titleLabel.textColor = kColor_404852;
        self.titleLabel.text = @"选择线路(智能模式)";
//        [self addSubview:self.titleLabel];
        
        self.switchControl = [[UISwitch alloc] initWithFrame:CGRectMake(self.width-FITSCALE(100), FITSCALE(30), FITSCALE(50), FITSCALE(26))];
        self.switchControl.on = YES;
        [self.switchControl addTarget:self action:@selector(changeLinkModel:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:self.switchControl];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.width-FITSCALE(334))/2, FITSCALE(56), FITSCALE(334), FITSCALE(18))];
        self.nameLabel.font = FitFont(15);
        self.nameLabel.textColor = kColor_939AA8;
        self.nameLabel.text = @"免费体验线路";
        [self addSubview:self.nameLabel];
        
        self.arrowBtn = [[UIButton alloc] initWithFrame:CGRectMake(FITSCALE(341.26), FITSCALE(39), FITSCALE(13.26), FITSCALE(5.89))];
        [self.arrowBtn setImage:IMGNAME(@"icon_main_line_arrow") forState:UIControlStateNormal];
        [self.arrowBtn addTarget:self action:@selector(arrowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.arrowBtn];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, FITSCALE(73), frame.size.width, frame.size.height-FITSCALE(73)) style:UITableViewStyleGrouped];
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.backgroundColor = [UIColor whiteColor];
        [self.tableView registerClass:[LVMainLineSelecteHeaderView class] forHeaderFooterViewReuseIdentifier:headerIdentifier];
        [self.tableView registerClass:[LVMainLineSelecteCell class] forCellReuseIdentifier:cellIdentifier];
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self addSubview:self.tableView];
        
        @weakify(self)
        [[RACObserve(self, frame) deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
            @strongify(self)
            CGRect rect = [(NSValue *)x CGRectValue];
            
            CGFloat percent = (rect.origin.y-self.showY)/(self.minY-self.showY);
            
            if ([self.delegate respondsToSelector:@selector(LVMainLineSelecteView:frameYChangePercent:)]) {
                [self.delegate LVMainLineSelecteView:self frameYChangePercent:1-percent];
            }
        }];
        
        [[RACObserve(self.panGesture, state) deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
            @strongify(self)
            if ([x integerValue] == UIGestureRecognizerStateEnded) {
                if (self.top <= (self.minY+self.showY)/2) {
                    if (self.top == self.showY) {
                        return ;
                    }
                    [UIView animateWithDuration:0.5 animations:^{
                        self.top = self.showY;
                        
                    }];
                }else {
                    if (self.top == self.minY) {
                        return ;
                    }
                    [UIView animateWithDuration:0.5 animations:^{
                        self.top = self.minY;
                    } completion:^(BOOL finished) {
                    }];
                }
            }
        }];
        
        LVMainLineModel *model1 = [[LVMainLineModel alloc] init];
        model1.title = @"101.254.225.172端口";
        model1.ip = @"101.254.225.172";
        model1.port = @9877;
        model1.password = @"test";
        model1.selected = YES;
        
        LVMainLineModel *model2 = [[LVMainLineModel alloc] init];
        model2.title = @"60.190.81.141端口";
        model2.ip = @"60.190.81.141";
        model2.port = @55361;
        model2.password = @"test30";
        model2.selected = NO;
        
        self.modelArr = @[@[model1],@[model2]];
        [self.tableView reloadData];
        
        [LVVPNManager sharedInstance].lineModel = model1;
    }
    return self;
}

- (void)changeLinkModel:(UISwitch *)switchControl {
    if (switchControl.isOn) {
        self.titleLabel.text = @"选择线路(智能模式)";
    }else {
        self.titleLabel.text = @"选择线路(全局模式)";
    }
    
    [LVVPNManager sharedInstance].rule == VPNConnectRule_HaveRule ?([LVVPNManager sharedInstance].rule=VPNConnectRule_NoRule):([LVVPNManager sharedInstance].rule=VPNConnectRule_HaveRule);
    NSLog(@"改变了智能规则---%d",[LVVPNManager sharedInstance].rule);
}

- (void)arrowBtnClick:(UIButton *)sender {
    
    [self show];
}

- (void)panGestureAction:(UIPanGestureRecognizer *)panGesture {
    CGPoint point = [panGesture translationInView:[self superview]];
    
    if (self.top <= self.showY+3) {
        if (point.y < 0) {
//            if (self.tableView.contentSize.height <= self.tableView.height) {//防止当Cell行数太少的时候，还继续往上滑动
//                return;
//            }
//
//            if (self.tableView.contentOffset.y+self.tableView.height >= self.tableView.contentSize.height) {//防止行数稍微超出tableview高，手势没停产生误差
//                self.tableView.scrollEnabled = YES;
//                return;
//            }
//
//            [self.tableView setContentOffset:CGPointMake(0, -point.y) animated:NO];
//            self.tableView.scrollEnabled = YES;
            return;
        }
    }

    if (self.top >= self.minY-3) {
        if (point.y > 0) {
            return;
        }
    }
    
    panGesture.view.center = CGPointMake(panGesture.view.center.x, panGesture.view.center.y + point.y);
    [panGesture setTranslation:CGPointZero inView:[self superview]];
}

- (void)show {
    [UIView animateWithDuration:0.25 animations:^{
        self.top = self.showY;
    } completion:^(BOOL finished) {
        self.arrowBtn.hidden = YES;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        self.top = self.minY;
    } completion:^(BOOL finished) {
        self.arrowBtn.hidden = NO;
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.modelArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArr[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LVMainLineSelecteCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    LVMainLineModel *model = self.modelArr[indexPath.section][indexPath.row];
    cell.model = model;
    
    return cell;
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return FITSCALE(44);
    }else {
        return FITSCALE(54);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return FITSCALE(56);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LVMainLineSelecteHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    header.section = section;
    return header;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __block LVMainLineModel *tempModel;
    [self.modelArr enumerateObjectsUsingBlock:^(NSArray<LVMainLineModel *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj enumerateObjectsUsingBlock:^(LVMainLineModel * _Nonnull subObj, NSUInteger subIdx, BOOL * _Nonnull subStop) {
            subObj.selected = NO;
            if (indexPath.section == idx && indexPath.row == subIdx) {
                subObj.selected = YES;
                tempModel = subObj;
            }
        }];
    }];
    [self.tableView reloadData];
    
    [LVVPNManager sharedInstance].lineModel = tempModel;
}

@end

#pragma mark - LVMainLineSelecteHeaderView

@interface LVMainLineSelecteHeaderView ()

@property (nonatomic , strong) UILabel *titleLabel;

@end

@implementation LVMainLineSelecteHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(FITSCALE(24), FITSCALE(29), FITSCALE(100), FITSCALE(22))];
        self.titleLabel.font = FitBorderFont(17);
        self.titleLabel.text = @"免费专区";
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)setSection:(NSInteger)section {
    _section = section;
    if (section == 0) {
        self.titleLabel.text = @"免费专区";
        self.titleLabel.textColor = kColor_404852;
    }else {
        self.titleLabel.text = @"VIP专区";
        self.titleLabel.textColor = kColor_4872FF;
    }
}

@end

#pragma mark - LVMainLineSelecteCell

@interface LVMainLineSelecteCell ()

@property (nonatomic , strong) UIImageView *imgV;
@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic , strong) UILabel *describeLabel;

@end

@implementation LVMainLineSelecteCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.imgV = [[UIImageView alloc] init];
        self.imgV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.imgV];
        
        self.nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.nameLabel];
        
        self.describeLabel = [[UILabel alloc] init];
        self.describeLabel.font = FitFont(11);
        self.describeLabel.textColor = kColor_939AA8;
        self.describeLabel.hidden = YES;
        [self.contentView addSubview:self.describeLabel];
    }
    return self;
}

- (void)setModel:(LVMainLineModel *)model {
    _model = model;
    
    if (!model.detail.length) {
        self.nameLabel.font = FitFont(17);
        self.nameLabel.textColor = kColor_404852;
        self.describeLabel.hidden = YES;
    }else {
        self.nameLabel.font = FitBorderFont(14);
        self.nameLabel.textColor = kColor_404852;
        self.describeLabel.hidden = NO;
    }
    self.nameLabel.text = model.title;
    self.describeLabel.text = model.detail;
    
    self.imgV.image = IMGNAME(model.isSelected?@"icon_main_line_selected":@"icon_main_line_empty");
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(FITSCALE(16), FITSCALE(16)));
        make.left.mas_equalTo(self.contentView).mas_offset(FITSCALE(28));
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(FITSCALE(64));
        if (self.model.detail.length) {
            make.top.mas_equalTo(self.contentView).mas_offset(FITSCALE(10));
            make.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(FITSCALE(20));
        }else {
            make.top.right.bottom.mas_equalTo(self.contentView);
        }
    }];
    
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.contentView).mas_offset(FITSCALE(29));
        make.height.mas_equalTo(FITSCALE(16));
    }];
}

@end
