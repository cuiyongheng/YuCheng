//
//  ProductInfoModel.h
//  YuCheng
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface ProductInfoModel : BaseModel

@property (nonatomic, copy) NSString *goods_id;// ID

@property (nonatomic, copy) NSString *goods_number;// 库存

@property (nonatomic, copy) NSString *goods_thumb;

@property (nonatomic, copy) NSString *supplier_name;

@property (nonatomic, copy) NSString *shop_price;// 价格

@property (nonatomic, copy) NSString *deposit;// 定金

@property (nonatomic, copy) NSString *goods_name;// 名字

@property (nonatomic, copy) NSString *inside_diameter;// 内径

@property (nonatomic, copy) NSString *goods_width;// 宽

@property (nonatomic, copy) NSString *goods_thickness;// 厚

@property (nonatomic, copy) NSString *goods_color;// 颜色

@property (nonatomic, copy) NSString *transparency;// 透明度

@property (nonatomic, copy) NSString *defect;// 瑕坯裂絮

@property (nonatomic, copy) NSString *origin_place;// 原石产地

@property (nonatomic, copy) NSString *craft;// 工艺水平

@property (nonatomic, copy) NSString *editor;// 编辑

@property (nonatomic, copy) NSString *photographer;// 摄影师

@property (nonatomic, copy) NSString *photo_time;// 摄影时间

@property (nonatomic, copy) NSString *goods_vedio_url;// player

@end
