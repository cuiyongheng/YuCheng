//
//  SaveTool.h
//  YuCheng
//
//  Created by apple on 16/8/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductInfoModel.h"

@interface SaveTool : NSObject

/**
 *  打开数据库
 */
+ (void)isHaveFile;

/**
 *  判断model在不在本地
 *
 *  @param priceModel 数据模型
 *
 *  @return 是就在本地 否就不在
 */
+ (BOOL)isHavePlist:(ProductInfoModel *)priceModel;

/**
 *  model储存在本地
 *
 *  @param proceModel 数据模型
 */
+ (void)saveToPlist:(ProductInfoModel *)proceModel;

/**
 *  删除数据
 *
 *  @param PriceModel 数据模型
 */
+ (void)cancelInPlist:(ProductInfoModel *)PriceModel;

/**
 *  读取数据
 *
 *  @return 数据数组
 */
+ (NSMutableArray *)takeSaveValue;

@end
