//
//  LVAboutVC.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/28.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "LVAboutVC.h"

@interface LVAboutVC ()

@end

@implementation LVAboutVC

#pragma mark - Lifecycle
- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    NSLog(@"---%s----",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBarHide = YES;
    
    self.view.backgroundColor = kColor_4872FF;
    
    [self setupSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

#pragma mark - Custom Accessors
- (void)setCustomProperty:(id)value {
    
}

- (id)customProperty {
    return [NSObject  new];
}

#pragma mark - IBActions

- (IBAction)submitData:(id)sender {
    
}

#pragma mark - Public

- (void)publicMethod {
    
}

#pragma mark - Private

- (void)privateMethod {
    
}

- (void)setupSubViews {
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(FITSCALE(116), (kSCREEN_WIDTH-FITSCALE(134))/2, FITSCALE(134), FITSCALE(134))];
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    imgV.image = IMGNAME(@"");
    imgV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imgV];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, FITSCALE(280), kSCREEN_WIDTH, FITSCALE(23))];
    nameLabel.font = FitBorderFont(19);
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = @"闪连科技";
    [self.view addSubview:nameLabel];
    
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, FITSCALE(313), kSCREEN_WIDTH, FITSCALE(18))];
    versionLabel.font = FitFont(12);
    versionLabel.textColor = [UIColor whiteColor];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.text = [NSString stringWithFormat:@"版本号 %@",app_Version];
    [self.view addSubview:versionLabel];
    
    UIButton *contactBtn = [[UIButton alloc] initWithFrame:CGRectMake(FITSCALE(24), kSCREEN_HEIGHT-FITSCALE(142), kSCREEN_WIDTH-FITSCALE(48), FITSCALE(56))];
    [contactBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [contactBtn setTitle:@"联系我们" forState:UIControlStateNormal];
    contactBtn.titleLabel.font = FitBorderFont(17);
    contactBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    contactBtn.layer.borderWidth = 1;
    contactBtn.layer.cornerRadius = FITSCALE(28);
    contactBtn.layer.masksToBounds = YES;
    contactBtn.tag = 10;
    [contactBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:contactBtn];
    
    UIButton *serviceBtn = [[UIButton alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH/2-FITSCALE(11)-FITSCALE(60), kSCREEN_HEIGHT-FITSCALE(60), FITSCALE(60), FITSCALE(20))];
    [serviceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [serviceBtn setTitle:@"服务条款" forState:UIControlStateNormal];
    serviceBtn.titleLabel.font = FitBorderFont(14);
    serviceBtn.tag = 11;
    [serviceBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:serviceBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH/2-0.5, kSCREEN_HEIGHT-FITSCALE(57), 1, FITSCALE(13))];
    lineView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineView];
    
    UIButton *privacyBtn = [[UIButton alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH/2+FITSCALE(11), kSCREEN_HEIGHT-FITSCALE(60), FITSCALE(60), FITSCALE(20))];
    [privacyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [privacyBtn setTitle:@"隐私政策" forState:UIControlStateNormal];
    privacyBtn.titleLabel.font = FitBorderFont(14);
    privacyBtn.tag = 12;
    [privacyBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:privacyBtn];
}

- (void)functionBtnClick:(UIButton *)sender {
    if (sender.tag == 10) {//联系我们
        
    }else if (sender.tag == 11) {//服务条款
        
    }else if (sender.tag == 12) {//隐私政策
        
    }
}

#pragma mark - Protocol conformance



@end
