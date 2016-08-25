//
//  MyEvaluateModel.h
//  YuCheng
//
//  Created by apple on 16/7/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface MyEvaluateModel : BaseModel

@property (nonatomic, copy) NSString *order_id;

@property (nonatomic, copy) NSString *rec_id;

@property (nonatomic, copy) NSString *goods_id;

@property (nonatomic, copy) NSString *goods_name;// 商品名

@property (nonatomic, copy) NSString *goods_sn;// 订单号

@property (nonatomic, copy) NSString *shop_price;

@property (nonatomic, copy) NSString *goods_thumb;

@property (nonatomic, copy) NSString *shopname;

@property (nonatomic, copy) NSString *comment_state;// 是否评价

@property (nonatomic, copy) NSString *add_time_str;// 成交时间

@property (nonatomic, copy) NSString *shipping_time_end;// 完成时间

@end
