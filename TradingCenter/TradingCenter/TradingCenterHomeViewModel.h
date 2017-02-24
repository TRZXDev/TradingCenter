//
//  TradingCenterHomeViewModel.h
//  TradingCenter
//
//  Created by N年後 on 2017/2/23.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
#import "TRZXNetwork.h"
@interface TradingCenterHomeViewModel : NSObject

@property (readwrite, nonatomic, strong) NSNumber *pageNo, *pageSize, *totalPage;
@property (assign, nonatomic) BOOL canLoadMore, willLoadMore, isLoading;



@property (nonatomic, copy) NSString *exchangeId;// 交易中心id
@property (strong, nonatomic) RACSignal *requestSignal_top; ///< 网络请求信号量
@property (readwrite, nonatomic, strong) NSArray *topImagesArray;// 交易中心轮播图片数组
@property (readwrite, nonatomic, strong) NSArray *topDicArray;// 交易中心轮播图片数组Dic
@property (nonatomic, copy) NSString *webURL;


@property (strong, nonatomic) RACSignal *requestSignal_activityTrailer; ///< 活动公告
@property (readwrite, nonatomic, strong) NSMutableArray *data;// 活动公告数组






-(NSDictionary *)toTipsParams;
-(NSDictionary *)toActivityTrailerParams; // 活动公告
- (void)configWithObj:(TradingCenterHomeViewModel *)model;

@end
