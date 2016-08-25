//
//  UserHeadView.m
//  YuCheng
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UserHeadView.h"

@implementation UserHeadView

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
	self.blackView = [[UIView alloc] init];
	_blackView.backgroundColor = [UIColor colorWithHexString:@"#2d2f30"];
	[self addSubview:_blackView];

	[_blackView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.and.top.mas_equalTo(self);
		make.height.mas_equalTo(UNITHEIGHT * 140);
		make.top.mas_equalTo(self).with.offset(-20);
	}];

	self.logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon (4)"]];
	[self addSubview:_logoImageView];

	[_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_blackView);
		make.height.mas_equalTo(UNITHEIGHT * 48.4);
		make.width.mas_equalTo(UNITHEIGHT * 41);
		make.centerY.mas_equalTo(_blackView);
	}];

	self.settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	[_settingButton setBackgroundImage:[UIImage imageNamed:@"icon (3)"] forState:UIControlStateNormal];
	[_settingButton setTitle:@"退出" forState:UIControlStateNormal];
	[_settingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	_settingButton.titleLabel.font = font(14);
	[_settingButton addTarget:self action:@selector(settingButton:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_settingButton];

	[_settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.mas_equalTo(UNITHEIGHT * 80);
		make.height.mas_equalTo(UNITHEIGHT * 20);
		make.top.mas_equalTo(UNITHEIGHT * 12);
		make.right.mas_equalTo(-UNITHEIGHT * 18);
	}];

	self.headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yc-48"]];
	_headImageView.userInteractionEnabled = YES;
	_headImageView.layer.cornerRadius = UNITHEIGHT * 30;
	_headImageView.layer.masksToBounds = YES;
	[self addSubview:_headImageView];

	[_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(UNITHEIGHT * 32);
		make.top.mas_equalTo(_blackView.mas_bottom).with.offset(UNITHEIGHT * 16.8);
		make.width.and.height.mas_equalTo(UNITHEIGHT * 60);
	}];

	UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(takeHeadImageView:)];
	[_headImageView addGestureRecognizer:headTap];


	self.nameLabel = [[UILabel alloc] init];
//	_nameLabel.text = @"刘公子";
	_nameLabel.textColor = [UIColor colorWithHexString:@"#2d2f30"];
	_nameLabel.font = font(22);
	[self addSubview:_nameLabel];

	[_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_headImageView.mas_right).with.offset(UNITHEIGHT * 25.5);
		make.height.mas_equalTo(UNITHEIGHT * 30);
		make.centerY.mas_equalTo(_headImageView);
		make.right.mas_equalTo(self).with.offset(-UNITHEIGHT * 10);
	}];



	// button
	UIImageView *oneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon (5)"]];
	[self addSubview:oneImageView];

	[oneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(UNITHEIGHT * 52);
		make.width.mas_equalTo(UNITHEIGHT * 25);
		make.height.mas_equalTo(UNITHEIGHT * 23);
		make.top.mas_equalTo(_headImageView.mas_bottom).with.offset(UNITHEIGHT * 24);
	}];

	self.oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	[_oneButton setBackgroundImage:[UIImage imageNamed:@"icon (5)"] forState:UIControlStateNormal];
	[_oneButton addTarget:self action:@selector(oneButton:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_oneButton];

	[_oneButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(oneImageView);
		make.width.mas_equalTo(UNITHEIGHT * 35);
		make.height.mas_equalTo(UNITHEIGHT * 50);
		make.top.mas_equalTo(_headImageView.mas_bottom).with.offset(UNITHEIGHT * 24);
	}];

	UIImageView *twoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon (6)"]];
	[self addSubview:twoImageView];

	[twoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_oneButton.mas_right).with.offset(UNITHEIGHT * 55);
		make.height.mas_equalTo(UNITHEIGHT * 24.5);
		make.width.mas_equalTo(UNITHEIGHT * 33);
		make.top.mas_equalTo(_oneButton);
	}];

	self.twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	[_twoButton setBackgroundImage:[UIImage imageNamed:@"icon (6)"] forState:UIControlStateNormal];
	[_twoButton addTarget:self action:@selector(twoButton:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_twoButton];

	[_twoButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(twoImageView);
		make.height.mas_equalTo(UNITHEIGHT * 50);
		make.width.mas_equalTo(UNITHEIGHT * 35);
		make.top.mas_equalTo(_oneButton);
	}];

	UIImageView *threeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon (1)"]];
	[self addSubview:threeImageView];

	[threeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_twoButton.mas_right).with.offset(UNITHEIGHT * 55);
		make.top.mas_equalTo(_twoButton);
		make.height.mas_equalTo(UNITHEIGHT * 24);
		make.width.mas_equalTo(UNITHEIGHT * 21);
	}];

	self.threeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	[_threeButton setBackgroundImage:[UIImage imageNamed:@"icon (1)"] forState:UIControlStateNormal];
	[_threeButton addTarget:self action:@selector(threeButton:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_threeButton];

	[_threeButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(threeImageView);
		make.top.mas_equalTo(_twoButton);
		make.height.mas_equalTo(UNITHEIGHT * 50);
		make.width.mas_equalTo(UNITHEIGHT * 35);
	}];

	UIImageView *fourImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon (2)"]];
	[self addSubview:fourImageView];

	[fourImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(UNITHEIGHT * 25);
		make.width.mas_equalTo(UNITHEIGHT * 17.5);
		make.top.mas_equalTo(_threeButton);
		make.left.mas_equalTo(_threeButton.mas_right).with.offset(UNITHEIGHT * 55);
	}];

	self.fourButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	[_fourButton setBackgroundImage:[UIImage imageNamed:@"icon (2)"] forState:UIControlStateNormal];
	[_fourButton addTarget:self action:@selector(fourButton:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_fourButton];

	[_fourButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(UNITHEIGHT * 50);
		make.width.mas_equalTo(UNITHEIGHT * 35);
		make.top.mas_equalTo(_threeButton);
		make.centerX.mas_equalTo(fourImageView);
	}];

	UIView *lineView = [[UIView alloc] init];
	lineView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
	[self addSubview:lineView];

	[lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(UNITHEIGHT * 32);
		make.right.mas_equalTo(-UNITHEIGHT * 32);
		make.height.mas_equalTo(1);
		make.bottom.mas_equalTo(self);
	}];

	self.oneLabel = [[UILabel alloc] init];
	_oneLabel.text = @"待付款";
	_oneLabel.textAlignment = NSTextAlignmentCenter;
	_oneLabel.textColor = [UIColor colorWithHexString:@"#2d2f30"];
	_oneLabel.font = font(12);
	[self addSubview:_oneLabel];

	[_oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(oneImageView);
		make.top.mas_equalTo(oneImageView.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 10);
	}];

	self.twoLabel = [[UILabel alloc] init];
	_twoLabel.textColor = [UIColor colorWithHexString:@"#2d2f30"];
	_twoLabel.textAlignment = NSTextAlignmentCenter;
	_twoLabel.font = font(12);
	_twoLabel.text = @"待收货";
	[self addSubview:_twoLabel];

	[_twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(twoImageView);
		make.top.mas_equalTo(_oneLabel);
		make.height.mas_equalTo(UNITHEIGHT * 10);
	}];

	self.threeLabel = [[UILabel alloc] init];
	_threeLabel.text = @"退款商品";
	_threeLabel.textAlignment = NSTextAlignmentCenter;
	_threeLabel.textColor = [UIColor colorWithHexString:@"#2d2f30"];
	_threeLabel.font = font(12);
	[self addSubview:_threeLabel];

	[_threeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(threeImageView);
		make.top.mas_equalTo(_oneLabel);
		make.height.mas_equalTo(UNITHEIGHT * 10);
	}];

	self.fourLabel = [[UILabel alloc] init];
	_fourLabel.textColor = [UIColor colorWithHexString:@"#2d2f30"];
	_fourLabel.text = @"全部订单";
	_fourLabel.font = font(12);
	_fourLabel.textAlignment = NSTextAlignmentCenter;
	[self addSubview:_fourLabel];

	[_fourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_oneLabel);
		make.centerX.mas_equalTo(fourImageView);
		make.height.mas_equalTo(UNITHEIGHT * 10);
	}];

	_nameChangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
	_nameChangeButton.backgroundColor = [UIColor clearColor];
	[_nameChangeButton addTarget:self action:@selector(nameButton:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_nameChangeButton];

	[_nameChangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_headImageView.mas_right).with.offset(UNITHEIGHT * 25.5);
		make.height.mas_equalTo(UNITHEIGHT * 30);
		make.centerY.mas_equalTo(_headImageView);
		make.right.mas_equalTo(self).with.offset(-UNITHEIGHT * 10);
	}];
}



- (void)nameButton:(UIButton *)button {
	[self.delegate changeName];
}

- (void)oneButton:(UIButton *)button {
	[self.delegate payViewController];
}

- (void)twoButton:(UIButton *)button {
	[self.delegate receivingViewController];
}

- (void)threeButton:(UIButton *)button {
	[self.delegate refundViewController];
}

- (void)fourButton:(UIButton *)button {
	[self.delegate MyOrderViewController];
}

- (void)settingButton:(UIButton *)button {
	[self.delegate mySetting];
}

- (void)takeHeadImageView:(UITapGestureRecognizer *)tap {
	[self.delegate updateImageViewForService];
}

@end
