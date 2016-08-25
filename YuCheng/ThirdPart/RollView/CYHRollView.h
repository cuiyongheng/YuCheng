//
//  CYHRollView.h
//  Watch
//
//  Created by dllo on 15/10/23.
//
//

#import <UIKit/UIKit.h>

@interface CYHRollView : UIView<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, retain) UICollectionView *collectionView;
@property(nonatomic, retain) NSTimer *timer;

- (instancetype)initWithFrame:(CGRect)frame image:(NSMutableArray *)imageArr title:(NSMutableArray *)titleArr;

@end
