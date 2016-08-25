//
//  StarFinishView.m
//  YuCheng
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "StarFinishView.h"

@implementation StarFinishView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithbig:(BOOL)big {
	self = [super init];
	if (self) {
		[self createView:big];
	}
	return self;
}

- (void)createView:(BOOL)big {
	if (big) {
		for (int i = 0; i < 5; i++) {
			UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(UNITHEIGHT * 40 * i, UNITHEIGHT * 5, UNITHEIGHT * 30, UNITHEIGHT * 30)];
			imageView.image = [UIImage imageNamed:@"yc6.24-78"];
			[self addSubview:imageView];
		}
	} else {
		for (int i = 0; i < 5; i++) {
			UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(UNITHEIGHT * 20 * i, UNITHEIGHT * 5, UNITHEIGHT * 15, UNITHEIGHT * 15)];
			imageView.image = [UIImage imageNamed:@"yc6.24-78"];
			[self addSubview:imageView];
		}
	}
}


@end
