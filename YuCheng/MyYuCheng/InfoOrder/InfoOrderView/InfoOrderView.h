//
//  InfoOrderView.h
//  YuCheng
//
//  Created by apple on 16/6/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoOrderModel.h"
#import "infoProductModel.h"

@protocol InfoOrderViewDelegate <NSObject>

// 退款
- (void)refundButton:(UIButton *)button;

@end

@interface InfoOrderView : UIView

@property (nonatomic, strong) UIImageView *picImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *startLabel;

@property (nonatomic, strong) UIButton *refundButton;// 退款

@property (nonatomic, strong) UILabel *peopleLabel;

@property (nonatomic, strong) UILabel *addLabel;

@property (nonatomic, strong) UILabel *phoneLabel;

@property (nonatomic, strong) UIImageView *addImageView;

@property (nonatomic, assign) id<InfoOrderViewDelegate>delegate;

@property (nonatomic, strong) InfoOrderModel *model;

@property (nonatomic, strong) infoProductModel *goodsModel;

@end
