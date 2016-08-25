//
//  OrderlogisticsHeadView.h
//  YuCheng
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoOrderGoodsModel.h"

@interface OrderlogisticsHeadView : UIView

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *picImageView;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *startLabel;

@property (nonatomic, strong) InfoOrderGoodsModel *model;

@end
