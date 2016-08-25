//
//  ClearFootView.h
//  YuCheng
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClearFootViewDelegate <NSObject>

// 确认结算
- (void)tureClearing;

@end

@interface ClearFootView : UIView

@property (nonatomic, strong) UIImageView *frameImageView;

@property (nonatomic, strong) UILabel *allLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UIButton *tureButton;

@property (nonatomic, strong) UIView *lineView;

//@property (nonatomic, strong) UIView *squareView;// 方块
//
//@property (nonatomic, strong) UILabel *freeLabel;// 优惠券
//
//@property (nonatomic, strong) UILabel *freeMoneyLabel;// 优惠价钱
//
//@property (nonatomic, strong) UIImageView *arrowImageView;// 箭头
//
//@property (nonatomic, strong) UIButton *freeButton;// 优惠按钮

@property (nonatomic, assign) id<ClearFootViewDelegate>delegate;

@end
