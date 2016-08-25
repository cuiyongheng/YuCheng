//
//  BaseModel.m
//  YuCheng
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (NSMutableArray *)BaseModel:(NSArray *)arr {
    
    NSMutableArray *modelArray = [NSMutableArray array];
    for (NSDictionary *tempDic in arr) {
        
        id model = [[self class] baseModelWithDic:tempDic];
        [modelArray addObject:model];
    }
    
    return modelArray;
    
}

// 便利构造器
+ (instancetype)baseModelWithDic:(NSDictionary *)tempDic {
    id model = [[[self class] alloc] initWithBaseModel:tempDic];
    return model;
}

// 初始化
- (instancetype)initWithBaseModel:(NSDictionary *)tempDic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:tempDic];
    }
    
    return self;
}

// 纠错方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


@end
