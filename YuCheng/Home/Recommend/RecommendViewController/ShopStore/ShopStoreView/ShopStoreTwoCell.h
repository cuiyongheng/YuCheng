//
//  ShopStoreTwoCell.h
//  YuCheng
//
//  Created by apple on 16/6/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShopStoreTwoCellDelegate <NSObject>

// 展开
- (void)arrowButtonOpenInfo;

@end

@interface ShopStoreTwoCell : UITableViewCell

@property (nonatomic, strong) UILabel *infoLabel;

//@property (nonatomic, strong) UIButton *arrowButton;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) id<ShopStoreTwoCellDelegate>delegate;

@property (nonatomic, strong) UIView *lineView;

@end
