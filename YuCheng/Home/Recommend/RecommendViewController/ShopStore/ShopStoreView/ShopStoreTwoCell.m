//
//  ShopStoreTwoCell.m
//  YuCheng
//
//  Created by apple on 16/6/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShopStoreTwoCell.h"

@implementation ShopStoreTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {

	self.titleLabel = [[UILabel alloc] init];
	_titleLabel.text = @"公司简介";
	_titleLabel.font = font(12);
	[self.contentView addSubview:_titleLabel];

	self.infoLabel = [[UILabel alloc] init];
//	_infoLabel.text = @"";
	_infoLabel.textColor = [UIColor blackColor];
	_infoLabel.font = font(12);
	_infoLabel.numberOfLines = 0;
	[self.contentView addSubview:_infoLabel];

//	self.arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	[_arrowButton addTarget:self action:@selector(OpenInfo:) forControlEvents:UIControlEventTouchUpInside];
//	[_arrowButton setBackgroundImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
//	[self.contentView addSubview:_arrowButton];

	self.lineView = [[UIView alloc] init];
	_lineView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
	[self.contentView addSubview:_lineView];

}

- (void)layoutSubviews {
	[super layoutSubviews];
	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 16.5);
		make.top.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 16.5);
		make.height.mas_equalTo(UNITHEIGHT * 10);
	}];

	[_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(UNITHEIGHT * 16.5);
		make.left.mas_equalTo(_titleLabel);
		make.right.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 16.5);
		make.bottom.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 10);
	}];

//	[_arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.bottom.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 10);
//		make.centerX.mas_equalTo(self.contentView);
//		make.height.mas_equalTo(UNITHEIGHT * 10);
//		make.width.mas_equalTo(UNITHEIGHT * 28);
//	}];

	[_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(-UNITHEIGHT * 3);
		make.width.mas_equalTo(UNITHEIGHT * 342);
		make.centerX.mas_equalTo(self.contentView);
		make.height.mas_equalTo(1);
	}];
}

- (void)OpenInfo:(UIButton *)button {
	[self.delegate arrowButtonOpenInfo];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
