//
//  ClearFootView.m
//  YuCheng
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ClearFootView.h"

@implementation ClearFootView

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
	self.lineView = [[UIView alloc] init];
	_lineView.backgroundColor = [UIColor colorWithHexString:@"#a5a5a5"];
	[self addSubview:_lineView];

	[_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(1);
		make.width.mas_equalTo(UNITHEIGHT * 330);
		make.centerX.mas_equalTo(self);
		make.top.mas_equalTo(self).with.offset(UNITHEIGHT * 10);
	}];

	self.frameImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yc-37"]];
	[self addSubview:_frameImageView];

	[_frameImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(UNITHEIGHT * 24.5);
		make.top.mas_equalTo(_lineView).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 45);
		make.width.mas_equalTo(UNITHEIGHT * 190.5);
	}];

	self.tureButton = [UIButton buttonWithType:UIButtonTypeCustom];
	_tureButton.backgroundColor = [UIColor blackColor];
	[_tureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	_tureButton.titleLabel.font = font(19);
	[_tureButton addTarget:self action:@selector(tureButton:) forControlEvents:UIControlEventTouchUpInside];
	[_tureButton setTitle:@"确认" forState:UIControlStateNormal];
	[self addSubview:_tureButton];

	[_tureButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_frameImageView.mas_right).with.offset(UNITHEIGHT * 10.5);
		make.height.mas_equalTo(UNITHEIGHT * 45);
		make.width.mas_equalTo(UNITHEIGHT * 124);
		make.top.mas_equalTo(_lineView).with.offset(UNITHEIGHT * 10);
	}];

	self.allLabel = [[UILabel alloc] init];
	_allLabel.text = @"合计";
	_allLabel.textColor = [UIColor colorWithHexString:@"#656464"];
	_allLabel.font = font(14);
	[self addSubview:_allLabel];

	[_allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_frameImageView).with.offset(UNITHEIGHT * 14);
		make.centerY.mas_equalTo(_frameImageView);
		make.height.mas_equalTo(UNITHEIGHT * 10);
	}];

	self.moneyLabel = [[UILabel alloc] init];
	_moneyLabel.text = @"¥97000";
	_moneyLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
	_moneyLabel.font = font(14);
	[self addSubview:_moneyLabel];

	[_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(_frameImageView);
		make.right.mas_equalTo(_frameImageView).with.offset(-UNITHEIGHT * 14);
		make.height.mas_equalTo(UNITHEIGHT * 10);
	}];

//	self.squareView = [[UIView alloc] init];
//	_squareView.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
//	[self addSubview:_squareView];
//
//	[_squareView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.mas_equalTo(_lineView);
//		make.height.mas_equalTo(UNITHEIGHT * 30);
//		make.width.mas_equalTo(UNITHEIGHT * 5);
//		make.bottom.mas_equalTo(_lineView).with.offset(-UNITHEIGHT * 10);
//	}];
//
//	self.freeLabel = [[UILabel alloc] init];
//	_freeLabel.text = @"优惠券";
//	_freeLabel.font = font(14);
//	[self addSubview:_freeLabel];
//
//	[_freeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.mas_equalTo(_squareView).with.offset(UNITHEIGHT * 10);
//		make.centerY.mas_equalTo(_squareView);
//	}];
//
//	self.arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightArrow"]];
//	[self addSubview:_arrowImageView];
//
//	[_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.right.mas_equalTo(_lineView);
//		make.centerY.mas_equalTo(_squareView);
//		make.height.mas_equalTo(UNITHEIGHT * 30);
//		make.width.mas_equalTo(UNITHEIGHT * 5);
//	}];
//
//	self.freeMoneyLabel = [[UILabel alloc] init];
//	_freeMoneyLabel.text = @"满1000减100";
//	_freeMoneyLabel.font = font(14);
//	_freeMoneyLabel.textAlignment = NSTextAlignmentRight;
//	[self addSubview:_freeMoneyLabel];
//
//	[_freeMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.right.mas_equalTo(_arrowImageView.mas_left).with.offset(-UNITHEIGHT * 5);
//		make.centerY.mas_equalTo(_squareView);
//	}];

}

- (void)tureButton:(UIButton *)button {
	[self.delegate tureClearing];
}

@end
