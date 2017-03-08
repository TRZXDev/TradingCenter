//
//  WMHomeViewController.m
//  Demo
//
//  Created by Mark on 16/7/25.
//  Copyright © 2016年 Wecan Studio. All rights reserved.
//

#import "WMHomeViewController.h"
#import "WMTableViewController.h"
#import "WMPanGestureRecognizer.h"
#import "TradingCenterHomeViewModel.h"
#import "TRZXKit.h"
#import "TRZXShufflingView.h"
#import "TradingCenterWebViewController.h" //
#import "TradingCenterListedProjectViewController.h"
#import "TradingCenterRoadshowLiveViewController.h"
#import "TradingCenterActivityTrailerViewController.h"
#import <TRZXWebViewCategory/CTMediator+TRZXWebView.h>

@interface WMHomeViewController () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSArray *musicCategories;
@property (nonatomic, strong) WMPanGestureRecognizer *panGesture;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, assign) CGFloat kWMHeaderViewHeight;

@property (strong, nonatomic) TradingCenterHomeViewModel *tradingCenterHomeViewModel;
@property (nonatomic, copy) NSString *tradingCenterId;
@property (nonatomic, strong) TRZXShufflingView *shufflingView;
@property (strong, nonatomic) TradingCenterWebViewController *tradingCenterWebViewController;



@end

@implementation WMHomeViewController

- (NSArray *)musicCategories {
    if (!_musicCategories) {
        _musicCategories = @[@"中心介绍", @"挂牌项目", @"路演直播",@"活动预告"];
    }
    return _musicCategories;
}

- (instancetype)initTradingCenterTitle:(NSString*)title tradingCenterId:(NSString*)tradingCenterId {
    if (self = [super init]) {
        self.title = title;
        self.tradingCenterId = tradingCenterId;

        self.kWMHeaderViewHeight = [UIScreen mainScreen].bounds.size.width *9/16;

        self.titleSizeNormal = 16;
        self.titleSizeSelected = 16;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / self.musicCategories.count;
        self.menuHeight = 50;
        self.viewTop = kNavigationBarHeight + self.kWMHeaderViewHeight;
        self.titleColorSelected = [UIColor trzx_NavTitleColor];
        self.titleColorNormal = [UIColor trzx_NavTitleColor];
        self.menuBGColor = [UIColor whiteColor];
        self.progressColor = [UIColor redColor];

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    self.panGesture = [[WMPanGestureRecognizer alloc] initWithTarget:self action:@selector(panOnView:)];
    [self.view addGestureRecognizer:self.panGesture];



    // 必须写在后面
    [self.view insertSubview:self.shufflingView atIndex:0];

     [self requestSignal_top];
}



// 发起请求
- (void)requestSignal_top {

    [self.tradingCenterHomeViewModel.requestSignal_top subscribeNext:^(id x) {


        if (self.tradingCenterHomeViewModel.topImagesArray.count>0) {
            // 请求完成后，更新UI
            [self.shufflingView images:self.tradingCenterHomeViewModel.topImagesArray];
        }

        self.tradingCenterWebViewController.webURL = self.tradingCenterHomeViewModel.webURL;

    } error:^(NSError *error) {
        // 如果请求失败，则根据error做出相应提示
        
    }];
}


- (void)panOnView:(WMPanGestureRecognizer *)recognizer {
    NSLog(@"pannnnnning received..");
    
    CGPoint currentPoint = [recognizer locationInView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.lastPoint = currentPoint;
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat targetPoint = velocity.y < 0 ? kNavigationBarHeight : kNavigationBarHeight + self.kWMHeaderViewHeight;
        NSTimeInterval duration = fabs((targetPoint - self.viewTop) / velocity.y);
        
        if (fabs(velocity.y) * 1.0 > fabs(targetPoint - self.viewTop)) {
            NSLog(@"velocity: %lf", velocity.y);
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.viewTop = targetPoint;
            } completion:nil];
            
            return;
        }
        
    }
    CGFloat yChange = currentPoint.y - self.lastPoint.y;
    self.viewTop += yChange;
    self.lastPoint = currentPoint;



    // 轮播跟随滑动
    self.shufflingView.top = self.viewTop - [UIScreen mainScreen].bounds.size.width *9/16;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        self.shufflingView.top = self.viewTop - [UIScreen mainScreen].bounds.size.width *9/16;
    });


}

// MARK: ChangeViewFrame (Animatable)
- (void)setViewTop:(CGFloat)viewTop {
    
    _viewTop = viewTop;



    if (_viewTop <= kNavigationBarHeight) {
        _viewTop = kNavigationBarHeight;
    }
    
    if (_viewTop > self.kWMHeaderViewHeight + kNavigationBarHeight) {
        _viewTop = self.kWMHeaderViewHeight + kNavigationBarHeight;
    }
    
    self.viewFrame = CGRectMake(0, _viewTop, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - _viewTop);



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Datasource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.musicCategories.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {

    switch (index) {
        case 0: {
            self.tradingCenterWebViewController = [[TradingCenterWebViewController alloc] init];
            return self.tradingCenterWebViewController;
        }
            break;
        case 1: {
            TradingCenterListedProjectViewController *vc = [[TradingCenterListedProjectViewController alloc] init];
            return vc;
        }
        case 2: {
            TradingCenterRoadshowLiveViewController *vc = [[TradingCenterRoadshowLiveViewController alloc] init];
            vc.exchangeId = self.tradingCenterHomeViewModel.exchangeId;
            return vc;
        }
        case 3: {
            TradingCenterActivityTrailerViewController *vc = [[TradingCenterActivityTrailerViewController alloc] init];
            vc.exchangeId = self.tradingCenterHomeViewModel.exchangeId;
            return vc;
        }
        default: {
            return [[UIViewController alloc] init];
        }
            break;
    }



    WMTableViewController *vc = [[WMTableViewController alloc] init];
    return vc;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.musicCategories[index];
}

-(TRZXShufflingView *)shufflingView{

    __weak WMHomeViewController *weakSelf = self;

    if (!_shufflingView) {
        _shufflingView = [[TRZXShufflingView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.width*9/16)];
        _shufflingView.didClickImageAtIndexBlock = ^(NSInteger index){

            NSDictionary *dic = weakSelf.tradingCenterHomeViewModel.topDicArray[index];
            UIViewController *goodsDetailVC = [[CTMediator sharedInstance] webViewControllerWithWebURL:dic[@"picUrl"]];
            if (goodsDetailVC) {
                [weakSelf.navigationController pushViewController:goodsDetailVC animated:YES];
            }

        };
    }
    return _shufflingView;
}

- (TradingCenterHomeViewModel *)tradingCenterHomeViewModel {

    if (!_tradingCenterHomeViewModel) {
        _tradingCenterHomeViewModel = [TradingCenterHomeViewModel new];
        _tradingCenterHomeViewModel.exchangeId = self.tradingCenterId;

    }
    return _tradingCenterHomeViewModel;
}

@end
