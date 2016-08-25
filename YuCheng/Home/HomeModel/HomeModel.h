//
//  HomeModel.h
//  YuCheng
//
//  Created by apple on 16/6/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface HomeModel : BaseModel

//@property (nonatomic, copy) NSString *supplier_name;// 商铺名
//
//@property (nonatomic, copy) NSString *supplier_id;// 商铺ID
//
//@property (nonatomic, strong) NSMutableArray *goods_list;// 商品信息
//
//@property (nonatomic, copy) NSString *shop_index_img;// 商铺图片

@property (nonatomic, copy) NSString *cat_name;// 分类

@property (nonatomic, copy) NSString *img;// 分类图片

@property (nonatomic, strong) NSMutableArray *goods;

@end
