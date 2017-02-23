//
//  CenterListNewCollectionViewCell.m
//  TRZX
//
//  Created by 张江威 on 2016/12/20.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import "TradingCenterCell.h"
#import "UIImageView+AFNetworking.h"


@implementation TradingCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;

    self.logoImage.layer.cornerRadius = 5;
    self.logoImage.layer.masksToBounds = YES;
    
}

- (void)setModel:(TradingCenter *)model{
    if (_model!= model) {
        _model = model;
        [self.bgImage setImageWithURL:[NSURL URLWithString:model.image]];
        [self.logoImage setImageWithURL:[NSURL URLWithString:model.logo]];
        self.centerLabel.text = model.name;
        self.numberLab.text = @"";
    }
    
}

@end
