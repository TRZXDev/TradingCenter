//
//  CenterNoticeTableViewCell.m
//  TRZX
//
//  Created by 张江威 on 2016/12/28.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import "TradingCenterActivityCell.h"
#import "UIImageView+AFNetworking.h"

@implementation TradingCenterActivityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.cornerRadius = 6;
    self.bgView.layer.masksToBounds = YES;
    
}
- (void)setModel:(TradingCenterActivityTrailer *)model{
    if (_model!= model) {
        _model = model;
        [self.bgImage setImageWithURL:[NSURL URLWithString:model.msgzPic]];
        self.dataLab.text = model.date;
        self.dataLab.hidden = YES;

        self.titleLab.text = [NSString stringWithFormat:@"【活动】%@",model.msgTitle];
        self.neirongLab.text = model.msgDigest;
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
