//
//  ShoppingFootView.m
//  YuCheng
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShoppingFootView.h"

@implementation ShoppingFootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

{
	BOOL isAllChoose;
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self createView];
		self.backgroundColor = [UIColor whiteColor];
		isAllChoose = 0;
	}
	return self;
}

- (void)createView {
	self.lineView = [[UIView alloc] init];
	_lineView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
	[self addSubview:_lineView];

	[_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self).with.offset(UNITHEIGHT * 15);
		make.right.mas_equalTo(self).with.offset(-UNITHEIGHT * 15);
		make.top.mas_equalTo(self).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(1);
	}];

//	self.oneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
//	[self addSubview:_oneImageView];
//
//	[_oneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.mas_equalTo(self).with.offset(UNITHEIGHT * 5);
//		make.width.mas_equalTo(UNITHEIGHT * 324.5);
//		make.height.mas_equalTo(UNITHEIGHT * 41);
//		make.top.mas_equalTo(self.lineView).with.offset(UNITHEIGHT * 14);
//	}];
//
//	self.twoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yc-37"]];
//	[self addSubview:_twoImageView];
//
//	[_twoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.mas_equalTo(self).with.offset(UNITHEIGHT * 5);
//		make.width.mas_equalTo(UNITHEIGHT * 191);
//		make.height.mas_equalTo(UNITHEIGHT * 41);
//		make.top.mas_equalTo(_oneImageView.mas_bottom).with.offset(UNITHEIGHT * 14);
//	}];
//
//	self.settleButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	_settleButton.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
//	[_settleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//	_settleButton.titleLabel.font = font(19);
//	[_settleButton setTitle:@"结算" forState:UIControlStateNormal];
//	[_settleButton addTarget:self action:@selector(settleButton:) forControlEvents:UIControlEventTouchUpInside];
//	[self addSubview:_settleButton];
//
//	[_settleButton mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.width.mas_equalTo(UNITHEIGHT * 124);
//		make.height.mas_equalTo(UNITHEIGHT * 45);
//		make.left.mas_equalTo(_twoImageView.mas_right).with.offset(UNITHEIGHT * 10);
//		make.centerY.mas_equalTo(_twoImageView);
//	}];
//
//	self.mothodLabel = [[UILabel alloc] init];
//	_mothodLabel.text = @"支付方式";
//	_mothodLabel.textColor = [UIColor colorWithHexString:@"#656464"];
//	_mothodLabel.font = font(11);
//	[self addSubview:_mothodLabel];
//
//	[_mothodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.centerY.mas_equalTo(_oneImageView);
//		make.left.mas_equalTo(_oneImageView).with.offset(UNITHEIGHT * 14);
//		make.height.mas_equalTo(UNITHEIGHT * 20);
//	}];
//
//	self.payLabel = [[UILabel alloc] init];
//	_payLabel.text = @"微信支付";
//	_payLabel.font = font(11);
//	_payLabel.textColor = [UIColor colorWithHexString:@"#221814"];
//	[self addSubview:_payLabel];
//
//	[_payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.centerY.mas_equalTo(_mothodLabel);
//		make.height.mas_equalTo(_mothodLabel);
//		make.right.mas_equalTo(_oneImageView).with.offset(-UNITHEIGHT * 25);
//	}];
//
//	self.allLabel = [[UILabel alloc] init];
//	_allLabel.textColor = [UIColor colorWithHexString:@"#656464"];
//	_allLabel.text = @"合计";
//	_allLabel.font = font(11);
//	[self addSubview:_allLabel];
//
//	[_allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.mas_equalTo(_twoImageView).with.offset(UNITHEIGHT * 14);
//		make.centerY.mas_equalTo(_twoImageView);
//		make.height.mas_equalTo(UNITHEIGHT * 20);
//	}];
//
//	self.moneyLabel = [[UILabel alloc] init];
//	_moneyLabel.text = @"¥97000元";
//	_moneyLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
//	_moneyLabel.font = font(11);
//	[self addSubview:_moneyLabel];
//
//	[_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.right.mas_equalTo(_twoImageView).with.offset(-UNITHEIGHT * 14);
//		make.centerY.and.height.mas_equalTo(_allLabel);
//	}];
//
//	self.payButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	_payButton.backgroundColor = [UIColor clearColor];
//	[self addSubview:_payButton];
//	[_payButton addTarget:self action:@selector(payButton:) forControlEvents:UIControlEventTouchUpInside];
//
//	[_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.top.and.height.and.width.and.bottom.mas_equalTo(_oneImageView);
//	}];
//
//	self.arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-33"]];
//	[self addSubview:_arrowImageView];
//
//	[_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.width.mas_equalTo(UNITHEIGHT * 11.5);
//		make.height.mas_equalTo(UNITHEIGHT * 8);
//		make.right.mas_equalTo(_oneImageView).with.offset(-UNITHEIGHT * 7);
//		make.centerY.mas_equalTo(_oneImageView);
//	}];

	self.arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-33"]];
	[self addSubview:_arrowImageView];
	
	[_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.mas_equalTo(UNITHEIGHT * 11.5);
		make.height.mas_equalTo(UNITHEIGHT * 8);
		make.right.mas_equalTo(_lineView);
		make.top.mas_equalTo(_lineView).with.offset(UNITHEIGHT * 20);
	}];

	self.payLabel = [[UILabel alloc] init];
//	_payLabel.text = @"微信支付";
	_payLabel.font = font(14);
	_payLabel.textColor = [UIColor colorWithHexString:@"#221814"];
	[self addSubview:_payLabel];

	[_payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(_arrowImageView);
		make.height.mas_equalTo(UNITHEIGHT * 20);
		make.right.mas_equalTo(_arrowImageView.mas_left).with.offset(-UNITHEIGHT * 10);
	}];

	self.mothodLabel = [[UILabel alloc] init];
	_mothodLabel.text = @"支付方式:";
	_mothodLabel.textColor = [UIColor colorWithHexString:@"#656464"];
	_mothodLabel.font = font(14);
	[self addSubview:_mothodLabel];

	[_mothodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(_arrowImageView);
		make.right.mas_equalTo(_payLabel.mas_left).with.offset(-UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

	self.payButton = [UIButton buttonWithType:UIButtonTypeCustom];
	_payButton.backgroundColor = [UIColor clearColor];
	[self addSubview:_payButton];
	[_payButton addTarget:self action:@selector(payButton:) forControlEvents:UIControlEventTouchUpInside];

	[_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(_arrowImageView);
		make.left.mas_equalTo(_mothodLabel);
		make.top.bottom.mas_equalTo(_mothodLabel);
	}];

	self.roundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redRound"]];
	[self addSubview:_roundImageView];

	[_roundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_lineView).with.offset(UNITHEIGHT * 10);
		make.centerY.mas_equalTo(_arrowImageView);
		make.height.width.mas_equalTo(UNITHEIGHT * 25);
	}];

	UILabel *allLabel = [[UILabel alloc] init];
	allLabel.text = @"全选";
	allLabel.font = font(14);
	[self addSubview:allLabel];

	[allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_roundImageView.mas_right).with.offset(UNITHEIGHT * 10);
		make.centerY.mas_equalTo(_roundImageView);
	}];

	UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[allButton addTarget:self action:@selector(allbutton:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:allButton];

	[allButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.top.bottom.mas_equalTo(_roundImageView);
		make.right.mas_equalTo(allLabel);
	}];

	self.settleButton = [UIButton buttonWithType:UIButtonTypeCustom];
	_settleButton.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
	[_settleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	_settleButton.titleLabel.font = font(19);
	[_settleButton setTitle:@"结算" forState:UIControlStateNormal];
	[_settleButton addTarget:self action:@selector(settleButton:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_settleButton];

	[_settleButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.mas_equalTo(UNITHEIGHT * 124);
		make.height.mas_equalTo(UNITHEIGHT * 45);
		make.right.mas_equalTo(_lineView);
		make.bottom.mas_equalTo(self).with.offset(-UNITHEIGHT * 10);
	}];

	UILabel *total = [[UILabel alloc] init];
	total.text = @"合计";
	total.font = font(14);
	[self addSubview:total];

	[total mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_lineView).with.offset(UNITHEIGHT * 10);
		make.bottom.mas_equalTo(_settleButton.mas_centerY).with.offset(-UNITHEIGHT * 5);
	}];

	self.allMoneyLabel = [[UILabel alloc] init];
	_allMoneyLabel.text = @"¥0.00元";
	_allMoneyLabel.font = font(14);
	[self addSubview:_allMoneyLabel];

	[_allMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(_settleButton.mas_left).with.offset(-UNITHEIGHT * 20);
		make.centerY.mas_equalTo(total);
	}];

	self.twoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
	[self addSubview:_twoImageView];

	[_twoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_lineView);
		make.bottom.mas_equalTo(_settleButton);
		make.top.mas_equalTo(_settleButton.mas_centerY);
		make.right.mas_equalTo(_settleButton.mas_left).with.offset(-UNITHEIGHT * 10);
	}];
//
//	UILabel *dingjin = [[UILabel alloc] init];
//	dingjin.text = @"支付";
//	dingjin.font = font(14);
//	[self addSubview:dingjin];
//
//	[dingjin mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.mas_equalTo(total);
//		make.centerY.mas_equalTo(_twoImageView);
//	}];
//
//	self.dingjinMoneyLabel = [[UILabel alloc] init];
//	_dingjinMoneyLabel.text = @"¥0.00元";
//	_dingjinMoneyLabel.font = font(14);
//	_dingjinMoneyLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
//	[self addSubview:_dingjinMoneyLabel];
//
//	[_dingjinMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.right.mas_equalTo(_allMoneyLabel);
//		make.centerY.mas_equalTo(_twoImageView);
//	}];


}

- (void)payButton:(UIButton *)button {
	NSLog(@"支付方式");
	[self.delegate payMethod];
}

- (void)allbutton:(UIButton *)button {

	isAllChoose = !isAllChoose;
	[self.delegate allChoose:isAllChoose];
	if (isAllChoose) {
		_roundImageView.image = [UIImage imageNamed:@"redBinggou"];
	} else {
		_roundImageView.image = [UIImage imageNamed:@"redRound"];
	}

}

- (void)settleButton:(UIButton *)button {
	[self.delegate clearingShopping];
}

@end
