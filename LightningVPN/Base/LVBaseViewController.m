//
//  LVBaseViewController.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/26.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "LVBaseViewController.h"

@interface LVBaseViewController ()

@end

@implementation LVBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBarHide = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:self.navigationBarHide animated:YES];
}


@end
