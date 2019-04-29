//
//  LVLeftMenuVC.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/26.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "LVLeftMenuVC.h"
#import "LVLeftMenuHeaderView.h"
#import "LVLeftMenuCell.h"
#import "LVLeftMenuFooterView.h"
#import "LVAboutVC.h"

@interface LVLeftMenuVC ()<UITableViewDelegate,UITableViewDataSource,LVLeftMenuHeaderViewDelegate,LVLeftMenuFooterViewDelegate>

@property (nonatomic , strong) LVLeftMenuHeaderView *headerView;

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) LVLeftMenuFooterView *footerView;

@property (nonatomic , strong) NSArray *sourceArr;

@end

@implementation LVLeftMenuVC

static NSString * const cellIdentifier = @"cell";

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
    
    self.sourceArr = @[@{@"image":@"icon_menu_membership",@"title":@"VIP会员"},
                       @{@"image":@"icon_menu_share",@"title":@"分享给朋友"},
                       @{@"image":@"icon_menu_evaluate",@"title":@"给个好评"}];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footerView];
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

- (LVLeftMenuHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[LVLeftMenuHeaderView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, FITSCALE(330))];
    }
    return _headerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-self.footerView.height) style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[LVLeftMenuCell class] forCellReuseIdentifier:cellIdentifier];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.rowHeight = FITSCALE(56);
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _tableView.tableHeaderView = self.headerView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (LVLeftMenuFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[LVLeftMenuFooterView alloc] initWithFrame:CGRectMake(0, kSCREEN_HEIGHT-FITSCALE(66), kSCREEN_WIDTH, FITSCALE(66))];
        _footerView.delegate = self;
    }
    return _footerView;
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

#pragma mark - Protocol conformance

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LVLeftMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSDictionary *modelDic = self.sourceArr[indexPath.row];
    cell.image = modelDic[@"image"];
    cell.name = modelDic[@"title"];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击功能---%ld",(long)indexPath.row);
}

#pragma mark - LVLeftMenuHeaderViewDelegate
- (void)LVLeftMenuHeaderViewUpMemberShip {
    NSLog(@"升级会员-----");
}

#pragma mark - LVLeftMenuFooterViewDelegate

- (void)LVLeftMenuFooterViewFunctionAboutUS {
    LVAboutVC *vc = [[LVAboutVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
