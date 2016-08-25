//
//  LoginPassCell.m
//  YuCheng
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LoginPassCell.h"

@implementation LoginPassCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	self.lineView = [[UIView alloc] init];
	_lineView.backgroundColor = [UIColor colorWithHexString:@"#b4b5b5"];
	[self.contentView addSubview:_lineView];

	self.inputTextField = [[UITextField alloc] init];
	[_inputTextField setValue:[UIColor colorWithHexString:@"#2d2f30"] forKeyPath:@"_placeholderLabel.textColor"];
	[_inputTextField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
	[self.contentView addSubview:_inputTextField];

}

- (void)layoutSubviews {
	[super layoutSubviews];
	[_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.contentView);
		make.height.mas_equalTo(1);
		make.width.mas_equalTo(UNITHEIGHT * 308);
		make.bottom.mas_equalTo(self.contentView);
	}];

	[_inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 46);
		make.centerY.mas_equalTo(self.contentView);
		make.height.mas_equalTo(UNITHEIGHT * 20);
		make.right.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 46);
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
