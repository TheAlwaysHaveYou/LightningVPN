//
//  AppDelegate.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/26.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "AppDelegate.h"
#import "LVLaunchVC.h"
#import "RESideMenu.h"
#import "IQKeyboardManager.h"
#import "LVLeftMenuVC.h"
#import "LVMainVC.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "StartIntentIntent.h"
#import "LVVPNManager.h"

@interface AppDelegate ()<RESideMenuDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self enterLeadController];
    
    [IQKeyboardManager sharedManager].previousNextDisplayMode = IQPreviousNextDisplayModeAlwaysHide;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    return YES;
}

- (void)enterLeadController {
    static NSString *versionKay = @"VersionKey";
    
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults] objectForKey:versionKay];

    if ([app_Version isEqualToString:oldVersion]) {
        [self enterRootcontroller];
    }else {
        [[NSUserDefaults standardUserDefaults] setValue:app_Version forKey:versionKay];
        [[NSUserDefaults standardUserDefaults] synchronize];

        LVLaunchVC *vc = [[LVLaunchVC alloc] init];
        vc.subject = [RACSubject subject];
        @weakify(self)
        [[vc.subject deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
            @strongify(self)
            [self enterRootcontroller];
        }];
        self.window.rootViewController = vc;
    }
}

- (void)enterRootcontroller {
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:[[LVMainVC alloc] init]];
    UINavigationController *leftNav = [[UINavigationController alloc] initWithRootViewController:[[LVLeftMenuVC alloc] init]];
    
    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:mainNav
                                                                    leftMenuViewController:leftNav
                                                                   rightMenuViewController:nil];
    
    sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
    sideMenuViewController.delegate = self;
    sideMenuViewController.bouncesHorizontally = NO;
    
//    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
//    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
//    sideMenuViewController.contentViewShadowOpacity = 0.6;
//    sideMenuViewController.contentViewShadowRadius = 12;
//    sideMenuViewController.contentViewShadowEnabled = YES;
    
    UINavigationController *baseNav = [[UINavigationController alloc] initWithRootViewController:sideMenuViewController];
    [sideMenuViewController.navigationController setNavigationBarHidden:YES animated:YES];
    self.window.rootViewController = baseNav;
}

#pragma mark - RESideMenuDelegate


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler {
    if (@available(iOS 12.0, *)) {
        if([userActivity.interaction.intent isKindOfClass:[StartIntentIntent class]]){
            NSLog(@"唤醒处理数据啦+++++++++++++++++");
            if (VPNStatus_on == [LVVPNManager sharedInstance].VPNStatus) {
                [[LVVPNManager sharedInstance] disconnect];
            }else {
                [[LVVPNManager sharedInstance] connect];
            }
        }
    }
    return YES;
}

@end
