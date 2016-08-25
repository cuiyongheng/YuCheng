//
//  ProductThirdCell.h
//  YuCheng
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProductThirdCellDelegate <NSObject>

- (void)multiplieurPic:(NSInteger)imageViewTag total:(NSInteger)total;

@end

@interface ProductThirdCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *picView;

@property (nonatomic, strong) NSMutableArray *picArr;

@property (nonatomic, strong) NSMutableArray *porductArr;

@property (nonatomic, assign) id<ProductThirdCellDelegate>delegate;

@end
