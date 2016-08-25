//
//  WaitPayModel.h
//  YuCheng
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface WaitPayModel : BaseModel

@property (nonatomic, copy) NSString *order_id;

@property (nonatomic, copy) NSString *order_sn;// 订单

@property (nonatomic, copy) NSString *shopname;// 店名

@property (nonatomic, copy) NSString *order_time;// 完成时间

@property (nonatomic, copy) NSString *total_fee;// 总金额

@property (nonatomic, strong) NSMutableArray *goods_list;// 商品列表

@property (nonatomic, copy) NSString *use_order_status;

// 退款
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *back_id;
@property (nonatomic, copy) NSString *goods_thumb;
@property (nonatomic, copy) NSString *back_goods_price;
@property (nonatomic, copy) NSString *supplier_name;
@property (nonatomic, copy) NSString *status_back;

@end
