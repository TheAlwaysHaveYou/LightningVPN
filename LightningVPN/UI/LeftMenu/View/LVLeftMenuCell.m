//
//  LVLeftMenuCell.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/26.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "LVLeftMenuCell.h"

@interface LVLeftMenuCell ()

@property (nonatomic , strong) UIImageView *imgV;
@property (nonatomic , strong) UILabel *nameLabel;

@end

@implementation LVLeftMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.imgV = [[UIImageView alloc] init];
        self.imgV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.imgV];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = FitFont(19);
        self.nameLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}

- (void)setImage:(NSString *)image {
    _image = image;
    self.imgV.image = IMGNAME(image);
}

- (void)setName:(NSString *)name {
    _name = name;
    self.nameLabel.text = name;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(FITSCALE(19), FITSCALE(19)));
        make.left.mas_equalTo(FITSCALE(50));
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(FITSCALE(80));
        make.top.right.bottom.mas_equalTo(self.contentView);
    }];
}

@end
