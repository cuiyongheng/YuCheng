//
//  MyOrderFootView.m
//  YuCheng
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyOrderFootView.h"

@implementation MyOrderFootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
	self = [super init];
	if (self) {
		[self createView];
		self.backgroundColor = [UIColor whiteColor];
	}
	return self;
}

- (void)createView {
	self.lineView = [[UIView alloc] init];
	_lineView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
	[self addSubview:_lineView];

	[_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self);
		make.width.mas_equalTo(UNITHEIGHT * 324);
		make.height.mas_equalTo(1);
		make.top.mas_equalTo(self).with.offset(UNITHEIGHT * 5);
	}];

	self.backView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yc-34"]];
	[self addSubview:_backView];

	[_backView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.and.left.mas_equalTo(_lineView);
		make.centerY.mas_equalTo(self);
		make.height.mas_equalTo(UNITHEIGHT * 41);
	}];

	self.allLabel = [[UILabel alloc] init];
	_allLabel.text = @"合计";
	_allLabel.textColor = [UIColor colorWithHexString:@"#656464"];
	_allLabel.font = font(11);
	[self addSubview:_allLabel];

	[_allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_backView).with.offset(UNITHEIGHT * 10);
		make.centerY.mas_equalTo(_backView);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

	self.moneyLabel = [[UILabel alloc] init];
	_moneyLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
	_moneyLabel.font = font(11);
//	_moneyLabel.text = @"¥97000";
	[self addSubview:_moneyLabel];

	[_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(self.backView).with.offset(-UNITHEIGHT * 10);
		make.centerY.mas_equalTo(_backView);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

}

@end
