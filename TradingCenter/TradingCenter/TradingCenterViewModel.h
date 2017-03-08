//
//  TradingCenterViewModel.h
//  TradingCenter
//
//  Created by N年後 on 2017/2/23.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TradingCenter.h"
#import "ReactiveCocoa.h"
#import "TRZXNetwork.h"
@interface TradingCenterViewModel : NSObject
@property (readwrite, nonatomic, strong) NSNumber *pageNo, *pageSize, *totalPage;
@property (assign, nonatomic) BOOL canLoadMore, willLoadMore, isLoading;
@property (strong, nonatomic) RACSignal *requestSignal_list; ///< 网络请求信号量
@property (readwrite, nonatomic, strong) NSMutableArray *data; // 交易中心列表


-(NSDictionary *)toTipsParams;

@end
