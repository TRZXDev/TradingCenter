//
//  TradingCenterRoadshowLiveModel.h
//  TradingCenter
//
//  Created by N年後 on 2017/2/24.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TradingCenterRoadshowLive : NSObject
@property (nonatomic, copy) NSString *liveImg;// 交易中心直播封面
@property (nonatomic, copy) NSString *liveOrVideo;// video 视频  live 直播
@property (nonatomic, copy) NSString *title;// 标题
@property (nonatomic, copy) NSString *updateDate; // 更新时间
@property (nonatomic, copy) NSString *rate; // 观看人数

@end
