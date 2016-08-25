//
//  ProductIntroduceCell.h
//  YuCheng
//
//  Created by apple on 16/6/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroduceCollectionCell.h"

@interface ProductIntroduceCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;

//@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, assign) BOOL isTransparent;

@end
