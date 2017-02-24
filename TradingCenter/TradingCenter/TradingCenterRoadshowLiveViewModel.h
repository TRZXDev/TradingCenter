//
//  TradingCenterRoadshowLiveViewModel.h
//  TradingCenter
//
//  Created by N年後 on 2017/2/24.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
#import "TRZXNetwork.h"
#import "TradingCenterRoadshowLive.h"
@interface TradingCenterRoadshowLiveViewModel : NSObject
@property (readwrite, nonatomic, strong) NSNumber *pageNo, *pageSize, *totalPage;
@property (assign, nonatomic) BOOL canLoadMore, willLoadMore, isLoading;


@property (nonatomic, copy) NSString *exchangeId;// 交易中心id
@property (strong, nonatomic) RACSignal *requestSignal_templeExchangeList; //交易中心路演直播
@property (readwrite, nonatomic, strong) NSMutableArray *data;// 交易中心路演直播数组


-(NSDictionary *)toTipsParams;
- (void)configWithObj:(TradingCenterRoadshowLiveViewModel *)model;


@end
