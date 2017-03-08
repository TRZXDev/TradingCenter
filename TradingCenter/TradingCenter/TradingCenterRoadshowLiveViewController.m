//
//  TradingCenterRoadshowLiveViewController.m
//  TradingCenter
//
//  Created by N年後 on 2017/2/23.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "TradingCenterRoadshowLiveViewController.h"
#import "TRZXKit.h"
#import "TradingCenterRoadshowLiveViewModel.h"
#import "TRZXDIYRefresh.h"
#import "TradingCenterRoadshowLiveCell.h"
@interface TradingCenterRoadshowLiveViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) TradingCenterRoadshowLiveViewModel *tradingCenterRoadshowLiveViewModel;
@end

@implementation TradingCenterRoadshowLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.collectionView];

}


// 发起请求
- (void)requestSignal_templeExchangeList {


    [self.tradingCenterRoadshowLiveViewModel.requestSignal_templeExchangeList subscribeNext:^(id x) {

        // 请求完成后，更新UI
        [self.collectionView.mj_header endRefreshing];

        [self.collectionView reloadData];

    } error:^(NSError *error) {
        // 如果请求失败，则根据error做出相应提示
        [self.collectionView.mj_header endRefreshing];
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tradingCenterRoadshowLiveViewModel.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TradingCenterRoadshowLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_TradingCenterRoadshowLiveCell forIndexPath:indexPath];
    TradingCenterRoadshowLive *model = self.tradingCenterRoadshowLiveViewModel.data[indexPath.row];
    cell.model = model;
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{


}



-(UICollectionView *)collectionView{
    if (!_collectionView) {

        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemW = (self.view.width-30) / 2;
        CGFloat itemH = itemW;
        layout.itemSize = CGSizeMake(itemW, itemH);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(10,10,0,10);


        // 内容视图
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_collectionView registerNib:[UINib nibWithNibName:kCellIdentifier_TradingCenterRoadshowLiveCell bundle:nil] forCellWithReuseIdentifier:kCellIdentifier_TradingCenterRoadshowLiveCell];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
        _collectionView.mj_header = [TRZXGifHeader headerWithRefreshingBlock:^{
            // 刷新数据
            [self refresh];
        }];
        [ self.collectionView.mj_header beginRefreshing];

        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadLastData方法）
        _collectionView.mj_footer = [TRZXGifFooter footerWithRefreshingBlock:^{
            [self refreshMore];

        }];
        _collectionView.mj_footer.automaticallyHidden = YES;


    }
    return _collectionView;
}

- (void)refresh{

    self.tradingCenterRoadshowLiveViewModel.willLoadMore = NO;
    [self.collectionView.mj_footer resetNoMoreData];
    [self requestSignal_templeExchangeList];}

- (void)refreshMore{
    if (!self.tradingCenterRoadshowLiveViewModel.canLoadMore) {
        [self.collectionView.mj_footer setState:MJRefreshStateNoMoreData];
        return;
    }
    self.tradingCenterRoadshowLiveViewModel.willLoadMore = YES;
    [self requestSignal_templeExchangeList];
}




- (TradingCenterRoadshowLiveViewModel *)tradingCenterRoadshowLiveViewModel {

    if (!_tradingCenterRoadshowLiveViewModel) {
        _tradingCenterRoadshowLiveViewModel = [TradingCenterRoadshowLiveViewModel new];
        _tradingCenterRoadshowLiveViewModel.exchangeId = self.exchangeId;

    }
    return _tradingCenterRoadshowLiveViewModel;
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
