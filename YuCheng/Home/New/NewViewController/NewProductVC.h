//
//  NewProductVC.h
//  YuCheng
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface NewProductVC : BaseViewController

@property (nonatomic, assign) BOOL isNewProduct;

@property (nonatomic, copy) NSString *cat_id;// 品类ID

@property (nonatomic, copy) NSString *attr_key;// 属性字符串

@end
