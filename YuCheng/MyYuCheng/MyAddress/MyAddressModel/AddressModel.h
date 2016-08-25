//
//  AddressModel.h
//  YuCheng
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface AddressModel : BaseModel

@property (nonatomic, copy) NSString *consignee;// 姓名

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *address_id;

@property (nonatomic, copy) NSString *address;// 地名
@property (nonatomic, copy) NSString *province_name;// 省
@property (nonatomic, copy) NSString *city_name;// 市
@property (nonatomic, copy) NSString *district_name;// 区

@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *country;


@end
