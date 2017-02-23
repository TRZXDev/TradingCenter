//
//  TradingCenter.h
//  TradingCenter
//
//  Created by N年後 on 2017/2/23.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TradingCenter : NSObject
@property (nonatomic, copy) NSString *mid;// 交易中心id
@property (nonatomic, copy) NSString *image;// 交易中心封面
@property (nonatomic, copy) NSString *name;// 交易中心名称
@property (nonatomic, copy) NSString *logo; // 交易中心logo
@end
