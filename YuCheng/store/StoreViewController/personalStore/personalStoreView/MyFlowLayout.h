//
//  MyFlowLayout.h
//  collectionView
//
//  Created by dllo on 15/11/13.
//  Copyright (c) 2015年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyFlowLayoutDelegate <NSObject>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MyFlowLayout : UICollectionViewFlowLayout

@property(nonatomic, assign) id<MyFlowLayoutDelegate>MyDelegate;
@property(nonatomic, retain) NSMutableArray *arr;
@property(nonatomic, assign) CGFloat MaxHeight;

@end
