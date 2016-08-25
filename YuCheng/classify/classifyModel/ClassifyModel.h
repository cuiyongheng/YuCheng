//
//  ClassifyModel.h
//  YuCheng
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface ClassifyModel : BaseModel

@property (nonatomic, copy) NSString *attr_id;

@property (nonatomic, copy) NSString *attr_name;

@property (nonatomic, strong) NSMutableArray *attr_values;

@end
