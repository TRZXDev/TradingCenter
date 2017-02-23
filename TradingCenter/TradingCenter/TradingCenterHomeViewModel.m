//
//  TradingCenterHomeViewModel.m
//  TradingCenter
//
//  Created by N年後 on 2017/2/23.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "TradingCenterHomeViewModel.h"
#import "TradingCenterActivityTrailer.h"
#import "MJExtension.h"

@implementation TradingCenterHomeViewModel


+(NSDictionary *)objectClassInArray{
    return @{@"data":[TradingCenterActivityTrailer class]};
}



- (instancetype)init
{
    self = [super init];
    if (self) {
        _canLoadMore = NO;
        _isLoading = _willLoadMore = NO;
        _pageNo = [NSNumber numberWithInteger:1];
        _pageSize = [NSNumber numberWithInteger:15];

        self.webURL = @"";

    }
    return self;
}





-(NSDictionary *)toTipsParams{

    NSDictionary *params = @{@"requestType" :@"Excange_Api_Vo",
                             @"apiType" :@"info",
                             @"exchangeId":self.exchangeId};
    return params;
}

// 采用懒加载的方式来配置网络请求
- (RACSignal *)requestSignal_top {

    if (!_requestSignal_top) {

        _requestSignal_top = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {


            [TRZXNetwork requestWithUrl:nil params:self.toTipsParams method:GET cachePolicy:NetworkingReloadIgnoringLocalCacheData callbackBlock:^(id response, NSError *error) {

                if (response) {
                    NSMutableArray *images = [[NSMutableArray alloc]init];
                    for (NSDictionary *dic in response[@"top"]) {
                        [images addObject:dic[@"picUrl"]];
                    }
                    self.webURL = response[@"introduceUrl"];
                    self.topImagesArray = [NSArray arrayWithArray:images];
                    self.topDicArray = response[@"top"];
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
    return _requestSignal_top;
}



-(NSDictionary *)toActivityTrailerParams{ // 活动公告

    NSDictionary *params = @{@"requestType" :@"Temple_Exchange_Api",
                             @"apiType" :@"noticeOrActivity",
                             @"exchangeId" :self.exchangeId,
                             @"pageNo" : _willLoadMore? [NSNumber numberWithInteger:_pageNo.integerValue +1]: [NSNumber numberWithInteger:1],
                             @"pageSize" : _pageSize};
    return params;


}

// 采用懒加载的方式来配置网络请求
- (RACSignal *)requestSignal_activityTrailer {

    if (!_requestSignal_activityTrailer) {

        _requestSignal_activityTrailer = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {


            [TRZXNetwork requestWithUrl:nil params:self.toActivityTrailerParams method:GET cachePolicy:NetworkingReloadIgnoringLocalCacheData callbackBlock:^(id response, NSError *error) {

                if (response) {

                    TradingCenterHomeViewModel *model = [TradingCenterHomeViewModel mj_objectWithKeyValues:response];
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
    return _requestSignal_activityTrailer;
}

- (void)configWithObj:(TradingCenterHomeViewModel *)model{

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
