//
//  TradingCenterRoadshowLiveViewModel.m
//  TradingCenter
//
//  Created by N年後 on 2017/2/24.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "TradingCenterRoadshowLiveViewModel.h"
#import "MJExtension.h"

@implementation TradingCenterRoadshowLiveViewModel
+(NSDictionary *)objectClassInArray{
    return @{@"data":[TradingCenterRoadshowLive class]};
}



- (instancetype)init
{
    self = [super init];
    if (self) {
        _canLoadMore = NO;
        _isLoading = _willLoadMore = NO;
        _pageNo = [NSNumber numberWithInteger:1];
        _pageSize = [NSNumber numberWithInteger:15];

    }
    return self;
}





-(NSDictionary *)toTipsParams{

    NSDictionary *params = @{@"requestType" :@"LiveStream_Api",
                             @"apiType" :@"templeExchangeList",
                             @"exchangeId":self.exchangeId,
                             @"pageNo" : _willLoadMore? [NSNumber numberWithInteger:_pageNo.integerValue +1]: [NSNumber numberWithInteger:1],
                             @"pageSize" : _pageSize};
    return params;
}

// 采用懒加载的方式来配置网络请求
- (RACSignal *)requestSignal_templeExchangeList {

    if (!_requestSignal_templeExchangeList) {

        _requestSignal_templeExchangeList = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {


            [TRZXNetwork requestWithUrl:nil params:self.toTipsParams method:GET cachePolicy:NetworkingReloadIgnoringLocalCacheData callbackBlock:^(id response, NSError *error) {

                if (response) {

                    TradingCenterRoadshowLiveViewModel *model = [TradingCenterRoadshowLiveViewModel mj_objectWithKeyValues:response];
                    [self configWithObj:model];


                    [subscriber sendNext:self];
                    [subscriber sendCompleted];

                }else{
                    [subscriber sendError:error];
                }
            }];

            // 在信号量作废时，取消网络请求
            return [RACDisposable disposableWithBlock:^{

                [TRZXNetwork cancelRequestWithURL:@""];
            }];
        }];
    }
    return _requestSignal_templeExchangeList;
}

- (void)configWithObj:(TradingCenterRoadshowLiveViewModel *)model{

    self.pageNo = model.pageNo;
    self.pageSize = model.pageSize;
    self.totalPage = model.totalPage;

    if (_willLoadMore) {
        [self.data addObjectsFromArray:model.data];
    }else{
        self.data = [NSMutableArray arrayWithArray:model.data];
    }
    _canLoadMore = _pageNo.intValue < _totalPage.intValue&&_totalPage.intValue>1;
    
}

@end
