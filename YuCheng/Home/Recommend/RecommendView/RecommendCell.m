//
//  RecommendCell.m
//  YuCheng
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RecommendCell.h"

@implementation RecommendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
		self.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
	}
	return self;
}

- (void)createView {
	self.backView = [[UIView alloc] init];
	_backView.backgroundColor = [UIColor whiteColor];
	[self.contentView addSubview:_backView];

	self.picImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
	[self.contentView addSubview:_picImageView];

	self.titleLabel = [[UILabel alloc] init];
//	_titleLabel.text = @"糯冰种晴水飘阳绿";
	_titleLabel.textColor = [UIColor colorWithHexString:@"#221814"];
	_titleLabel.font = font(14);
	[self.contentView addSubview:_titleLabel];

	self.moneyLabel = [[UILabel alloc] init];
	_moneyLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
	_moneyLabel.font = font(14);
//	_moneyLabel.text = @"¥41000";
	[self.contentView addSubview:_moneyLabel];

	self.describeLabel = [[UILabel alloc] init];
	_describeLabel.numberOfLines = 0;
	_describeLabel.font = font(14);
	_describeLabel.textColor = [UIColor colorWithHexString:@"595757"];
	[self.contentView addSubview:_describeLabel];

	self.timeLabel = [[UILabel alloc] init];
//	_timeLabel.text = @"2016-5-10上架";
	_timeLabel.font = font(12);
	[self.contentView addSubview:_timeLabel];

	self.shoppingButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_shoppingButton setBackgroundImage:[UIImage imageNamed:@"address"] forState:UIControlStateNormal];
	[self.contentView addSubview:_shoppingButton];

}

- (void)layoutSubviews {
	[super layoutSubviews];
	[_backView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(UNITHEIGHT * 172);
		make.top.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 5);
		make.left.and.right.mas_equalTo(self.contentView);
	}];

	[_picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView);
		make.height.and.width.mas_equalTo(UNITHEIGHT * 172);
		make.top.mas_equalTo(_backView);
	}];

	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_picImageView.mas_right).with.offset(UNITHEIGHT * 7);
		make.height.mas_equalTo(UNITHEIGHT * 10);
		make.top.mas_equalTo(_backView).with.offset(UNITHEIGHT * 9.5);
	}];

	[_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_titleLabel);
		make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(UNITHEIGHT * 8.5);
		make.height.mas_equalTo(UNITHEIGHT * 10);
	}];

	[_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_moneyLabel);
		make.top.mas_equalTo(_moneyLabel.mas_bottom).with.offset(UNITHEIGHT * 5);
		make.right.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 48.5);
		make.bottom.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 50);
	}];

	[_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_titleLabel);
		make.height.mas_equalTo(UNITHEIGHT * 10);
		make.bottom.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 15);
	}];

	[_shoppingButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.and.width.mas_equalTo(UNITHEIGHT * 36);
		make.right.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 11);
		make.bottom.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 11);
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
