//
//  ClassifyCell.h
//  YuCheng
//
//  Created by apple on 16/5/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassifyModel.h"

@protocol ClassifyCellDelegate <NSObject>

//- (void)foldToView:(UIView *)foldview;

- (void)pushNextVC:(NSString *)seleteString;

@end

@interface ClassifyCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *backImageView;

- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view;

@property (nonatomic, assign) id<ClassifyCellDelegate>delegate;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *foldView;// 折叠View

@property (nonatomic, strong) UILabel *nameLabel;// 品牌名

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) ClassifyModel *model;

@property (nonatomic, strong) NSMutableArray *breedArr;

@end
