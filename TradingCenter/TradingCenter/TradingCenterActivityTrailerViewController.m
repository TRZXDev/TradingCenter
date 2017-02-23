//
//  TradingCenterActivityTrailerViewController.m
//  TradingCenter
//
//  Created by N年後 on 2017/2/23.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "TradingCenterActivityTrailerViewController.h"
#import "TradingCenterHomeViewModel.h"
#import "TradingCenterActivityTrailer.h"
#import "TradingCenterActivityCell.h"
#import "TradingCenterTrailerCell.h"
#import "TRZXDIYRefresh.h"
#import "TRZXKit.h"
#import <TRZXWebViewCategory/CTMediator+TRZXWebView.h>

@interface TradingCenterActivityTrailerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) TradingCenterHomeViewModel *tradingCenterHomeViewModel;
@property (nonatomic, strong) UITableView *activityTrailerTableView;

@end

@implementation TradingCenterActivityTrailerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.activityTrailerTableView];


}



- (void)refresh{

    self.tradingCenterHomeViewModel.willLoadMore = NO;
    [self.activityTrailerTableView.mj_footer resetNoMoreData];
    [self requestSignal_activityTrailer];}

- (void)refreshMore{
    if (!self.tradingCenterHomeViewModel.canLoadMore) {
        [self.activityTrailerTableView.mj_footer setState:MJRefreshStateNoMoreData];
        return;
    }
    self.tradingCenterHomeViewModel.willLoadMore = YES;
    [self requestSignal_activityTrailer];}


// 发起请求
- (void)requestSignal_activityTrailer {

    [self.tradingCenterHomeViewModel.requestSignal_activityTrailer subscribeNext:^(id x) {

        // 请求完成后，更新UI
        // 结束刷新状态
        if (self.tradingCenterHomeViewModel.willLoadMore) {
            [self.activityTrailerTableView.mj_footer endRefreshing];
        }else{
            [self.activityTrailerTableView.mj_header endRefreshing];
        }

        [self.activityTrailerTableView reloadData];

    } error:^(NSError *error) {
        // 如果请求失败，则根据error做出相应提示
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tradingCenterHomeViewModel.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    TradingCenterActivityTrailer *model = [self.tradingCenterHomeViewModel.data objectAtIndex:indexPath.row];


    if ([model.msgType integerValue]==0) {  //活动

        TradingCenterActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TradingCenterActivityCell];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:kCellIdentifier_TradingCenterActivityCell owner:self options:nil] lastObject];
        }
        cell.model = model;
        return cell;

    }else{
        TradingCenterTrailerCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TradingCenterTrailerCell];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:kCellIdentifier_TradingCenterTrailerCell owner:self options:nil] lastObject];
        }
        cell.model = model;

        return cell;

    }



}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //行被选中后，自动变回反选状态的方法
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TradingCenterActivityTrailer *model = [self.tradingCenterHomeViewModel.data objectAtIndex:indexPath.row];

    UIViewController *goodsDetailVC = [[CTMediator sharedInstance] webViewControllerWithWebURL:model.msgView];
    if (goodsDetailVC) {
        [self.navigationController pushViewController:goodsDetailVC animated:YES];
    }


}


-(UITableView *)activityTrailerTableView{
    if (!_activityTrailerTableView) {
        // 内容视图
        _activityTrailerTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _activityTrailerTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _activityTrailerTableView.frame = CGRectMake(0, 0, self.view.width, self.view.height-114);
        _activityTrailerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _activityTrailerTableView.dataSource = self;
        _activityTrailerTableView.delegate = self;
        _activityTrailerTableView.estimatedRowHeight = 103;  //  随便设个不那么离谱的值
        _activityTrailerTableView.rowHeight = UITableViewAutomaticDimension;
        // 去除顶部空白
        _activityTrailerTableView.tableHeaderView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MIN, CGFLOAT_MIN)];;
        _activityTrailerTableView.tableFooterView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MIN, CGFLOAT_MIN)];;
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
        _activityTrailerTableView.mj_header = [TRZXGifHeader headerWithRefreshingBlock:^{
            // 刷新数据
            [self refresh];
        }];
        [ self.activityTrailerTableView.mj_header beginRefreshing];

        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadLastData方法）
        _activityTrailerTableView.mj_footer = [TRZXGifFooter footerWithRefreshingBlock:^{
            [self refreshMore];

        }];
        _activityTrailerTableView.mj_footer.automaticallyHidden = YES;



    }
    return _activityTrailerTableView;
}




- (TradingCenterHomeViewModel *)tradingCenterHomeViewModel {

    if (!_tradingCenterHomeViewModel) {
        _tradingCenterHomeViewModel = [TradingCenterHomeViewModel new];
        _tradingCenterHomeViewModel.exchangeId = self.exchangeId;

    }
    return _tradingCenterHomeViewModel;
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
