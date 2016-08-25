//
//  UserTableCell.m
//  YuCheng
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UserTableCell.h"

@implementation UserTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	self.lineView = [[UIView alloc] init];
	_lineView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
	[self.contentView addSubview:_lineView];

	self.titleLabel = [[UILabel alloc] init];
	_titleLabel.textColor = [UIColor colorWithHexString:@"#2d2f30"];
	_titleLabel.font = font(12);
	_titleLabel.text = @"123123";
	[self.contentView addSubview:_titleLabel];




}

- (void)layoutSubviews {
	[super layoutSubviews];
	[_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 32);
		make.height.mas_equalTo(1);
		make.right.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT  * 32);
		make.bottom.mas_equalTo(self.contentView).with.offset(-1);
	}];

	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_lineView);
		make.height.mas_equalTo(UNITHEIGHT * 20);
		make.centerY.mas_equalTo(self.contentView);
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
