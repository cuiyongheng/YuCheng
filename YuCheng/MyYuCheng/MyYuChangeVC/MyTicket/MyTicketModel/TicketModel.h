//
//  TicketModel.h
//  YuCheng
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface TicketModel : BaseModel

@property (nonatomic, copy) NSString *type_name;// 优惠券名字

@property (nonatomic, copy) NSString *use_startdate;// 开始时间

@property (nonatomic, copy) NSString *use_enddate;// 结束时间

@property (nonatomic, copy) NSString *min_goods_amount;// 使用条件

@property (nonatomic, copy) NSString *type_money;// 优惠价格

@property (nonatomic, copy) NSString *type_id;

@property (nonatomic, copy) NSString *bonus_id;

@end
