
//
//  SettingCell.m
//  YuCheng
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

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

	self.titleLabel = [[UILabel alloc] init];
	_titleLabel.textColor = [UIColor colorWithHexString:@"#2d2f30"];
	_titleLabel.font = font(14);
	[self.contentView addSubview:_titleLabel];

	self.arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yc-68"]];
	[self.contentView addSubview:_arrowImageView];

}

- (void)layoutSubviews {
	[super layoutSubviews];
	[_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.contentView);
		make.height.mas_equalTo(1);
		make.bottom.mas_equalTo(self.contentView);
		make.width.mas_equalTo(UNITHEIGHT * 308);
	}];

	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 46);
		make.centerY.mas_equalTo(self.contentView);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

	[_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 39);
		make.height.mas_equalTo(UNITHEIGHT * 21);
		make.width.mas_equalTo(UNITHEIGHT * 11);
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
