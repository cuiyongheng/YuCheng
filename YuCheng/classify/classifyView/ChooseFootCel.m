
//
//  ChooseFootCel.m
//  YuCheng
//
//  Created by apple on 16/6/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ChooseFootCel.h"

@implementation ChooseFootCel

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	self.tureButton = [UIButton buttonWithType:UIButtonTypeCustom];
	_tureButton.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
	[_tureButton setTitle:@"确认" forState:UIControlStateNormal];
	_tureButton.titleLabel.font = font(14);
	[_tureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[_tureButton addTarget:self action:@selector(tureButton:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_tureButton];

	[_tureButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self);
		make.centerY.mas_equalTo(self);
		make.height.mas_equalTo(UNITHEIGHT * 30);
		make.width.mas_equalTo(UNITHEIGHT * 150);
	}];
}

- (void)tureButton:(UIButton *)button {
	[self.delegate chooseTureButton];
}

@end
