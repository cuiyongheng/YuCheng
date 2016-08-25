//
//  StoreCell.h
//  YuCheng
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StoreCellDelegate <NSObject>

- (void)comeinStore:(NSInteger)buttonTag;

@end

@interface StoreCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *englishLabel;

@property (nonatomic, strong) UIImageView *picImageView;

@property (nonatomic, strong) UILabel *salesLabel;// 销量

@property (nonatomic, strong) UILabel *goodLabel;// 好评

@property (nonatomic, strong) UIImageView *oneImageView;

@property (nonatomic, strong) UIImageView *twoImageView;

@property (nonatomic, strong) UIImageView *threeImageView;

@property (nonatomic, strong) UILabel *oneTitleLabel;

@property (nonatomic, strong) UILabel *oneMoneyLabel;

@property (nonatomic, strong) UILabel *twoTitleLael;

@property (nonatomic, strong) UILabel *twoMoneyLabel;

@property (nonatomic, strong) UILabel *threeTitleLabel;

@property (nonatomic, strong) UILabel *threeMoneyLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIButton *comeStoreButton;// 进入店铺

@property (nonatomic, assign) id<StoreCellDelegate>delegate;

@end
