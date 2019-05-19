//
//  LVLaunchVC.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/5/7.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "LVLaunchVC.h"
#import "LVLaunchCell.h"

@interface LVLaunchVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView *collectionView;

@property (nonatomic , strong) UIPageControl *pageControl;

@property (nonatomic , strong) UIButton *enterBtn;

@property (nonatomic , strong) NSArray <LVLaunchModel *> *dataArr;

@end

@implementation LVLaunchVC

static NSString * const identifier = @"item";

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray <NSArray <NSString *> *> *tempArr = @[@[@"icon_launch_one",@"支持Siri捷径",@"无需打开软件，在任何界面唤醒Siri，\n说出指令，即可快速连接。"],
                         @[@"icon_launch_two",@"价格最优惠",@"用最低的价格，即可体验最好的优质服务，\n这是最具性价比的选择"],
                         @[@"icon_launch_three",@"超高速专线",@"独家超高速专线，让你畅享超高清音乐\n和高清视频"],];
    NSMutableArray *modelArr = [NSMutableArray array];
    [tempArr enumerateObjectsUsingBlock:^(NSArray<NSString *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LVLaunchModel *model = [[LVLaunchModel alloc] init];
        model.imageName = obj[0];
        model.title = obj[1];
        model.detail = obj[2];
        [modelArr addObject:model];
    }];
    self.dataArr = [modelArr copy];
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.pageControl];
    [self.view addSubview:self.enterBtn];
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

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(kSCREEN_WIDTH, FITHEIGHTSCALE(666));
        layout.sectionInset = UIEdgeInsetsZero;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, FITHEIGHTSCALE(666)) collectionViewLayout:layout];
        _collectionView.backgroundColor =[UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[LVLaunchCell class] forCellWithReuseIdentifier:identifier];
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((kSCREEN_WIDTH-FITSCALE(58))/2, FITHEIGHTSCALE(666), FITSCALE(58), FITSCALE(10))];
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.numberOfPages = self.dataArr.count;
        _pageControl.pageIndicatorTintColor = [kColor_4872FF colorWithAlphaComponent:0.4];
        _pageControl.currentPageIndicatorTintColor = kColor_4872FF;
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

- (UIButton *)enterBtn {
    if (!_enterBtn) {
        _enterBtn = [[UIButton alloc] initWithFrame:CGRectMake(FITSCALE(24), FITHEIGHTSCALE(716), kSCREEN_WIDTH-FITSCALE(24*2), FITSCALE(56))];
        [_enterBtn setTitle:@"开始使用" forState:UIControlStateNormal];
        [_enterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _enterBtn.titleLabel.font = FitFont(17);
        _enterBtn.layer.backgroundColor = kColor_4872FF.CGColor;
        _enterBtn.layer.cornerRadius = _enterBtn.frame.size.height/2;
        _enterBtn.layer.shadowColor = kColor_4872FF.CGColor;
        _enterBtn.layer.shadowOffset = CGSizeMake(0, 5);
        _enterBtn.layer.shadowOpacity = 0.5;
        
        [_enterBtn addTarget:self action:@selector(enterMainViewController:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _enterBtn;
}

- (void)enterMainViewController:(UIButton *)button {
    if (self.subject) {
        [self.subject sendNext:nil];
    }
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
#pragma mark - UICollectionViewDelegate,

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LVLaunchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    LVLaunchModel *model = self.dataArr[indexPath.item];
    cell.model = model;
    
    return cell;
}

#pragma mark - UICollectionViewDataSource

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger offSet = scrollView.contentOffset.x / kSCREEN_WIDTH;
    self.pageControl.currentPage = offSet;
}

@end
