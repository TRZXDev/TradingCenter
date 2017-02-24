//
//  Target_TRZXConfirmFinancing.m
//  TRZXConfirmFinancing
//
//  Created by N年後 on 2017/1/21.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "Target_TRZXTradingCenter.h"
#import "TRZXTradingCenterViewController.h"

@implementation Target_TRZXTradingCenter

- (UIViewController *)Action_TradingCenterViewController:(NSDictionary *)params;
{
    TRZXTradingCenterViewController *vc = [[TRZXTradingCenterViewController alloc] init];
    vc.vcTitle = params[@"vcTitle"];
    return vc;
}

@end
