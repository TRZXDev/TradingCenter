//
//  CollctionCell.h
//  CustomWaterFlow
//
//  Created by DYS on 15/12/12.
//  Copyright © 2015年 DYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TradingCenterRoadshowLive.h"
static NSString *kCellIdentifier_TradingCenterRoadshowLiveCell = @"TradingCenterRoadshowLiveCell";

@interface TradingCenterRoadshowLiveCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *liveIconImageView;

@property(nonatomic,weak)TradingCenterRoadshowLive *model;

@end
