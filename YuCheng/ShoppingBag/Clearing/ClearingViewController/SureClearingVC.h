//
//  SureClearingVC.h
//  YuCheng
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^successBloack)(id responseObject);

@interface SureClearingVC : BaseViewController

@property (nonatomic, strong) NSMutableDictionary *modelDic;

@end
