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


@interface LVMainVC ()<LVMainNavigationViewDelegate,LVMainConnectButtonViewDelegate>

@property (nonatomic , strong) LVMainNavigationView *navigationView;

@property (nonatomic , strong) UIImageView *bgImgV;
@property (nonatomic , strong) UIImageView *rocketImgV;

@property (nonatomic , strong) LVMainConnectNoteView *noteView;
@property (nonatomic , strong) LVMainConnectButtonView *connectView;

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
    
    self.noteView = [[LVMainConnectNoteView alloc] initWithFrame:CGRectMake((kSCREEN_WIDTH-FITSCALE(62))/2, FITSCALE(515), FITSCALE(62), FITSCALE(18))];
    [self.view addSubview:self.noteView];
    
    self.connectView = [[LVMainConnectButtonView alloc] initWithFrame:CGRectMake(FITSCALE(24), FITSCALE(553), kSCREEN_WIDTH-FITSCALE(48), FITSCALE(56))];
    self.connectView.delegate = self;
    [self.view addSubview:self.connectView];
}

#pragma mark - Protocol conformance

#pragma mark - LVMainNavigationViewDelegate
- (void)LVMainNavigationViewShowLeftMenuController {
    [self presentLeftMenuViewController:nil];
}

#pragma mark - LVMainConnectButtonViewDelegate
- (void)LVMainConnectButtonView:(LVMainConnectButtonView *)connectView clickWithStatus:(LVConnectStatus)status {
    
}

@end
