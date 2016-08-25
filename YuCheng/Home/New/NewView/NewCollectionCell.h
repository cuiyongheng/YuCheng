//
//  NewCollectionCell.h
//  YuCheng
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"

@protocol NewCollectionCellDelegate <NSObject>

- (void)pushShopping:(UIButton *)button;

@end

@interface NewCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *picImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIButton *shopButton;

@property (nonatomic, strong) UILabel *selloutLabel;// 已售

@property (nonatomic, assign) id<NewCollectionCellDelegate>delegate;

@property (nonatomic, strong) ProductModel *model;

@property (nonatomic, strong) UILabel *addLabel;

@end
