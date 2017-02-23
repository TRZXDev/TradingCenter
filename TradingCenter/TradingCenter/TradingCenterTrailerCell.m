//
//  CenterAnnouncementTableViewCell.m
//  TRZX
//
//  Created by 张江威 on 2016/12/28.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import "TradingCenterTrailerCell.h"

@implementation TradingCenterTrailerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.cornerRadius = 6;
    self.bgView.layer.masksToBounds = YES;
    
}
- (void)setModel:(TradingCenterActivityTrailer *)model{
    if (_model!= model) {
        _model = model;
        self.dataLab.text = model.date;
        self.dataLab.hidden = YES;

        self.titleLab.text = [NSString stringWithFormat:@"【公告】%@",model.msgTitle];
        self.neirongLab.text = model.msgDigest;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
