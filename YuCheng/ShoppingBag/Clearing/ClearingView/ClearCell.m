//
//  ClearCell.m
//  YuCheng
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ClearCell.h"

@implementation ClearCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
		self.backgroundColor = [UIColor colorWithHexString:@"e5e6e6"];
	}
	return self;
}

- (void)createView {
	self.backView = [[UIView alloc] init];
	_backView.backgroundColor = [UIColor whiteColor];
	[self.contentView addSubview:_backView];

	self.picImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
	[self.contentView addSubview:_picImageView];

	self.nameLabel = [[UILabel alloc] init];
//	_nameLabel.text = @"糯冰种晴水飘阳绿";
	_nameLabel.font = font(11);
	_nameLabel.textColor = [UIColor colorWithHexString:@"#221814"];
	[self.contentView addSubview:_nameLabel];

	self.moneyLabel = [[UILabel alloc] init];
	_moneyLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
	_moneyLabel.font = font(11);
//	_moneyLabel.text = @"¥30000";
	[self.contentView addSubview:_moneyLabel];

	self.orderLabel = [[UILabel alloc] init];
//	_orderLabel.text = @"订单号：1234567890";
	_orderLabel.textColor = [UIColor colorWithHexString:@"#717071"];
	_orderLabel.font = font(11);
	[self.contentView addSubview:_orderLabel];

//	self.beforeLabel = [[UILabel alloc] init];
//	_beforeLabel.text = @"支付定金";
//	_beforeLabel.font = font(14);
//	[self.contentView addSubview:_beforeLabel];
//
//	self.beforeMoneyLabel = [[UILabel alloc] init];
////	_beforeMoneyLabel.text = @"¥10000";
//	_beforeMoneyLabel.font = font(14);
//	_beforeMoneyLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
//	[self.contentView addSubview:_beforeMoneyLabel];

	self.delegateView = [[UIView alloc] init];
	_delegateView.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
	_delegateView.hidden = YES;
	[self.contentView addSubview:_delegateView];

	self.delegateButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_delegateButton setBackgroundImage:[UIImage imageNamed:@"ICON-28"] forState:UIControlStateNormal];
	[self.delegateView addSubview:_delegateButton];


}

- (void)layoutSubviews {
	[super layoutSubviews];
	[_picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.and.centerX.mas_equalTo(self.contentView);
		make.width.and.height.mas_equalTo(UNITHEIGHT * 84.5);
	}];

	[_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 17);
		make.top.mas_equalTo(_backView).with.offset(UNITHEIGHT * 7);
		make.height.mas_equalTo(UNITHEIGHT * 40);
		make.right.mas_equalTo(_picImageView.mas_left).with.offset(-UNITHEIGHT * 10);
	}];

	[_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_nameLabel.mas_bottom).with.offset(UNITHEIGHT * 8.5);
		make.height.mas_equalTo(UNITHEIGHT * 10);
		make.left.mas_equalTo(_nameLabel);
	}];

	[_backView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.and.right.mas_equalTo(self.contentView);
		make.top.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 3.5);
		make.bottom.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 3.5);
	}];

	[_orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.mas_equalTo(_backView).with.offset(-UNITHEIGHT * 7);
		make.left.mas_equalTo(_backView).with.offset(UNITHEIGHT * 17);
		make.height.mas_equalTo(UNITHEIGHT * 10);
	}];

//	[_beforeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.bottom.mas_equalTo(self.contentView.mas_centerY);
//		make.centerX.mas_equalTo(self.contentView.mas_centerX).with.multipliedBy(1.6);
//	}];
//
//	[_beforeMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.centerX.mas_equalTo(_beforeLabel);
//		make.top.mas_equalTo(_beforeLabel.mas_bottom).with.offset(UNITHEIGHT * 5);
//	}];

	[_delegateView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView.mas_right);
		make.bottom.mas_equalTo(_backView);
		make.width.mas_equalTo(UNITHEIGHT * 69);
		make.top.mas_equalTo(_backView);
	}];

	[_delegateButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.and.centerY.mas_equalTo(_delegateView);
		make.height.and.width.mas_equalTo(UNITHEIGHT * 24);
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
