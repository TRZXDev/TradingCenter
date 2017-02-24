//
//  CollctionCell.m
//  CustomWaterFlow
//
//  Created by DYS on 15/12/12.
//  Copyright © 2015年 DYS. All rights reserved.
//

#import "TradingCenterRoadshowLiveCell.h"
#import "UIImageView+AFNetworking.h"


@interface TradingCenterRoadshowLiveCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIImageView *playImageView;
@property (weak, nonatomic) IBOutlet UILabel *createDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *peopleImageView;
@property (weak, nonatomic) IBOutlet UILabel *onlinePeopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *watchPeopleLabel;

@end

@implementation TradingCenterRoadshowLiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 5;
    self.layer.borderWidth = 1;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor clearColor].CGColor;


    self.createDateLabel.shadowColor = [UIColor blackColor];
    self.createDateLabel.shadowOffset = CGSizeMake(0, 1.0);



}

- (void)setModel:(TradingCenterRoadshowLive *)model{


    self.contentLabel.text = @"";
    self.createDateLabel.text = model.updateDate.length>0?model.updateDate:@"";



    if([model.liveOrVideo isEqualToString:@"live"]){
        self.liveIconImageView.image = [UIImage imageNamed:@"直播"];
        self.playImageView.image = [UIImage imageNamed:@"C直播"];
        self.onlinePeopleLabel.hidden = NO;
        self.peopleImageView.hidden = YES;
        self.onlinePeopleLabel.text = [NSString stringWithFormat:@"在线人数：%@人",model.rate];
        self.watchPeopleLabel.hidden = YES;

    }else{

        self.liveIconImageView.image = [UIImage imageNamed:@"回看"];
        self.playImageView.image = [UIImage imageNamed:@"C直播"];
        self.watchPeopleLabel.hidden = NO;
        self.onlinePeopleLabel.hidden = YES;
        self.peopleImageView.hidden = NO;
        self.watchPeopleLabel.text = [NSString stringWithFormat:@"%@",model.rate];


    }

    [self.iconImage setImageWithURL:[NSURL URLWithString:model.liveImg]];




}
@end
