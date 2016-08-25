//
//  IntroduceCollectionCell.m
//  YuCheng
//
//  Created by apple on 16/6/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "IntroduceCollectionCell.h"

@implementation IntroduceCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	self.headImageView = [[UIImageView alloc] init];
	_headImageView.layer.cornerRadius = UNITHEIGHT * 28;
	_headImageView.layer.masksToBounds = YES;
	[self.contentView addSubview:_headImageView];

	[_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.contentView);
		make.height.width.mas_equalTo(UNITHEIGHT * 56);
	}];

	self.titleLabel = [[UILabel alloc] init];
	_titleLabel.textColor = [UIColor colorWithHexString:@"#221814"];
	_titleLabel.font = font(11);
	[self.contentView addSubview:_titleLabel];

	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_headImageView);
		make.top.mas_equalTo(_headImageView.mas_bottom).with.offset(UNITHEIGHT * 13);
	}];

	self.introduceLabel = [[UILabel alloc] init];
	_introduceLabel.text = @"透明\n内部汇聚光较强\n多数光线可透过\n内部特征清晰可见\n标注：\n透明";
	_introduceLabel.textColor = [UIColor colorWithHexString:@"#221814"];
	_introduceLabel.font = font(9);
	_introduceLabel.numberOfLines = 0;
	[self.contentView addSubview:_introduceLabel];

	[_introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_titleLabel);
		make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(UNITHEIGHT * 5);
		make.right.mas_equalTo(self.contentView);
	}];
}

@end
