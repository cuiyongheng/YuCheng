//
//  PersonalOneCollectionCell.m
//  YuCheng
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PersonalOneCollectionCell.h"

@implementation PersonalOneCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	self.titleLabel = [[UILabel alloc] init];
	_titleLabel.backgroundColor = [UIColor colorWithHexString:@"#2d2f30"];
	_titleLabel.text = @"荣宸珠宝";
	_titleLabel.textAlignment = NSTextAlignmentCenter;
	_titleLabel.textColor = [UIColor whiteColor];
	_titleLabel.font = font(22);
	[self.contentView addSubview:_titleLabel];

	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.mas_equalTo(self.contentView);
		make.height.mas_equalTo(UNITHEIGHT * 56);
	}];
}

@end
