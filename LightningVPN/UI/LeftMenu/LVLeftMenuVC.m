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
#import "LVLeftMenuVIPBuyView.h"
#import <StoreKit/StoreKit.h>

#define VerifyTestEnvironment @"https://sandbox.itunes.apple.com/verifyReceipt"//测试环境验证
#define VerifyRealEnvironment @"https://buy.itunes.apple.com/verifyReceipt"//正式环境验证

@interface LVLeftMenuVC ()<UITableViewDelegate,UITableViewDataSource,LVLeftMenuHeaderViewDelegate,LVLeftMenuFooterViewDelegate,LVLeftMenuVIPBuyViewDelegate,SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property (nonatomic , strong) LVLeftMenuHeaderView *headerView;

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) LVLeftMenuFooterView *footerView;

@property (nonatomic , strong) NSArray *sourceArr;

@property (nonatomic , strong) LVLeftMenuVIPBuyView *buyView;

@property (nonatomic, strong) NSString *currentPayID;

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
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
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
    
    [self setupStoreKitObserver];
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

- (LVLeftMenuVIPBuyView *)buyView {
    if (!_buyView) {
        _buyView = [[LVLeftMenuVIPBuyView alloc] initWithFrame:CGRectMake(0, FITHEIGHTSCALE(184), kSCREEN_WIDTH, FITHEIGHTSCALE(628))];
        _buyView.delegate = self;
    }
    return _buyView;
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

- (void)setupStoreKitObserver {
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    if ([SKPaymentQueue canMakePayments]) {
        NSLog(@"功能完全,支持购买++++++++");
    }else {
        NSLog(@"当前设备不支持购买功能");
    }
}

- (void)requestProductData:(NSString *)type {
    NSArray *product = @[type];
    NSSet *set = [NSSet setWithArray:product];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
    request.delegate = self;
    [request start];
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
    
    [self.buyView show];
}

#pragma mark - LVLeftMenuHeaderViewDelegate
- (void)LVLeftMenuHeaderViewUpMemberShip {
    NSLog(@"升级会员-----");
}

#pragma mark - LVLeftMenuFooterViewDelegate

- (void)LVLeftMenuFooterViewFunctionAboutUS {
    
    LVAboutVC *vc = [[LVAboutVC alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    [self.sideMenuViewController.navigationController pushViewController:vc animated:YES];
}

#pragma mark - LVLeftMenuVIPBuyViewDelegate
- (void)LVLeftMenuVIPBuyView:(LVLeftMenuVIPBuyView *)view didSelectedBuyModel:(LVLeftMenuVIPBuyModel *)model {
    NSLog(@"购买的---%@",model.time);
    if (!model) {
        self.currentPayID = @"";
        return;
    }
    
    //判断设备是否具备购买权限
    if ([SKPaymentQueue canMakePayments]) {
        self.currentPayID = model.buyID;
        [self requestProductData:self.currentPayID];
    }
}

#pragma mark - SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSArray *product = response.products;
    if (product.count == 0) {
        return;
    }
    
    SKProduct *p;
    for (SKProduct *pro in product) {
        NSLog(@"收到产品信息 %@  %@  %@  %@  %@",pro.description,pro.localizedTitle,pro.localizedDescription,pro.price,pro.productIdentifier);
        
        if ([pro.productIdentifier isEqualToString:self.currentPayID]) {
            p = pro;
        }
    }
    
    SKPayment *payment = [SKPayment paymentWithProduct:p];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    //获取失败
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[error localizedDescription] delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)requestDidFinish:(SKRequest *)request {
    //请求结束
}

#pragma mark - SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    for (SKPaymentTransaction *tran in transactions) {
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加到列表");
                break;
            case SKPaymentTransactionStatePurchased:
                NSLog(@"购买成功");
                [self completeTransaction:tran];
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"购买失败");
                
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"这是已经购买过的商品");
                
                break;
                
            default:
                break;
        }
    }
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    //交易验证
    //In the test environment, use https://sandbox.itunes.apple.com/verifyReceipt
    //In the real environment, use https://buy.itunes.apple.com/verifyReceipt
    [self verifyReceiptToAppleServerWithURL:VerifyRealEnvironment];
}

- (void)verifyReceiptToAppleServerWithURL:(NSString *)url {
    NSURL *recepitURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receipt = [NSData dataWithContentsOfURL:recepitURL];
    if (!receipt) {
        return;
    }
    NSError *error;
    NSDictionary *requestContents = @{@"receipt-data": [receipt base64EncodedStringWithOptions:0] };
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestContents options:0 error:&error];
    if (!requestData) {
        return;
    }
    
    //服务器保存票据
//    NSString *payType;//1-月卡，2-季卡，3-年卡
//    if ([self.currentPayID isEqualToString:BBYProductSeasonID]) {//季卡
//        payType = @"1";
//    }else if ([self.currentPayID isEqualToString:BBYProductMonthID]) {//月卡
//        payType = @"2";
//    }else if ([self.currentPayID isEqualToString:BBYProduct3000ShallID]) {//年卡
//        payType = @"3";
//    }
//    [[self.viewModel.saveReceiptCommand execute:RACTuplePack([receipt base64EncodedStringWithOptions:0],NotNilString(payType))] subscribeNext:^(NSNumber *payID) {
//        NSLog(@"-----%@------------保存票据获得相应的ID",payID);
//        self.userPayID = payID;
//    }];
    
    
    NSURL *storeURL = [NSURL URLWithString:url];
    NSMutableURLRequest *storeRequest = [NSMutableURLRequest requestWithURL:storeURL];
    [storeRequest setHTTPMethod:@"POST"];
    [storeRequest setHTTPBody:requestData];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
//    NSURLSession *sesson =  [[NSURLSession alloc] init];
//    [sesson dataTaskWithRequest:storeRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//    }];
    
    [NSURLConnection sendAsynchronousRequest:storeRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (connectionError) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[connectionError localizedDescription] delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
                [alert show];
            } else {
                NSError *error;
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                NSLog(@"官网验证返回    %@",jsonResponse);
                if (!jsonResponse) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[error localizedDescription] delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
                    [alert show];
                }
                
                NSNumber *status = jsonResponse[@"status"];
                if (status.intValue == 0) {
                    //status code 0为成功
                    NSString *productId = [jsonResponse[@"receipt"][@"in_app"] firstObject][@"product_id"];
                    //            NSString *productId = jsonResponse[@"receipt"][@"product_id"];
                    NSLog(@"产品 productID  ---- %@",productId);
                    
//                    [[self.viewModel.verifySuccessCommad execute:RACTuplePack(self.userPayID,@(1))] subscribeNext:^(id x) {
//                        [self showHintHudWithMessage:@"充值成功"];
//                    }];//发送1确认验证成功 2未成功
                    
                } else {
                    //校验失败
                    //21000 App Store不能读取你提供的JSON对象
                    //21002 receipt-data域的数据有问题
                    //21003 receipt无法通过验证
                    //21004 提供的shared secret不匹配你账号中的shared secret
                    //21005 receipt服务器当前不可用
                    //21006 receipt合法，但是订阅已过期。服务器接收到这个状态码时，receipt数据仍然会解码并一起发送
                    //21007 receipt是Sandbox receipt，但却发送至生产系统的验证服务
                    //21008 receipt是生产receipt，但却发送至Sandbox环境的验证服务
                    if (status.intValue == 21007) {//苹果审核的时候,用的是沙盒环境,要重新换沙盒URL
                        [self verifyReceiptToAppleServerWithURL:VerifyTestEnvironment];
                    }
                }
            }
        });
    }];
}

@end
