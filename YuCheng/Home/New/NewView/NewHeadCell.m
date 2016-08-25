//
//  NewHeadCell.m
//  YuCheng
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NewHeadCell.h"

@implementation NewHeadCell

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 182.7)];
	_headImageView.image = [UIImage imageNamed:@"玉城LOGO-17.jpg"];
	[self addSubview:_headImageView];
	_headImageView.contentMode =  UIViewContentModeScaleAspectFill;
	_headImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	_headImageView.clipsToBounds = YES;
}

@end
