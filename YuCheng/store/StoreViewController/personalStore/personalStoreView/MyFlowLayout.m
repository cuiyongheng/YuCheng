//
//  MyFlowLayout.m
//  collectionView
//
//  Created by dllo on 15/11/13.
//  Copyright (c) 2015年 dllo. All rights reserved.
//

#import "MyFlowLayout.h"

@implementation MyFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    CGFloat leftY = 193;
    CGFloat rightY = 193;
    self.MaxHeight = 0;
    
    self.arr = [NSMutableArray array];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        CGSize itemSize = [self.MyDelegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
		if (i == 0) {
			attributes.frame = CGRectMake(0, 0, itemSize.width, itemSize.height);
		} else if (i % 2 == 0) {
            attributes.frame = CGRectMake(5, leftY, itemSize.width, itemSize.height);
            leftY += itemSize.height + 10;
        } else {
            attributes.frame = CGRectMake(self.collectionView.frame.size.width / 2 + 5, rightY, itemSize.width, itemSize.height);
            rightY += itemSize.height + 10;
        }
        self.MaxHeight = MAX(self.MaxHeight, CGRectGetMaxY(attributes.frame));
        [self.arr addObject:attributes];
    }
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *array = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *att in self.arr) {
        if (CGRectIntersectsRect(rect, att.frame)) {
            [array addObject:att];
        }
    }
    return self.arr;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionView.frame.size.width, self.MaxHeight);
}

@end
