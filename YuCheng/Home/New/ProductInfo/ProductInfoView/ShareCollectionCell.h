//
//  ShareCollectionCell.h
//  YuCheng
//
//  Created by apple on 16/7/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShareCollectionCellDelegate <NSObject>

- (void)shareImageToThirdPart:(NSInteger)buttonTag;

@end

@interface ShareCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *imageViewButton;

@property (nonatomic, strong) UIImageView *picImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) id<ShareCollectionCellDelegate>delegate;

@end
