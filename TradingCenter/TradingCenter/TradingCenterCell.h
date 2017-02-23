//
//  CenterListNewCollectionViewCell.h
//  TRZX
//
//  Created by 张江威 on 2016/12/20.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TradingCenter.h"
static NSString *kCellIdentifier_TradingCenterCell = @"TradingCenterCell";

@interface TradingCenterCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLab;


@property(nonatomic,weak)TradingCenter *model;


@end
