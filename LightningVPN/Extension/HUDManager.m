//
//  HUDManager.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/5/11.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "HUDManager.h"
#import "MBProgressHUD.h"

@interface HUDManager ()<MBProgressHUDDelegate>

@property (nonatomic , strong)MBProgressHUD *hud;

@property (nonatomic , assign , getter=isShow) BOOL show;
@end


@implementation HUDManager
    
+ (instancetype)sharedInstance {
    static HUDManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HUDManager alloc] init];
        manager.show = NO;
    });
    return manager;
}

- (MBProgressHUD *)hud {
    if (!_hud) {
        UIView *view = [UIApplication sharedApplication].delegate.window;
        _hud = [[MBProgressHUD alloc] initWithView:view];
        _hud.bezelView.color = [UIColor blackColor];
        _hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        _hud.contentColor = [UIColor whiteColor];
        _hud.removeFromSuperViewOnHide = YES;
        _hud.delegate = self;
        [view addSubview:_hud];
    }
    return _hud;
}

- (void)show {
    if (self.isShow) {
        return;
    }
    self.show = YES;
    [self.hud showAnimated:YES];
}
- (void)hide {
    if (!self.isShow) {
        return;
    }
    self.show = NO;
    [self.hud hideAnimated:YES];
}

#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud {
//    if(self.finishedHandler) {
//        self.finishedHandler();
//        self.finishedHandler = nil;
//    }
    [self.hud removeFromSuperview];
    self.hud.delegate = nil;
    self.hud = nil;
}

@end

