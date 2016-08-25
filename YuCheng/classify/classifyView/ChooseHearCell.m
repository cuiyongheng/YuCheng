//
//  ChooseHearCell.m
//  YuCheng
//
//  Created by apple on 16/6/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ChooseHearCell.h"

@implementation ChooseHearCell

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	self.chooselabel = [[UILabel alloc] init];
	_chooselabel.font = font(14);
	[self addSubview:_chooselabel];

	[_chooselabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self).with.offset(UNITHEIGHT * 30);
		make.height.mas_equalTo(UNITHEIGHT * 30);
		make.top.mas_equalTo(self).with.offset(UNITHEIGHT * 10);
		make.width.mas_equalTo(UNITHEIGHT * 80);
	}];
}

@end
