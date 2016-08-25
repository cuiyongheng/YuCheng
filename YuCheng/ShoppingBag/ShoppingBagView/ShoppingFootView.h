//
//  ShoppingFootView.h
//  YuCheng
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShoppingFootViewDelegate <NSObject>

// 结算
- (void)clearingShopping;

// 全选
- (void)allChoose:(BOOL)isAllChoose;

// 支付方式
- (void)payMethod;

@end

@interface ShoppingFootView : UIView

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *allLabel;// 合计

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UILabel *mothodLabel;// 支付方式

@property (nonatomic, strong) UILabel *payLabel;// 支付

@property (nonatomic, strong) UIButton *payButton;// 选择支付方式按钮

@property (nonatomic, strong) UIImageView *oneImageView;

@property (nonatomic, strong) UIImageView *twoImageView;

@property (nonatomic, strong) UIButton *settleButton;// 结算

@property (nonatomic, strong) UIImageView *arrowImageView;// 箭头

@property (nonatomic, assign) id<ShoppingFootViewDelegate>delegate;

@property (nonatomic, strong) UIImageView *roundImageView;// 圆

@property (nonatomic, strong) UILabel *allMoneyLabel;

//@property (nonatomic, strong) UILabel *dingjinMoneyLabel;

@end
