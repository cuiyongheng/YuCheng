//
//  BaseModel.h
//  YuCheng
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

/**
 *  数据解析
 *
 *  @param arr 包含所有字典的数组
 *
 *  @return 包含所有Model的数组
 */
+ (NSMutableArray *)BaseModel:(NSArray *)arr;

@end
