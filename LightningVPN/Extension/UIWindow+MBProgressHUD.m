//
//  UIWindow+MBProgressHUD.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/5/10.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "UIWindow+MBProgressHUD.h"
#import <objc/runtime.h>
#import "MBProgressHUD.h"

/* This key is used to dynamically create an instance variable
 * within the MBProgressHUD category using objc_setAssociatedObject
 */
const char *progressHUDKey = "progressHUDKey";

/* This key is used to dynamically create an instance variable
 * within the MBProgressHUD category using objc_setAssociatedObject
 */
const char *finishedHandlerKey = "finishedHandlerKey";

@interface UIWindow (MBProgressHUD_Private) <MBProgressHUDDelegate>

@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property (nonatomic, copy) HUDFinishedHandler finishedHandler;

@end

@implementation UIWindow (MBProgressHUD)

- (MBProgressHUD *)progressHUD {
    MBProgressHUD *hud = objc_getAssociatedObject(self, progressHUDKey);
    if(!hud) {
        UIView *hudSuperView = self;
        hud = [[MBProgressHUD alloc] initWithView:hudSuperView];
//        hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        hud.bezelView.color = [UIColor blackColor];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.contentColor = [UIColor whiteColor];
        hud.removeFromSuperViewOnHide = YES;
        hud.delegate = self;
        [hudSuperView addSubview:hud];
        self.progressHUD = hud;
    }
    return hud;
}

- (void)setProgressHUD:(MBProgressHUD *)progressHUD {
    objc_setAssociatedObject(self, progressHUDKey, progressHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (HUDFinishedHandler)finishedHandler {
    HUDFinishedHandler block = objc_getAssociatedObject(self, finishedHandlerKey);
    return block;
}

- (void)setFinishedHandler:(HUDFinishedHandler)completionBlock {
    objc_setAssociatedObject(self, finishedHandlerKey, completionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)_showHUDWithMessage:(NSString *)message {
    self.progressHUD.mode = MBProgressHUDModeIndeterminate;
    self.progressHUD.label.text = message;
    [self.progressHUD showAnimated:YES];
}

- (void)showHUD {
    static NSInteger number = 0;
    number ++;
    NSLog(@"显示的次数----%d",number);
    [self _showHUDWithMessage:nil];
}

- (void)showHUDWithMessage:(NSString *)message {
    [self _showHUDWithMessage:message];
}

- (void)hideHUD {
    static NSInteger number = 0;
    number ++;
    NSLog(@"隐藏的次数----%d",number);
    [self.progressHUD hideAnimated:YES];
}

- (void)hideHUDWithCompletionMessage:(NSString *)message {
    self.progressHUD.label.text = message;
    [self.progressHUD hideAnimated:YES afterDelay:1];
}

- (void)hideHUDWithCompletionMessage:(NSString *)message finishedHandler:(HUDFinishedHandler)finishedHandler {
    self.progressHUD.delegate = self;
    self.finishedHandler = finishedHandler;
    [self hideHUDWithCompletionMessage:message];
}



- (void)showHintHudWithMessage:(NSString *)message {
    
    self.progressHUD.mode = MBProgressHUDModeText;
    self.progressHUD.label.text = message;
    self.progressHUD.margin = 10.f;
    
    [self.progressHUD showAnimated:YES];
    [self.progressHUD hideAnimated:YES afterDelay:2];
}


- (void)showProgress:(NSProgress *)progress message:(NSString *)message{
    if (self.progressHUD.mode != MBProgressHUDModeAnnularDeterminate) {
        [self setProgress:message];
    }
    self.progressHUD.progress = (1.0 * progress.completedUnitCount / progress.totalUnitCount);
    self.progressHUD.label.text  = [NSString stringWithFormat:@"%@:%lld/%lldKB",message,progress.completedUnitCount/1024,progress.totalUnitCount/1024];
}

- (void)showProgressFloat:(CGFloat)progressFloat message:(NSString *)message {
    if (self.progressHUD.mode != MBProgressHUDModeAnnularDeterminate) {
        [self setProgress:message];
    }
    self.progressHUD.progress = progressFloat;
    self.progressHUD.label.text  =  [NSString stringWithFormat:@"%@:%.f%% ",message,progressFloat*100];
}

- (void)setProgress:(NSString *)message {
    self.progressHUD.mode = MBProgressHUDModeAnnularDeterminate;
    self.progressHUD.label.text = message;
    self.progressHUD.margin = 10.f;
    self.progressHUD.progress = 0.f;
    [self.progressHUD showAnimated:YES];
}


- (void)showCompleteImage:(NSString *)message finishedHandler:(HUDFinishedHandler)finishedHandler{
    self.progressHUD.delegate = self;
    self.finishedHandler = finishedHandler;
    
    UIImage *image = [[UIImage imageNamed:@"ico_HUD_CheckMark.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.progressHUD.customView = [[UIImageView alloc] initWithImage:image];
    self.progressHUD.mode = MBProgressHUDModeCustomView;
    self.progressHUD.label.text = message;
    
    [self.progressHUD showAnimated:YES];
    [self.progressHUD hideAnimated:YES afterDelay:2];
    
}

#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud {
    if(self.finishedHandler) {
        self.finishedHandler();
        self.finishedHandler = nil;
    }
    [self.progressHUD removeFromSuperview];
    self.progressHUD.delegate = nil;
    self.progressHUD = nil;
}

@end
