//
//  RecommendModel.h
//  YuCheng
//
//  Created by apple on 16/6/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface RecommendModel : BaseModel

@property (nonatomic, copy) NSString *supplier_id;

@property (nonatomic, copy) NSString *rank_name;

@property (nonatomic, copy) NSString *shop_logo;

@property (nonatomic, strong) NSMutableArray *goods_list;

@property (nonatomic, copy) NSString *shop_index_img;

@end
