//
//  ClassifyCollectionCell.m
//  YuCheng
//
//  Created by apple on 16/5/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ClassifyCollectionCell.h"

@implementation ClassifyCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	self.label = [[UILabel alloc] initWithFrame:self.contentView.frame];
	_label.font = font(13);
	_label.textAlignment = NSTextAlignmentCenter;
	[self.contentView addSubview:_label];

}

@end
