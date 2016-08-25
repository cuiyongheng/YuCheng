//
//  MyStoreHeadView.m
//  YuCheng
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyStoreHeadView.h"

@implementation MyStoreHeadView

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	self.headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"玉城LOGO-19.jpg"]];
	[self addSubview:_headImageView];

	[_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.and.right.and.top.mas_equalTo(self);
		make.height.mas_equalTo(UNITHEIGHT * 183);
	}];

//	self.nameLabel = [[UILabel alloc] init];
//	_nameLabel.text = @"荣宸珠宝";
//	_nameLabel.textColor = [UIColor blackColor];
//	_nameLabel.font = boldFont(10);
//	[self addSubview:_nameLabel];
//
//	[_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.mas_equalTo(UNITHEIGHT * 17);
//		make.top.mas_equalTo(_headImageView.mas_bottom).with.offset(UNITHEIGHT * 12);
//		make.height.mas_equalTo(UNITHEIGHT * 10);
//	}];

//	_introduceLabel = [[UILabel alloc] init];
//	_introduceLabel.text = @"大叔大叔大大神大神大神大神大神解答了贷款及案例的就爱上了打卡机的拉开大家阿斯兰的骄傲是大连市发生的健康\n四大四大四大打算的撒大大大叔\n阿打算打算打打实打实大大大大\nadsadasdasdasdas阿萨德撒大大实打实大师大大大大是打算打打按时大大大叔大大大大打算打打打算打打打打死的打算打打打";
//	_introduceLabel.textColor = [UIColor colorWithHexString:@"#717071"];
//	_introduceLabel.font = font(10);
//	_introduceLabel.numberOfLines = 0;
//	[self addSubview:_introduceLabel];
//
//	[_introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.mas_equalTo(self).with.offset(UNITHEIGHT * 17);
//		make.right.mas_equalTo(self).with.offset(-UNITHEIGHT * 17);
//		make.top.mas_equalTo(_nameLabel.mas_bottom).with.offset(UNITHEIGHT * 9);
//		make.bottom.mas_lessThanOrEqualTo(self);
//	}];
//	[_introduceLabel sizeToFit];

	self.serviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_serviceButton setBackgroundImage:[UIImage imageNamed:@"yc-20"] forState:UIControlStateNormal];
	[self addSubview:_serviceButton];

	[_serviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(self).with.offset(-UNITHEIGHT * 17);
		make.height.and.width.mas_equalTo(UNITHEIGHT * 28.5);
		make.bottom.mas_equalTo(_headImageView).with.offset(-UNITHEIGHT * 21);
	}];
}


@end
