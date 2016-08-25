//
//  refundCell.h
//  YuCheng
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol refundCellDelegate <NSObject>

// 上传凭证
- (void)updateImageView:(UIButton *)button;

@end

@interface refundCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *updateImageView;

@property (nonatomic, assign) id<refundCellDelegate>delegate;

@end
