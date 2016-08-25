//
//  LimitModel.h
//  YuCheng
//
//  Created by apple on 16/6/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface LimitModel : BaseModel

@property (nonatomic, copy) NSString *goods_id;// ID

@property (nonatomic, copy) NSString *goods_name;// 名字

@property (nonatomic, copy) NSString *original_img;// 图片

@property (nonatomic, copy) NSString *shop_price;// 市价原价

@property (nonatomic, copy) NSString *on_sale_time;// 上架时间

@property (nonatomic, copy) NSString *promote_price;// 促销价

@property (nonatomic, copy) NSString *discount;// 折扣

@property (nonatomic, assign) NSInteger remain_second;// 时间

@property (nonatomic, copy) NSString *goods_thumb;

@end
