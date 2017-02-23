//
//  TradingCenterViewController.m
//  TradingCenter
//
//  Created by N年後 on 2017/2/23.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "TradingCenterViewController.h"
#import "TRZXKit.h"
#import "TradingCenterCell.h"
#import "TradingCenterViewModel.h"
#import "TRZXDIYRefresh.h"
#import "WMHomeViewController.h"

@interface TradingCenterViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) TradingCenterViewModel *tradingCenterViewModel;

@end

@implementation TradingCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.vcTitle;
    [self.view addSubview:self.collectionView];

    

}

// 发起请求
- (void)requestSignal_home {


    [self.tradingCenterViewModel.requestSignal_list subscribeNext:^(id x) {

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
    return self.tradingCenterViewModel.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TradingCenterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_TradingCenterCell forIndexPath:indexPath];
    TradingCenter *model = self.tradingCenterViewModel.data[indexPath.row];
    cell.model = model;
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    TradingCenter *model = self.tradingCenterViewModel.data[indexPath.row];
    WMHomeViewController *vc = [[WMHomeViewController alloc]initTradingCenterTitle:model.name tradingCenterId:model.mid];
    [self.navigationController pushViewController:vc animated:true];
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
        [_collectionView registerNib:[UINib nibWithNibName:kCellIdentifier_TradingCenterCell bundle:nil] forCellWithReuseIdentifier:kCellIdentifier_TradingCenterCell];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
        _collectionView.mj_header = [TRZXGifHeader headerWithRefreshingBlock:^{
            // 刷新数据
            [self requestSignal_home];
        }];
        [self.collectionView.mj_header beginRefreshing];


    }
    return _collectionView;
}



- (TradingCenterViewModel *)tradingCenterViewModel {

    if (!_tradingCenterViewModel) {
        _tradingCenterViewModel = [TradingCenterViewModel new];
    }
    return _tradingCenterViewModel;
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
