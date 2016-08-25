//
//  ClearCell.h
//  YuCheng
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClearCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UIImageView *picImageView;

@property (nonatomic, strong) UILabel *orderLabel;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *beforeLabel;

@property (nonatomic, strong) UILabel *beforeMoneyLabel;

@property (nonatomic, strong) UIView *delegateView;// 删除View

@property (nonatomic, strong) UIButton *delegateButton;// 删除Button

@end
