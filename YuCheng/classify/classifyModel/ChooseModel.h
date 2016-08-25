//
//  ChooseModel.h
//  YuCheng
//
//  Created by apple on 16/6/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface ChooseModel : BaseModel

@property (nonatomic, copy) NSString *attr_id;

@property (nonatomic, copy) NSString *attr_name;

@property (nonatomic, strong) NSMutableArray *attr_values;

@end
