//
//  SaveDataModel.m
//  YuCheng
//
//  Created by apple on 16/8/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SaveDataModel.h"

@implementation SaveDataModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:self.product_id forKey:@"product_id"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
	if (self) {
		self.product_id = [aDecoder decodeObjectForKey:@"product_id"];
	}
	return self;
}

@end
