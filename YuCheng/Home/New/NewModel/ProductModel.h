//
//  ProductModel.h
//  YuCheng
//
//  Created by apple on 16/6/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface ProductModel : BaseModel

@property (nonatomic, copy) NSString *goods_id;// ID

@property (nonatomic, copy) NSString *goods_name;// 名字

@property (nonatomic, copy) NSString *original_img;// 图片

@property (nonatomic, copy) NSString *shop_price;// 市价

@property (nonatomic, copy) NSString *on_sale_time;// 上架时间

@property (nonatomic, copy) NSString *add_time;// 上架时间

@property (nonatomic, copy) NSString *goods_thumb;

@property (nonatomic, copy) NSString *goods_price;

@property (nonatomic, copy) NSString *deposit;// 订金

@property (nonatomic, copy) NSString *shop_name;

@property (nonatomic, copy) NSString *shop_city;

@end
