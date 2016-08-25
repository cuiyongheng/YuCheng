//
//  RegisterView.m
//  YuCheng
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RegisterView.h"

@implementation RegisterView

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
	}
	return self;
}

- (void)createView {
//	self.headImageView = [[UIImageView alloc] init];
//	[self addSubview:_headImageView];
//
//	[_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.mas_equalTo(self);
//		make.width.height.mas_equalTo(UNITHEIGHT * 17.6);
//		make.centerY.mas_equalTo(self).with.offset(UNITHEIGHT * 10);
//	}];

	self.contentTextField = [[UITextField alloc] init];
	_contentTextField.textColor = [UIColor whiteColor];
	[self addSubview:_contentTextField];

	[_contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 50);
		make.bottom.mas_equalTo(self);
		make.right.mas_equalTo(self).with.offset(UNITHEIGHT * -10);
	}];

	UIView *lineView = [[UIView alloc] init];
	lineView.backgroundColor = [UIColor whiteColor];
	lineView.alpha = 0.5;
	[self addSubview:lineView];

	[lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self).with.offset(UNITHEIGHT * 10);
		make.right.mas_equalTo(self).with.offset(UNITHEIGHT * -10);
		make.height.mas_equalTo(1);
		make.bottom.mas_equalTo(self).with.offset(-1);
	}];
}

@end
