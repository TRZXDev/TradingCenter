//
//  Target_TRZXConfirmFinancing.m
//  TRZXConfirmFinancing
//
//  Created by N年後 on 2017/1/21.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "Target_TradingCenter.h"
#import "TRZXTradingCenterViewController.h"

@implementation Target_TradingCenter

- (UIViewController *)Action_TradingCenterViewController:(NSDictionary *)params;
{
    TRZXTradingCenterViewController *vc = [[TRZXTradingCenterViewController alloc] init];
    vc.vcTitle = params[@"vcTitle"];
    return vc;
}

@end
