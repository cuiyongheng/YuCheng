//
//  ShopStoreCollectionCell.m
//  YuCheng
//
//  Created by apple on 16/6/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShopStoreCollectionCell.h"

@implementation ShopStoreCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	self.cerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yc-54.jpg"]];
	[self.contentView addSubview:_cerImageView];

	[_cerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.right.bottom.left.mas_equalTo(self.contentView);
	}];
}



@end
