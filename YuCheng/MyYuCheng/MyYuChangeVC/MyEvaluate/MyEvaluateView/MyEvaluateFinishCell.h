//
//  MyEvaluateFinishCell.h
//  YuCheng
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
#import "MyEvaluateModel.h"

@protocol MyEvaluateFinishCellDelegate <NSObject>

// 商品详情
- (void)pushInfoOrede:(NSInteger)buttonTag;

@end

@interface MyEvaluateFinishCell : UITableViewCell

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

//@property (nonatomic, strong) UIButton *pingjiaButton;// 评价

@property (nonatomic, strong) UIButton *infoButton;// 详情

@property (nonatomic, strong) UILabel *finishTimeLabel;

@property (nonatomic, strong) UILabel *pingjiaLabel;

@property (nonatomic, strong) StarView *starView;

@property (nonatomic, strong) MyEvaluateModel *model;

@property (nonatomic, assign) id<MyEvaluateFinishCellDelegate>delegate;

@end
