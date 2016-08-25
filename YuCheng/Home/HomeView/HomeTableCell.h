//
//  HomeTableCell.h
//  YuCheng
//
//  Created by apple on 16/5/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@protocol HomeTableCellDelegate <NSObject>

//- (void)leftGoods:(NSInteger)tapTag;
//
//- (void)rightGoods:(NSInteger)tapTag;
//
//- (void)middleGoods:(NSInteger)tapTag;

- (void)tapClassifyImageView:(NSInteger)imageNum scrollTag:(NSInteger)scrollTag;

@end

@interface HomeTableCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;// 标题

@property (nonatomic, strong) UIImageView *bigImageView;// 大图

//@property (nonatomic, strong) UIImageView *leftImageView;
//
//@property (nonatomic, strong) UIImageView *middleImageView;
//
//@property (nonatomic, strong) UIImageView *rightImageView;
//
//@property (nonatomic, strong) UILabel *leftLabel;
//
//@property (nonatomic, strong) UILabel *leftMoneyLabel;
//
//@property (nonatomic, strong) UILabel *middleLabel;
//
//@property (nonatomic, strong) UILabel *middleMoneyLabel;
//
//@property (nonatomic, strong) UILabel *rightLabel;
//
//@property (nonatomic, strong) UILabel *rightMoneyLabel;
//
//@property (nonatomic, strong) UIView *backView;

//@property (nonatomic, strong) UIButton *comeButton;// 进入店铺

//@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *classifyLabel;

@property (nonatomic, strong) UIView *hiddenView;

@property (nonatomic, strong) UIScrollView *scroll;

@property (nonatomic, assign) id<HomeTableCellDelegate>delegate;

@property (nonatomic, strong) HomeModel *model;

@end
