//
//  RecommendNewCell.h
//  YuCheng
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"

@interface RecommendNewCell : UITableViewCell

//@property (nonatomic, strong) UILabel *titleLabel;// 标题

@property (nonatomic, strong) UIImageView *brandImageView;// 图标

@property (nonatomic, strong) UIImageView *bigImageView;// 大图

@property (nonatomic, strong) UIImageView *leftImageView;

@property (nonatomic, strong) UIImageView *middleImageView;

@property (nonatomic, strong) UIImageView *rightImageView;

@property (nonatomic, strong) UILabel *leftLabel;

@property (nonatomic, strong) UILabel *leftMoneyLabel;

@property (nonatomic, strong) UILabel *middleLabel;

@property (nonatomic, strong) UILabel *middleMoneyLabel;

@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) UILabel *rightMoneyLabel;

//@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIView *intervalView;

@property (nonatomic, strong) RecommendModel *model;
@end
