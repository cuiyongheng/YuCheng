//
//  ShopStoreBannerCell.h
//  YuCheng
//
//  Created by apple on 16/6/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopStoreBannerCell : UITableViewCell

@property (nonatomic, strong) UIImageView *bannerImageView;

@property (nonatomic, strong) UILabel *numberLabel;// 商品数量

@property (nonatomic, strong) UILabel *sellOutLabel;// 已卖

@property (nonatomic, strong) UILabel *goodLabel;// 好评

@property (nonatomic, strong) UILabel *numberValueLabel;// 商品数量值

@property (nonatomic, strong) UILabel *sellOutValueLabel;// 已卖商品值

@property (nonatomic, strong) UILabel *goodValueLabel;// 好评值

//@property (nonatomic, strong) UIButton *serverButton;// 客服

@property (nonatomic, strong) UIView *lineView;

@end
