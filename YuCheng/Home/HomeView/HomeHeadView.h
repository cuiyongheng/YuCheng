//
//  HomeHeadView.h
//  YuCheng
//
//  Created by apple on 16/5/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYHRollView.h"

@protocol HomeHeadViewDelegate <NSObject>

// 新品
- (void)tapNewViewController;

// 商家推荐
- (void)tapRecommendViewController;

// 限时抢购
- (void)tapLimitRushViewController;

// 已卖鉴赏
- (void)tapSellOutViewController;

// 新品推荐
- (void)tapImageView:(NSInteger)tapIndex;

@end

@interface HomeHeadView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *headScroll;// 轮播

@property (nonatomic, strong) UIPageControl *page;// 点

@property (nonatomic, strong) UIButton *NewButton;// 新品

@property (nonatomic, strong) UIButton *recommendButton;// 推荐

@property (nonatomic, strong) UIButton *limitButton;// 限时抢购

@property (nonatomic, strong) UIButton *sellOutButton;// 已卖

@property (nonatomic, strong) UILabel *NewLabel;

@property (nonatomic, strong) UILabel *recommendLabel;

@property (nonatomic, strong) UILabel *limitLabel;

@property (nonatomic, strong) UILabel *sellOutLabel;

@property (nonatomic, strong) UILabel *titleLabel;// 推荐

@property (nonatomic, strong) UIScrollView *scrollView;// 图片滚动

@property (nonatomic, strong) UIView *backView;// 背景

@property (nonatomic, assign) id<HomeHeadViewDelegate>delegate;

@property (nonatomic, strong) NSMutableArray *adsArr;

@property (nonatomic, strong) NSMutableArray *bestArr;

@end
