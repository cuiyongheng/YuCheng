//
//  LimitRushCell.h
//  YuCheng
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LimitModel.h"
#import "JustStartTimeView.h"

@interface LimitRushCell : UITableViewCell

@property (nonatomic, strong) UIImageView *picImageView;

@property (nonatomic, strong) UIView *blackBackView;

@property (nonatomic, strong) UIView *whiteBackView;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UILabel *priceLabel;// 原价

//@property (nonatomic, strong) UILabel *discountLabel;// 打折

//@property (nonatomic, strong) UILabel *timeLabel;// 倒计时

@property (nonatomic, strong) JustStartTimeView *justStartView;// 倒计时

@property (nonatomic, strong) JustStartTimeView *otherJustStartView;

@property (nonatomic, strong) UILabel *statsLabel;// 剩余天数

@property (nonatomic, strong) LimitModel *model;

@end
