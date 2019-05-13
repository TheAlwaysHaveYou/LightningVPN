//
//  LVMainVC.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/26.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "LVMainVC.h"
#import "LVMainNavigationView.h"
#import "LVMainConnectNoteView.h"
#import "LVMainConnectButtonView.h"
#import "LVMainGetFreeView.h"
#import "LVMainLineSelecteView.h"
#import "LVVPNManager.h"

@interface LVMainVC ()<LVMainNavigationViewDelegate,LVMainConnectButtonViewDelegate,LVMainLineSelecteViewDelegate>

@property (nonatomic , strong) LVMainNavigationView *navigationView;

@property (nonatomic , strong) UIImageView *bgImgV;
@property (nonatomic , strong) UIImageView *rocketImgV;

@property (nonatomic , strong) LVMainConnectNoteView *noteView;
@property (nonatomic , strong) LVMainConnectButtonView *connectView;
@property (nonatomic , strong) UIButton *freeBtn;

@property (nonatomic , strong) LVMainGetFreeView *getFreeView;
@property (nonatomic , strong) LVMainLineSelecteView *lineView;
@property (nonatomic , strong) UIControl *maskView;//选择线路的蒙版层

@end

@implementation LVMainVC

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
    
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupSubViews];
    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.lineView];
    
    @weakify(self)
    [[RACObserve(self.connectView, status) deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        LVConnectStatus status = [(NSNumber *)x integerValue];
        self.noteView.status = status;
        
        if (LVConnectStatus_normal == status) {
            self.bgImgV.image = IMGNAME(@"icon_main_backGround_normal");
            self.rocketImgV.hidden = YES;
        }else if (LVConnectStatus_ing == status) {
            self.bgImgV.image = IMGNAME(@"icon_main_backGround_empty");
            self.rocketImgV.hidden = YES;
        }else if (LVConnectStatus_success == status) {
            self.bgImgV.image = IMGNAME(@"icon_main_backGround_empty");
            self.rocketImgV.hidden = NO;
        }else if (LVConnectStatus_fail == status) {
            self.bgImgV.image = IMGNAME(@"icon_main_backGround_empty");
            self.rocketImgV.hidden = YES;
        }
    }];
    
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillChangeFrameNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification *notification) {
        @strongify(self)
        CGRect rect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:7];
        if (rect.origin.y < kSCREEN_HEIGHT) {
            [self.getFreeView changeContentViewBottom:rect.origin.y-FITSCALE(30)];
        }else {
            [self.getFreeView recoverOriginFrame];
        }
        [UIView commitAnimations];
    }];
    
    [RACObserve([LVVPNManager sharedInstance], VPNStatus) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        
        NSLog(@"vpn连接状态-----%@",x);
//        return ;
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:kConfigureSuccess] isEqualToString:kConfigureSuccess]) {
            return ;
        }
        VPNStatus status = [(NSNumber *)x integerValue];
        if (VPNStatus_off == status || VPNStatus_disconnecting == status) {
            self.connectView.status = LVConnectStatus_normal;
        }else if (VPNStatus_connecting == status) {
            self.connectView.status = LVConnectStatus_ing;
        }else if (VPNStatus_on == status) {
            self.connectView.status = LVConnectStatus_success;
        }else if (VPNStatus_fail == status) {
            self.connectView.status = LVConnectStatus_fail;
        }
    }];
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

- (LVMainNavigationView *)navigationView {
    if (!_navigationView) {
        _navigationView = [[LVMainNavigationView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kNavBarHeight)];
        _navigationView.delegate = self;
    }
    return _navigationView;
}

- (LVMainGetFreeView *)getFreeView {
    if (!_getFreeView) {
        _getFreeView = [[LVMainGetFreeView alloc] initWithFrame:CGRectMake(FITSCALE(25), FITHEIGHTSCALE(185), FITSCALE(326), FITHEIGHTSCALE(430))];
    }
    return _getFreeView;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        _maskView.alpha = 0;
        @weakify(self)
        [[_maskView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.lineView dismiss];
        }];
    }
    return _maskView;
}

- (LVMainLineSelecteView *)lineView {
    if (!_lineView) {
//        _lineView = [[LVMainLineSelecteView alloc] initWithFrame:CGRectMake(0, FITSCALE(287), kSCREEN_WIDTH, FITSCALE(525))];
        _lineView = [[LVMainLineSelecteView alloc] initWithFrame:CGRectMake(0,kSCREEN_HEIGHT - FITSCALE(90), kSCREEN_WIDTH, FITHEIGHTSCALE(525))];
        _lineView.delegate = self;
    }
    return _lineView;
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
    self.bgImgV = [[UIImageView alloc] initWithFrame:CGRectMake(-FITSCALE(37), -FITSCALE(185), FITSCALE(637.25), FITSCALE(725.76))];
    self.bgImgV.contentMode = UIViewContentModeScaleAspectFit;
    self.bgImgV.image = IMGNAME(@"icon_main_backGround_normal");
    [self.view addSubview:self.bgImgV];
    
    self.rocketImgV = [[UIImageView alloc] initWithFrame:CGRectMake(FITSCALE(156.32), FITSCALE(184.08), FITSCALE(96.51), FITSCALE(222.3))];
    self.rocketImgV.contentMode = UIViewContentModeScaleAspectFit;
    self.rocketImgV.image = IMGNAME(@"icon_main_rocket");
    self.rocketImgV.hidden = YES;
    [self.view addSubview:self.rocketImgV];
    
    UIImageView *bottomImgV = [[UIImageView alloc] initWithFrame:CGRectMake(-FITSCALE(30.5), kSCREEN_HEIGHT-FITSCALE(130.52), FITSCALE(458.39), FITSCALE(130.52))];
    bottomImgV.contentMode = UIViewContentModeScaleAspectFit;
    bottomImgV.image = IMGNAME(@"icon_main_bottomBg");
    [self.view addSubview:bottomImgV];
    
    self.noteView = [[LVMainConnectNoteView alloc] initWithFrame:CGRectMake((kSCREEN_WIDTH-FITSCALE(62))/2, FITHEIGHTSCALE(515), FITSCALE(62), FITSCALE(18))];
    [self.view addSubview:self.noteView];
    
    self.connectView = [[LVMainConnectButtonView alloc] initWithFrame:CGRectMake(FITSCALE(24), FITHEIGHTSCALE(553), kSCREEN_WIDTH-FITSCALE(48), FITSCALE(56))];
    self.connectView.delegate = self;
    [self.view addSubview:self.connectView];
    
    self.freeBtn = [[UIButton alloc] initWithFrame:CGRectMake(FITSCALE(18), FITHEIGHTSCALE(638), kSCREEN_WIDTH-FITSCALE(38), FITSCALE(18))];
    [self.freeBtn setTitle:@"限时免费领取一个月VIP" forState:UIControlStateNormal];
    [self.freeBtn setTitleColor:kColor_4872FF forState:UIControlStateNormal];
    [self.freeBtn setImage:IMGNAME(@"icon_menu_leftArrow") forState:UIControlStateNormal];
    self.freeBtn.titleLabel.font = FitFont(15);
    [self.freeBtn setImageDirection:RIGHT withSpan:FITSCALE(10)];
    [self.freeBtn addTarget:self action:@selector(getFreeVipMonth:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.freeBtn];
}

- (void)getFreeVipMonth:(UIButton *)sender {
    [self.getFreeView show];
}

#pragma mark - Protocol conformance

#pragma mark - LVMainNavigationViewDelegate
- (void)LVMainNavigationViewShowLeftMenuController {
    [self presentLeftMenuViewController:nil];
}

#pragma mark - LVMainConnectButtonViewDelegate
- (void)LVMainConnectButtonView:(LVMainConnectButtonView *)connectView clickWithStatus:(LVConnectStatus)status {
    /*
     LVConnectStatus_normal  = 0,//默认
     LVConnectStatus_ing     = 1,//连接中
     LVConnectStatus_success = 2,//链接成功
     LVConnectStatus_fail    = 3,//链接失败
     */
    if (LVConnectStatus_normal == status || LVConnectStatus_fail == status) {
        [[LVVPNManager sharedInstance] connect];
    }else if (LVConnectStatus_success == status) {
        [[LVVPNManager sharedInstance] disconnect];
    }else if (LVConnectStatus_fail == status) {
        
    }
}

#pragma mark - LVMainLineSelecteViewDelegate
- (void)LVMainLineSelecteView:(LVMainLineSelecteView *)view frameYChangePercent:(CGFloat)percent {
    self.maskView.alpha = percent;
}

@end
