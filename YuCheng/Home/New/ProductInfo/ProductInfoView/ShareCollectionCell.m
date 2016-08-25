//
//  ShareCollectionCell.m
//  YuCheng
//
//  Created by apple on 16/7/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShareCollectionCell.h"

@implementation ShareCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	self.imageViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_imageViewButton addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
	[self.contentView addSubview:_imageViewButton];

	[_imageViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.bottom.left.right.mas_equalTo(self.contentView);
	}];

	self.picImageView = [[UIImageView alloc] init];
	[self.contentView addSubview:_picImageView];

	[_picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.contentView);
		make.top.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 20);
		make.width.height.mas_equalTo(UNITHEIGHT * 50);
	}];

	self.titleLabel = [[UILabel alloc] init];
	_titleLabel.font = font(14);
	_titleLabel.textAlignment = NSTextAlignmentCenter;
	_titleLabel.textColor = [UIColor colorWithHexString:@"#c6c6cc"];
	[self.contentView addSubview:_titleLabel];

	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.contentView);
		make.height.mas_equalTo(UNITHEIGHT * 20);
		make.top.mas_equalTo(_picImageView.mas_bottom).with.offset(UNITHEIGHT * 20);
	}];
}

- (void)shareButton:(UIButton *)button {
	[self.delegate shareImageToThirdPart:button.tag];
}

@end
