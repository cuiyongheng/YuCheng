//
//  RegisterAccountCell.m
//  YuCheng
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RegisterAccountCell.h"

@implementation RegisterAccountCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
		self.backgroundColor = [UIColor blackColor];
	}

	return self;
}

- (void)createView {
	self.headImageView = [[UIImageView alloc] init];
	[self addSubview:_headImageView];

	self.contentTextField = [[UITextField alloc] init];
	_contentTextField.textColor = [UIColor whiteColor];
	[self addSubview:_contentTextField];

	self.lineView = [[UIView alloc] init];
	_lineView.backgroundColor = [UIColor whiteColor];
	[self addSubview:_lineView];
}

- (void)layoutSubviews {
	[super layoutSubviews];

	[_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 70.75);
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 70.75);
		make.height.mas_equalTo(1);
		make.bottom.mas_equalTo(self).with.offset(-1);
	}];

	[_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_lineView);
		make.width.height.mas_equalTo(UNITHEIGHT * 17.6);
		make.centerY.mas_equalTo(self.contentView);
	}];

	[_contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_headImageView.mas_right).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 20);
		make.centerY.mas_equalTo(self.contentView);
		make.right.mas_equalTo(_lineView);
	}];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
