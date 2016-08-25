//
//  clearHeadView.m
//  YuCheng
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "clearHeadView.h"

@implementation clearHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self createView];

		self.backgroundColor = [UIColor colorWithHexString:@"e5e6e6"];
	}
	return self;
}

- (void)createView {
	self.loactionImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yc-63"]];
	[self addSubview:_loactionImageView];

	[_loactionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self).with.offset(UNITHEIGHT * 17);
		make.top.mas_equalTo(self).with.offset(UNITHEIGHT * 21);
		make.height.mas_equalTo(UNITHEIGHT * 27.5);
		make.width.mas_equalTo(UNITHEIGHT * 23);
	}];

	self.nameLabel = [[UILabel alloc] init];
//	_nameLabel.text = @"收货人：刘公子";
	_nameLabel.textColor = [UIColor colorWithHexString:@"#717071"];
	_nameLabel.font = font(11);
	[self addSubview:_nameLabel];

	[_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(UNITHEIGHT * 16);
		make.height.mas_equalTo(UNITHEIGHT * 10);
		make.left.mas_equalTo(_loactionImageView.mas_right).with.offset(UNITHEIGHT * 17);
	}];

	self.addLabel = [[UILabel alloc] init];
//	_addLabel.text = @"收货地址：云南省XXXXXXXXXXXXXXXXXXXX";
	_addLabel.font = font(11);
	_addLabel.textColor = [UIColor colorWithHexString:@"#717071"];
	[self addSubview:_addLabel];

	[_addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.mas_equalTo(UNITHEIGHT * 231);
		make.height.mas_equalTo(UNITHEIGHT * 10);
		make.left.mas_equalTo(_nameLabel);
		make.top.mas_equalTo(_nameLabel.mas_bottom).with.offset(UNITHEIGHT * 12);
	}];

	self.arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yc-64"]];
	[self addSubview:_arrowImageView];

	[_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(self).with.offset(-UNITHEIGHT * 11);
		make.centerY.mas_equalTo(self);
		make.height.mas_equalTo(UNITHEIGHT * 19);
		make.width.mas_equalTo(UNITHEIGHT * 9.5);
	}];

	self.phoneLabel = [[UILabel alloc] init];
	_phoneLabel.textColor = [UIColor colorWithHexString:@"#717071"];
//	_phoneLabel.text = @"13888888888";
	_phoneLabel.font = font(11);
	[self addSubview:_phoneLabel];

	[_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self).with.offset(UNITHEIGHT * 16);
		make.right.mas_equalTo(self).with.offset(-UNITHEIGHT * 34);
	}];
}

- (void)setUserDic:(NSMutableDictionary *)userDic {
	_userDic = userDic;
	_phoneLabel.text = userDic[@"mobile"];
	_addLabel.text = [NSString stringWithFormat:@"收货地址：%@", userDic[@"region"]];
	_nameLabel.text = [NSString stringWithFormat:@"收货人：%@", userDic[@"consignee"]];
}

@end
