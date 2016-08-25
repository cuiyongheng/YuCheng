//
//  RIghtNavigationView.m
//  YuCheng
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RIghtNavigationView.h"

@implementation RIghtNavigationView

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
	self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.leftButton.layer.cornerRadius = UNITHEIGHT * 27.5 / 2;
	[_leftButton setBackgroundImage:[UIImage imageNamed:@"yc-20"] forState:UIControlStateNormal];
	[_leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_leftButton];

	self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
	_rightButton.layer.cornerRadius = UNITHEIGHT * 27.5 / 2;
	[_rightButton setBackgroundImage:[UIImage imageNamed:@"yc-21"] forState:UIControlStateNormal];
	[_rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_rightButton];

	self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
	_shareButton.layer.cornerRadius = UNITHEIGHT * 27.5 / 2;
	[_shareButton setBackgroundImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
	[_shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_shareButton];

	self.favourButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_favourButton setBackgroundImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
	[_favourButton addTarget:self action:@selector(favourButton:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_favourButton];

	self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_saveButton setBackgroundImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
	[_saveButton addTarget:self action:@selector(saveButton:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_saveButton];


	[_favourButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self);
		make.top.mas_equalTo(self);
		make.height.and.width.mas_equalTo(UNITHEIGHT * 27.5);
	}];

	[_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_favourButton.mas_right).with.offset(UNITHEIGHT * 10);
		make.top.and.height.and.width.mas_equalTo(_leftButton);
	}];

	[_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_saveButton.mas_right).with.offset(UNITHEIGHT * 10);
		make.top.mas_equalTo(self);
		make.height.and.width.mas_equalTo(UNITHEIGHT * 27.5);
	}];

	[_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_leftButton.mas_right).with.offset(UNITHEIGHT * 10);
		make.top.and.height.and.width.mas_equalTo(_leftButton);
	}];

	[_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_shareButton.mas_right).with.offset(UNITHEIGHT * 10);
		make.top.and.height.and.width.mas_equalTo(_leftButton);
	}];

	self.numberLabel = [[UILabel alloc] init];
	_numberLabel.backgroundColor = [UIColor redColor];
	_numberLabel.font = font(11);
	_numberLabel.textColor = [UIColor whiteColor];
//	_numberLabel.text = @"0";
	_numberLabel.layer.cornerRadius = UNITHEIGHT * 15 / 2;
	_numberLabel.layer.masksToBounds = YES;
	_numberLabel.textAlignment = NSTextAlignmentCenter;
	[self addSubview:_numberLabel];

	[_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.width.mas_equalTo(UNITHEIGHT * 15);
		make.left.mas_equalTo(_rightButton.mas_centerX);
		make.bottom.mas_equalTo(_rightButton.mas_centerY);
	}];

}

- (void)leftAction:(UIButton *)button {
	[self.delegate relationService];
}

- (void)rightAction:(UIButton *)button {
	[self.delegate pushShopping];
}

- (void)shareAction:(UIButton *)button {
	[self.delegate shareImage];
}

- (void)favourButton:(UIButton *)button {
	[self.delegate takeFavour:button];
}

- (void)saveButton:(UIButton *)button {
	[self.delegate saveCollection:button];
}

@end

