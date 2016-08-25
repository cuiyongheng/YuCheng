//
//  RIghtNavigationView.h
//  YuCheng
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RIghtNavigationViewDelegate <NSObject>

// 进入购物车
- (void)pushShopping;

// 联系客服
- (void)relationService;

// 分享
- (void)shareImage;

// 收藏
- (void)saveCollection:(UIButton *)button;

// 点赞
- (void)takeFavour:(UIButton *)button;

@end

@interface RIghtNavigationView : UIView

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UIButton *shareButton;// 分享

@property (nonatomic, strong) UIButton *favourButton;// 点赞

@property (nonatomic, strong) UIButton *saveButton;// 收藏

@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, assign) id<RIghtNavigationViewDelegate>delegate;

@end
