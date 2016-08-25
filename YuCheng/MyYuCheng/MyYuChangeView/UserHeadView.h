//
//  UserHeadView.h
//  YuCheng
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserHeadViewDelegate <NSObject>

// 我的订单
- (void)MyOrderViewController;

// 待付款
- (void)payViewController;

// 待收货
- (void)receivingViewController;

// 退款
- (void)refundViewController;

// 设置
- (void)mySetting;

// 上传头像
- (void)updateImageViewForService;

// 修改名字
- (void)changeName;

@end

@interface UserHeadView : UIView

@property (nonatomic, strong) UIButton *nameChangeButton;

@property (nonatomic, strong) UIView *blackView;

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UIButton *settingButton;

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIButton *oneButton;

@property (nonatomic, strong) UIButton *twoButton;

@property (nonatomic, strong) UIButton *threeButton;

@property (nonatomic, strong) UIButton *fourButton;

@property (nonatomic, strong) UILabel *oneLabel;

@property (nonatomic, strong) UILabel *twoLabel;

@property (nonatomic, strong) UILabel *threeLabel;

@property (nonatomic, strong) UILabel *fourLabel;

@property (nonatomic, assign) id<UserHeadViewDelegate>delegate;

@end
