//
//  BaseViewController.h
//  YuCheng
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIButton *leftItemButton;

@property (nonatomic, strong) UIButton *rightItemButton;

@end
