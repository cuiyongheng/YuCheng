//
//  ProductInfoModel.m
//  YuCheng
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ProductInfoModel.h"

@implementation ProductInfoModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:self.goods_id forKey:@"goods_id"];
	[aCoder encodeObject:self.goods_number forKey:@"goods_number"];
	[aCoder encodeObject:self.shop_price forKey:@"shop_price"];
	[aCoder encodeObject:self.deposit forKey:@"deposit"];
	[aCoder encodeObject:self.goods_name forKey:@"goods_name"];
	[aCoder encodeObject:self.inside_diameter forKey:@"inside_diameter"];
	[aCoder encodeObject:self.goods_width forKey:@"goods_width"];
	[aCoder encodeObject:self.goods_thickness forKey:@"goods_thickness"];
	[aCoder encodeObject:self.goods_color forKey:@"goods_color"];
	[aCoder encodeObject:self.transparency forKey:@"transparency"];
	[aCoder encodeObject:self.defect forKey:@"defect"];
	[aCoder encodeObject:self.origin_place forKey:@"origin_place"];
	[aCoder encodeObject:self.craft forKey:@"craft"];
	[aCoder encodeObject:self.editor forKey:@"editor"];
	[aCoder encodeObject:self.photographer forKey:@"photographer"];
	[aCoder encodeObject:self.photo_time forKey:@"photo_time"];
	[aCoder encodeObject:self.goods_vedio_url forKey:@"goods_vedio_url"];
	[aCoder encodeObject:self.goods_thumb forKey:@"goods_thumb"];
	[aCoder encodeObject:self.supplier_name forKey:@"supplier_name"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
	if (self) {
		self.goods_id = [aDecoder decodeObjectForKey:@"goods_id"];
		self.goods_number = [aDecoder decodeObjectForKey:@"goods_number"];
		self.shop_price = [aDecoder decodeObjectForKey:@"shop_price"];
		self.deposit = [aDecoder decodeObjectForKey:@"deposit"];
		self.goods_name = [aDecoder decodeObjectForKey:@"goods_name"];
		self.inside_diameter = [aDecoder decodeObjectForKey:@"inside_diameter"];
		self.goods_width = [aDecoder decodeObjectForKey:@"goods_width"];
		self.goods_thickness = [aDecoder decodeObjectForKey:@"goods_thickness"];
		self.goods_color = [aDecoder decodeObjectForKey:@"goods_color"];
		self.transparency = [aDecoder decodeObjectForKey:@"transparency"];
		self.defect = [aDecoder decodeObjectForKey:@"defect"];
		self.origin_place = [aDecoder decodeObjectForKey:@"origin_place"];
		self.craft = [aDecoder decodeObjectForKey:@"craft"];
		self.editor = [aDecoder decodeObjectForKey:@"editor"];
		self.photographer = [aDecoder decodeObjectForKey:@"photographer"];
		self.photo_time = [aDecoder decodeObjectForKey:@"photo_time"];
		self.goods_vedio_url = [aDecoder decodeObjectForKey:@"goods_vedio_url"];
		self.goods_thumb = [aDecoder decodeObjectForKey:@"goods_thumb"];
		self.supplier_name = [aDecoder decodeObjectForKey:@"supplier_name"];
	}
	return self;
}

@end
