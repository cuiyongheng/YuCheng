//
//  TicketCell.h
//  YuCheng
//
//  Created by apple on 16/6/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketModel.h"

@interface TicketCell : UITableViewCell

@property (nonatomic, strong) UIImageView *backImageView;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UILabel *explainLabel;// 优惠卷名称

@property (nonatomic, strong) UIImageView *startImageView;

@property (nonatomic, strong) UILabel *titleLabel;// 说明

@property (nonatomic, strong) TicketModel *model;

@end
