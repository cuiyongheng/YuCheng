//
//  ShopCountModel.h
//  YuCheng
//
//  Created by apple on 16/7/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface ShopCountModel : BaseModel

@property (nonatomic, strong) NSMutableArray *goods_list;

@property (nonatomic, copy) NSString *supplier_name;

@end
