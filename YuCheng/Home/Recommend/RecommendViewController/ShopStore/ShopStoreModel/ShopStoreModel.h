//
//  ShopStoreModel.h
//  YuCheng
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface ShopStoreModel : BaseModel

@property (nonatomic, copy) NSString *goods_number;// 商品数量

@property (nonatomic, copy) NSString *sellgoods_number;// 已卖商品

@property (nonatomic, copy) NSString *shop_address;// 地址

@property (nonatomic, copy) NSString *shop_logo;

@property (nonatomic, copy) NSString *shop_desc;// 描述

@property (nonatomic, copy) NSString *shop_name;// 商铺名

@property (nonatomic, copy) NSString *supplier_id;// 商铺ID

@property (nonatomic, copy) NSString *best_original_img;// banner

@property (nonatomic, strong) NSMutableArray *shop_credit;// 证书

@property (nonatomic, copy) NSString *shop_index_img;// 商铺大图

@property (nonatomic, copy) NSString *evaluation;

@end
