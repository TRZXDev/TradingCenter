//
//  TradingCenterActivityTrailerModel.h
//  TradingCenter
//
//  Created by N年後 on 2017/2/23.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TradingCenterActivityTrailer : NSObject
@property (nonatomic, copy) NSString *mid;// 交易中心id
@property (nonatomic, copy) NSString *msgzPic;// 活动图片
@property (nonatomic, copy) NSString *date;// 时间
@property (nonatomic, copy) NSString *msgTitle; // 公告活动标题
@property (nonatomic, copy) NSString *msgDigest; // 公告活动详情
@property (nonatomic, copy) NSString *msgType; // 0.活动  1.公告

@property (nonatomic, copy) NSString *msgView; // URL




@end
