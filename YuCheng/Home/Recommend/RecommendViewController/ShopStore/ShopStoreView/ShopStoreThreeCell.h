//
//  ShopStoreThreeCell.h
//  YuCheng
//
//  Created by apple on 16/6/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShopStoreThreeCellDelegate <NSObject>

- (void)multiplyingImageView:(NSInteger)imageViewTag;

@end

@interface ShopStoreThreeCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *oneImageView;

@property (nonatomic, strong) UIImageView *twoImageView;

@property (nonatomic, strong) UIImageView *threeImageView;

@property (nonatomic, strong) UIImageView *fourImageView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) NSMutableArray *creditArr;

@property (nonatomic, assign) id<ShopStoreThreeCellDelegate>delegate;

@end
