//
//  ProductOneCell.h
//  YuCheng
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RIghtNavigationView.h"
#import "ProductInfoModel.h"

@interface ProductOneCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;

//@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) RIghtNavigationView *navigationView;

//@property (nonatomic, strong) UIScrollView *scrollView;

//@property (nonatomic, strong) UILabel *marketLabel;// 市场价
//
//@property (nonatomic, strong) UILabel *marketMoneyLabel;// 市场价钱

@property (nonatomic, strong) UILabel *orderMoneyLabel;// 支付定金

@property (nonatomic, strong) ProductInfoModel *model;

@end
