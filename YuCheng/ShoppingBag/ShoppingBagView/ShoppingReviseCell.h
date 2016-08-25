//
//  ShoppingReviseCell.h
//  YuCheng
//
//  Created by apple on 16/6/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"

@interface ShoppingReviseCell : UITableViewCell

@property (nonatomic, strong) UIImageView *picImageView;

//@property (nonatomic, strong) UIImageView *brandImageView;

//@property (nonatomic, strong) UILabel *nameLabel;// 店名

@property (nonatomic, strong) UILabel *titleLabel;// 品种

@property (nonatomic, strong) UILabel *moneyLabel;

//@property (nonatomic, strong) UIView *nameBackView;

@property (nonatomic, strong) UIView *moneyView;

@property (nonatomic, strong) UIView *delegateView;// 删除View

@property (nonatomic, strong) UIButton *delegateButton;// 删除Button

@property (nonatomic, strong) UIButton *chooseButton;// 选择

@property (nonatomic, strong) UIView *backView;

//@property (nonatomic, strong) UILabel *dingjinLabel;// 定金

@property (nonatomic, strong) ProductModel *model;

@end
