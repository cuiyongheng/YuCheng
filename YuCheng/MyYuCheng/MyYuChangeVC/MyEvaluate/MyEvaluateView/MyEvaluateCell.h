//
//  MyEvaluateCell.h
//  YuCheng
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyEvaluateModel.h"

@protocol MyEvaluateCellDelegate <NSObject>

// 评价
- (void)takeEvaluate:(NSInteger)viewTag;

// 商品详情
- (void)pushInfoOrede:(NSInteger)buttonTag;

@end

@interface MyEvaluateCell : UITableViewCell

@property (nonatomic, strong) UIView *nameView;

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIImageView *picImageView;

@property (nonatomic, strong) UILabel *titleLabel;// 品种

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UIView *moneyView;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *dingdanLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIButton *pingjiaButton;// 评价

@property (nonatomic, strong) UIButton *infoButton;// 详情

@property (nonatomic, assign) id<MyEvaluateCellDelegate>delegate;

@property (nonatomic, strong) MyEvaluateModel *model;

@end
