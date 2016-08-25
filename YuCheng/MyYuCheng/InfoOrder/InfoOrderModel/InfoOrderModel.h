//
//  InfoOrderModel.h
//  YuCheng
//
//  Created by apple on 16/7/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface InfoOrderModel : BaseModel

@property (nonatomic, copy) NSString *order_id;

@property (nonatomic, copy) NSString *consignee;// 人名

@property (nonatomic, copy) NSString *mobile;// 手机

@property (nonatomic, copy) NSString *order_sn;// 订单编号

@property (nonatomic, copy) NSString *use_order_status;// 状态

@property (nonatomic, copy) NSString *country_name;//

@property (nonatomic, copy) NSString *province_name;// 省

@property (nonatomic, copy) NSString *city_name;// 市

@property (nonatomic, copy) NSString *district_name;// 区

@property (nonatomic, copy) NSString *add_time;// 创建时间

@property (nonatomic, copy) NSString *pay_time;// 付款时间

@property (nonatomic, copy) NSString *shipping_time;// 发货时间

@property (nonatomic, copy) NSString *shipping_time_end;// 收货时间

@property (nonatomic, copy) NSString *shop_name;

@property (nonatomic, copy) NSString *shipping_end_remain_time;

@property (nonatomic, copy) NSString *pay_id;

@property (nonatomic, copy) NSString *parent_order_id;

@property (nonatomic, copy) NSString *invoice_no;

@property (nonatomic, copy) NSString *pay_status;

@end
