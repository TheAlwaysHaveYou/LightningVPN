//
//  LVMainLineSelecteView.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/28.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "LVMainLineSelecteView.h"

@interface LVMainLineSelecteView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UIView *contentView;
@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic , strong) UITableView *tableView;

@end

@implementation LVMainLineSelecteView

static NSString * const cellIdentifier = @"cell";
static NSString * const headerIdentifier = @"header";

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#1F2227"];
        
        
        
//        self.alpha = 0;
//        self.hidden = YES;
        
        self.contentView = [[UIView alloc] initWithFrame:frame];
        self.contentView.backgroundColor = [UIColor whiteColor];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, frame.size.width, frame.size.height) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(FITSCALE(20), FITSCALE(20))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        maskLayer.path = maskPath.CGPath;
        self.contentView.layer.mask = maskLayer;
        
        [self addSubview:self.contentView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.contentView.width-FITSCALE(334))/2, FITSCALE(30), FITSCALE(334), FITSCALE(26))];
        titleLabel.font = FitBorderFont(19);
        titleLabel.textColor = kColor_404852;
        titleLabel.text = @"选择线路";
        [self.contentView addSubview:titleLabel];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.contentView.width-FITSCALE(334))/2, FITSCALE(56), FITSCALE(334), FITSCALE(18))];
        self.nameLabel.font = FitFont(15);
        self.nameLabel.textColor = kColor_939AA8;
        self.nameLabel.text = @"免费体验线路";
        [self.contentView addSubview:self.nameLabel];
        
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
        [self.contentView addSubview:self.tableView];
    }
    return self;
}


- (void)functionButtonClick:(UIButton *)sender {
    
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


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LVMainLineSelecteCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
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
