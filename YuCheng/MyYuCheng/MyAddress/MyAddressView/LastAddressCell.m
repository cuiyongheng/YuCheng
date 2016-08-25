//
//  LastAddressCell.m
//  YuCheng
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LastAddressCell.h"

@implementation LastAddressCell

{
	BOOL isDefault;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
		isDefault = 0;
	}
	return self;
}

- (void)createView {
	self.lineView = [[UIView alloc] init];
	_lineView.backgroundColor = [UIColor blackColor];
	[self.contentView addSubview:_lineView];

	self.explainLabel = [[UILabel alloc] init];
	_explainLabel.text = @"设为默认地址\n注：每次下单时会默认使用该地址";
	_explainLabel.textColor = [UIColor colorWithHexString:@"#b4b5b5"];
	_explainLabel.font = font(13);
	_explainLabel.numberOfLines = 0;
	[self.contentView addSubview:_explainLabel];

	self.defaultButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_defaultButton setBackgroundImage:[UIImage imageNamed:@"button1"] forState:UIControlStateNormal];
	[_defaultButton addTarget:self action:@selector(defaultButton:) forControlEvents:UIControlEventTouchUpInside];
	[self.contentView addSubview:_defaultButton];
}

- (void)layoutSubviews {
	[super layoutSubviews];

	[_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 25);
		make.right.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 25);
		make.height.mas_equalTo(UNITHEIGHT * 1);
		make.bottom.mas_equalTo(self.contentView).with.offset(-1);
	}];

	[_explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_lineView);
		make.centerY.mas_equalTo(self.contentView);
		make.height.mas_equalTo(UNITHEIGHT * 40);
	}];

	[_defaultButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.mas_equalTo(UNITHEIGHT * 51);
		make.height.mas_equalTo(UNITHEIGHT * 28);
		make.centerY.mas_equalTo(self.contentView);
		make.right.mas_equalTo(_lineView);
	}];
}

- (void)defaultButton:(UIButton *)button {
	if (isDefault) {
		[button setBackgroundImage:[UIImage imageNamed:@"button1"] forState:UIControlStateNormal];
	} else {
		[button setBackgroundImage:[UIImage imageNamed:@"button2"] forState:UIControlStateNormal];
	}
	isDefault = !isDefault;
	[self.delegate lastIsDefault:isDefault];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
