//
//  TradingCenterViewModel.m
//  TradingCenter
//
//  Created by N年後 on 2017/2/23.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "TradingCenterViewModel.h"
#import "MJExtension.h"

@implementation TradingCenterViewModel

+(NSDictionary *)objectClassInArray{
    return @{@"data":[TradingCenter class]};
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

    NSDictionary *params = @{@"requestType" :@"Excange_Api_Vo",
                             @"apiType" :@"all",
                             @"pageNo" : _willLoadMore? [NSNumber numberWithInteger:_pageNo.integerValue +1]: [NSNumber numberWithInteger:1],
                             @"pageSize" : _pageSize};
    return params;
}

// 采用懒加载的方式来配置网络请求
- (RACSignal *)requestSignal_list {

    if (!_requestSignal_list) {

        _requestSignal_list = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {


            [TRZXNetwork requestWithUrl:nil params:self.toTipsParams method:GET cachePolicy:NetworkingReloadIgnoringLocalCacheData callbackBlock:^(id response, NSError *error) {

                if (response) {
                    self.data = [TradingCenter mj_objectArrayWithKeyValuesArray:response[@"data"]];
                    [subscriber sendNext:self.data];
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
    return _requestSignal_list;
}





@end
