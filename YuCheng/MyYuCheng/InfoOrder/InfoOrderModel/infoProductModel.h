//
//  infoProductModel.h
//  YuCheng
//
//  Created by apple on 16/7/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface infoProductModel : BaseModel

@property (nonatomic, copy) NSString *goods_name;

@property (nonatomic, copy) NSString *goods_thumb;

@property (nonatomic, copy) NSString *goods_price;

@property (nonatomic, copy) NSString *goods_id;

@property (nonatomic, copy) NSString *order_id;

@property (nonatomic, copy) NSString *product_id;

@property (nonatomic, copy) NSString *supplier_name;

@property (nonatomic, copy) NSString *is_back;

@end
