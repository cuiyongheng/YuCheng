//
//  RegisterInfo.m
//  YuCheng
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RegisterInfo.h"

@implementation RegisterInfo

+ (instancetype)shareSingleton {
	static RegisterInfo *single;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		single = [[RegisterInfo alloc] init];
	});
	return single;
}

@end
