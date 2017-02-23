//
//  CenterAnnouncementTableViewCell.h
//  TRZX
//
//  Created by 张江威 on 2016/12/28.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TradingCenterActivityTrailer.h"
static NSString *kCellIdentifier_TradingCenterTrailerCell = @"TradingCenterTrailerCell";

@interface TradingCenterTrailerCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *neirongLab;
@property (weak, nonatomic) IBOutlet UILabel *dataLab;


@property(nonatomic,weak)TradingCenterActivityTrailer *model;



@end
