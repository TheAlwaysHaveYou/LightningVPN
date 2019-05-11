//
//  UIWindow+MBProgressHUD.h
//  LightningVPN
//
//  Created by 范魁东 on 2019/5/10.
//  Copyright © 2019 FKD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (MBProgressHUD)

typedef void (^HUDFinishedHandler)(void);

/*
 * Shows an MBProgressHUD with the default spinner
 * The HUD is added as a subview to this view
 * controller's parentViewController.view.
 */
- (void)showHUD;

/*
 * Shows an MBProgressHUD with the default spinner
 * and sets the label text beneath the spinner
 * to the given message. The HUD is added as a subview
 * to this view controller's parentViewController.view.
 */
- (void)showHUDWithMessage:(NSString *)message;

/*
 * Dismisses the currently displayed HUD.
 */
- (void)hideHUD;

/*
 * Changes the currently displayed HUD's label text to
 * the given message and then dismisses the HUD after a
 * short delay.
 */
- (void)hideHUDWithCompletionMessage:(NSString *)message;

/*
 * Changes the currently displayed HUD's label text to
 * the given message and then dismisses the HUD after a
 * short delay. Additionally, runs the given completion
 * block after the HUD hides.
 */
- (void)hideHUDWithCompletionMessage:(NSString *)message finishedHandler:(HUDFinishedHandler)finishedHandler;

/**
 *  Shows an MBProgressHUD with pro
 *
 *  @param message custom text
 */
- (void)showHintHudWithMessage:(NSString *)message;


/**
 * 通过NSProgress 设置进度条 一般用于下载
 */
- (void)showProgress:(NSProgress *)progress message:(NSString *)message;
/**
 * 通过CGFloat 设置进度条
 */
- (void)showProgressFloat:(CGFloat)progressFloat message:(NSString *)message;
/**
 * 任务执行结束 调用的方法展示一张图片 延迟后隐藏 并返回block
 */
-(void)showCompleteImage:(NSString *)message finishedHandler:(HUDFinishedHandler)finishedHandler;


@end

NS_ASSUME_NONNULL_END
