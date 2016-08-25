//
//  SaveWorking.m
//  YuCheng
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SaveWorking.h"

@implementation SaveWorking

// 清除缓存
+ (void)clearSave {
	NSFileManager *manager = [NSFileManager defaultManager];
	NSString *sandBoxCachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
	[manager removeItemAtPath:sandBoxCachesPath error:nil];

	NSString *sandBoxPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	NSString *docPath = [sandBoxPath stringByAppendingPathComponent:@"Watch"];
	[manager removeItemAtPath:docPath error:nil];
}

@end
