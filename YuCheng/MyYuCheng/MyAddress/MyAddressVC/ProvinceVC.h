//
//  ProvinceVC.h
//  YuCheng
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^provinceBlock)(NSMutableDictionary *provinceDic);

@interface ProvinceVC : BaseViewController

@property (nonatomic, copy) provinceBlock block;

@end
