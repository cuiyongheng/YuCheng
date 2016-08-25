//
//  SaveTool.m
//  YuCheng
//
//  Created by apple on 16/8/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SaveTool.h"

@implementation SaveTool

// 创建文件夹
+ (void)isHaveFile {
	NSString *sandBoxPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	NSString *docPath = [sandBoxPath stringByAppendingPathComponent:@"YuCheng"];
	//创建文件管理制
	NSFileManager *manager = [NSFileManager defaultManager];
	if (![manager fileExistsAtPath:docPath]) {
		[manager createDirectoryAtPath:docPath withIntermediateDirectories:YES attributes:nil error:nil];
	}
}

// 判断是否有本条数据
+ (BOOL)isHavePlist:(ProductInfoModel *)priceModel {
	NSString *sandBoxPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	NSString *docPath = [sandBoxPath stringByAppendingPathComponent:@"footmark.plist"];

	// 反归档
	NSArray *tempArr = [NSKeyedUnarchiver unarchiveObjectWithFile:docPath];
	// 遍历
	for (ProductInfoModel *model in tempArr) {
		if ([model.goods_id isEqualToString:priceModel.goods_id]) {
			return NO;
		}
	}
	return YES;
}

// 存数据
+ (void)saveToPlist:(ProductInfoModel *)proceModel {
	NSString *sandBoxPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	NSString *docPath = [sandBoxPath stringByAppendingPathComponent:@"footmark.plist"];

	// 反归档
	NSMutableArray *tempArr = [NSKeyedUnarchiver unarchiveObjectWithFile:docPath];
	if (tempArr == nil) {
		tempArr = [NSMutableArray array];
	}
	if (tempArr.count >= 17) {
		[tempArr removeObjectAtIndex:0];
		[tempArr addObject:proceModel];
	} else {
		[tempArr addObject:proceModel];
	}

	// 归档
	[NSKeyedArchiver archiveRootObject:tempArr toFile:docPath];
	NSLog(@"%@", docPath);
}

// 移除数据
+ (void)cancelInPlist:(ProductInfoModel *)PriceModel {
	NSString *sandBoxPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	NSString *docPath = [sandBoxPath stringByAppendingPathComponent:@"footmark.plist"];

	// 反归档
	NSMutableArray *tempArr = [NSKeyedUnarchiver unarchiveObjectWithFile:docPath];

	for (ProductInfoModel *model in tempArr) {
		if ([model.goods_id isEqualToString:PriceModel.goods_id]) {
			[tempArr removeObject:model];
			break;
		}
	}
	// 归档
	[NSKeyedArchiver archiveRootObject:tempArr toFile:docPath];
}

// 本地取值
+ (NSMutableArray *)takeSaveValue {
	NSString *sandBoxPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	NSString *docPath = [sandBoxPath stringByAppendingPathComponent:@"footmark.plist"];
	NSMutableArray *tempArr = [NSKeyedUnarchiver unarchiveObjectWithFile:docPath];
	return tempArr;
}


@end
