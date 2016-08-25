//
//  InfoStatsView.m
//  YuCheng
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "InfoStatsView.h"

@implementation InfoStatsView

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
	}
	return self;
}

- (void)createView {
	self.whiteBackView = [[UIView alloc] init];
	_whiteBackView.backgroundColor = [UIColor whiteColor];
	[self addSubview:_whiteBackView];

	[_whiteBackView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.mas_equalTo(self);
		make.height.mas_equalTo(UNITHEIGHT * 18);
	}];

	self.blackBackView = [[UIView alloc] init];
	_blackBackView.backgroundColor = [UIColor blackColor];
	_blackBackView.alpha = 0.8;
	[self addSubview:_blackBackView];

	[_blackBackView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.bottom.mas_equalTo(self);
		make.top.mas_equalTo(_whiteBackView.mas_bottom);
	}];

	self.statsLabel = [[UILabel alloc] init];
	_statsLabel.font = font(14);
//	_statsLabel.text = @"剩余00天";
	[self addSubview:_statsLabel];

	self.timeLabel = [[UILabel alloc] init];
	_timeLabel.font = font(14);
//	_timeLabel.text = @"24:00:00";
	[self addSubview:_timeLabel];

	self.discountLabel = [[UILabel alloc] init];
//	_discountLabel.text = @"5折";
	_discountLabel.layer.cornerRadius = UNITHEIGHT * 34 / 2;
	_discountLabel.backgroundColor = [UIColor whiteColor];
	_discountLabel.layer.masksToBounds = YES;
	_discountLabel.textAlignment = NSTextAlignmentCenter;
	[self addSubview:_discountLabel];

	_moneyLabel = [[UILabel alloc] init];
//	_moneyLabel.text = @"¥41000";
	_moneyLabel.textColor = [UIColor whiteColor];
	_moneyLabel.font = font(14);
	[self addSubview:_moneyLabel];

	self.priceLabel = [[UILabel alloc] init];
//	_priceLabel.text = @"原价¥10000";
	_priceLabel.textColor = [UIColor colorWithHexString:@"#b4b5b5"];
	_priceLabel.font = font(11);
	[self addSubview:_priceLabel];



	[_statsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self).with.offset(UNITHEIGHT * 14);
		make.height.mas_equalTo(UNITHEIGHT * 10);
		make.centerY.mas_equalTo(_whiteBackView);
	}];

	[_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_statsLabel.mas_right).with.offset(UNITHEIGHT * 5);
		make.height.mas_equalTo(UNITHEIGHT * 10);
		make.centerY.mas_equalTo(_whiteBackView);
	}];

	[_discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self).with.offset(UNITHEIGHT * 14);
		make.top.mas_equalTo(_whiteBackView.mas_bottom).with.offset(UNITHEIGHT * 8.5);
		make.height.width.mas_equalTo(UNITHEIGHT * 34);
	}];

	[_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_whiteBackView.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.left.mas_equalTo(_discountLabel.mas_right).with.offset(UNITHEIGHT * 14);
		make.height.mas_equalTo(UNITHEIGHT * 10);
	}];

	[_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_moneyLabel);
		make.top.mas_equalTo(_moneyLabel.mas_bottom).with.offset(UNITHEIGHT * 5);
	}];
}

@end
