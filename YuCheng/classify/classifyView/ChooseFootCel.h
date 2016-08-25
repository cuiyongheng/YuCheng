//
//  ChooseFootCel.h
//  YuCheng
//
//  Created by apple on 16/6/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseFootCelDelegate <NSObject>

// 确认筛选
- (void)chooseTureButton;

@end

@interface ChooseFootCel : UICollectionReusableView

@property (nonatomic, strong) UIButton *tureButton;

@property (nonatomic, assign) id<ChooseFootCelDelegate>delegate;

@end
