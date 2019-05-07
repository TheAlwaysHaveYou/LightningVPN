//
//  LVLaunchCell.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/5/7.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "LVLaunchCell.h"

@interface LVLaunchCell ()

@property (nonatomic , strong) UIImageView *imgV;
@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UILabel *detailLabel;

@end

@implementation LVLaunchCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(FITSCALE(24), FITHEIGHTSCALE(175), frame.size.width-FITSCALE(24*2), FITHEIGHTSCALE(327))];
        self.imgV.contentMode = UIViewContentModeScaleAspectFit;
        self.imgV.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:self.imgV];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, FITHEIGHTSCALE(542), frame.size.width, FITSCALE(40))];
        self.titleLabel.font = FitBorderFont(28);
        self.titleLabel.textColor = kColor_4872FF;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
        
        self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, FITHEIGHTSCALE(597), frame.size.width, FITSCALE(49))];
        self.detailLabel.font = FitFont(15);
        self.detailLabel.textColor = kColor_939AA8;
        self.detailLabel.textAlignment = NSTextAlignmentCenter;
        self.detailLabel.numberOfLines = 0;
        [self.contentView addSubview:self.detailLabel];
    }
    return self;
}

- (void)setModel:(LVLaunchModel *)model {
    _model = model;
    
    self.imgV.image = IMGNAME(model.imageName);
    self.titleLabel.text = model.title;
    self.detailLabel.text = model.detail;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
}

@end
