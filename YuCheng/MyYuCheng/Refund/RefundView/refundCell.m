//
//  refundCell.m
//  YuCheng
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "refundCell.h"

@implementation refundCell

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	self.updateImageView = [UIButton buttonWithType:UIButtonTypeCustom];
	[_updateImageView addTarget:self action:@selector(updateImageVIew:) forControlEvents:UIControlEventTouchUpInside];
	[self.contentView addSubview:_updateImageView];

	[_updateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.bottom.mas_equalTo(self.contentView);
	}];
}

- (void)updateImageVIew:(UIButton *)button {
	[self.delegate updateImageView:button];
}

@end
