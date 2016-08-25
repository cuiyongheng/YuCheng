//
//  AddAddressCell.m
//  YuCheng
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AddAddressCell.h"

@implementation AddAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	self.contentTextField = [[UITextField alloc] init];
	_contentTextField.textColor = [UIColor blackColor];
	_contentTextField.placeholder = @"收货人姓名";
	[self.contentView addSubview:_contentTextField];

	[_contentTextField setValue:[UIColor colorWithHexString:@"#b4b5b5"] forKeyPath:@"_placeholderLabel.textColor"];
	[_contentTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];

	self.lineView = [[UIView alloc] init];
	_lineView.backgroundColor = [UIColor blackColor];
	[self.contentView addSubview:_lineView];

}

- (void)layoutSubviews {
	[super layoutSubviews];
	[_contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 25);
		make.right.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 25);
		make.centerY.mas_equalTo(self.contentView);
		make.height.mas_equalTo(UNITHEIGHT * 30);
	}];

	[_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 25);
		make.right.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 25);
		make.height.mas_equalTo(UNITHEIGHT * 1);
		make.bottom.mas_equalTo(self.contentView).with.offset(-1);
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
