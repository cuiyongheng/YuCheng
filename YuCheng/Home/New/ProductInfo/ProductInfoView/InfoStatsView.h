//
//  InfoStatsView.h
//  YuCheng
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoStatsView : UIView

@property (nonatomic, strong) UIView *blackBackView;

@property (nonatomic, strong) UIView *whiteBackView;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UILabel *priceLabel;// 原价

@property (nonatomic, strong) UILabel *discountLabel;// 打折

@property (nonatomic, strong) UILabel *timeLabel;// 倒计时

@property (nonatomic, strong) UILabel *statsLabel;// 剩余天数

@end
