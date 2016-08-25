//
//  LimitRushCell.m
//  YuCheng
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LimitRushCell.h"

@implementation LimitRushCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	self.picImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
	[self.contentView addSubview:_picImageView];

	self.whiteBackView = [[UIView alloc] init];
	_whiteBackView.backgroundColor = [UIColor whiteColor];
	[self.contentView addSubview:_whiteBackView];

	self.blackBackView = [[UIView alloc] init];
	_blackBackView.backgroundColor = [UIColor blackColor];
	_blackBackView.alpha = 0.8;
	[self.contentView addSubview:_blackBackView];

	self.statsLabel = [[UILabel alloc] init];
	_statsLabel.font = font(14);
	_statsLabel.text = @"剩余";
	[self.contentView addSubview:_statsLabel];

//	self.timeLabel = [[UILabel alloc] init];
//	_timeLabel.font = font(12);
//	_timeLabel.text = @"24:00:00";
//	[self.contentView addSubview:_timeLabel];

	self.justStartView = [[JustStartTimeView alloc] init];
	[self.contentView addSubview:_justStartView];

	self.otherJustStartView = [[JustStartTimeView alloc] init];
	[self.contentView addSubview:_otherJustStartView];

//	self.discountLabel = [[UILabel alloc] init];
////	_discountLabel.text = @"打折";
//	_discountLabel.font = font(16);
//	_discountLabel.layer.cornerRadius = UNITHEIGHT * 34 / 2;
//	_discountLabel.backgroundColor = [UIColor whiteColor];
//	_discountLabel.layer.masksToBounds = YES;
//	_discountLabel.textAlignment = NSTextAlignmentCenter;
//	[self.contentView addSubview:_discountLabel];

	_moneyLabel = [[UILabel alloc] init];
//	_moneyLabel.text = @"¥41000";
	_moneyLabel.textColor = [UIColor whiteColor];
	_moneyLabel.textAlignment = NSTextAlignmentRight;
	_moneyLabel.font = font(21);
	[self.contentView addSubview:_moneyLabel];

	self.priceLabel = [[UILabel alloc] init];
//	_priceLabel.text = @"原价¥10000";
	_priceLabel.textAlignment = NSTextAlignmentRight;
	_priceLabel.textColor = [UIColor colorWithHexString:@"#b4b5b5"];
	_priceLabel.font = font(14);
	[self.contentView addSubview:_priceLabel];

}

- (void)layoutSubviews {
	[super layoutSubviews];
	[_picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.mas_equalTo(self.contentView);
		make.bottom.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 10);
	}];

	[_whiteBackView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView);
		make.width.mas_equalTo(UNITHEIGHT * 170);
		make.height.mas_equalTo(UNITHEIGHT * 18);
		make.top.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 87);
	}];

	[_blackBackView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView);
		make.width.mas_equalTo(UNITHEIGHT * 170);
		make.height.mas_equalTo(UNITHEIGHT * 60);
		make.top.mas_equalTo(_whiteBackView.mas_bottom);
	}];

	[_statsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 14);
		make.height.mas_equalTo(UNITHEIGHT * 10);
		make.centerY.mas_equalTo(_whiteBackView);
	}];

	[_justStartView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_statsLabel.mas_right).with.offset(UNITHEIGHT * 30);
		make.height.mas_equalTo(UNITHEIGHT * 18);
		make.centerY.mas_equalTo(_whiteBackView);
		make.right.mas_equalTo(_whiteBackView).with.offset(-UNITHEIGHT * 30);
	}];

	[_otherJustStartView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_statsLabel.mas_right).with.offset(UNITHEIGHT * 30);
		make.height.mas_equalTo(UNITHEIGHT * 18);
		make.centerY.mas_equalTo(_whiteBackView);
		make.right.mas_equalTo(_whiteBackView).with.offset(-UNITHEIGHT * 30);
	}];

//	[_discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 14);
//		make.top.mas_equalTo(_whiteBackView.mas_bottom).with.offset(UNITHEIGHT * 8.5);
//		make.height.width.mas_equalTo(UNITHEIGHT * 34);
//	}];

	[_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_whiteBackView.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.centerX.mas_equalTo(_blackBackView);
		make.height.mas_equalTo(UNITHEIGHT * 20);
		make.left.mas_equalTo(_blackBackView);
		make.right.mas_equalTo(_blackBackView).with.offset(-UNITHEIGHT * 10);
	}];

	[_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_moneyLabel.mas_bottom).with.offset(UNITHEIGHT * 5);
		make.centerX.mas_equalTo(_blackBackView);
		make.left.mas_equalTo(_blackBackView);
		make.right.mas_equalTo(_blackBackView).with.offset(-UNITHEIGHT * 10);
	}];

}

- (void)setModel:(LimitModel *)model {
	_model = model;
	[_picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, model.goods_thumb]] placeholderImage:[UIImage imageNamed:@""]];
	[_picImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
	_picImageView.contentMode =  UIViewContentModeScaleAspectFill;
	_picImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	_picImageView.clipsToBounds = YES;

//	_discountLabel.text = [NSString stringWithFormat:@"%@", model.discount];
	_priceLabel.text = [NSString stringWithFormat:@"原价 ¥%@", model.shop_price];
	_moneyLabel.text = [NSString stringWithFormat:@"¥%@", model.promote_price];

//	[_justStartView countDownViewWithEndData:[NSDate dateWithTimeIntervalSinceNow:model.remain_second]];
//	NSLog(@"%ld", (long)model.remain_second);
//	_statsLabel.text = [NSString stringWithFormat:@"剩余%@", _justStartView.dayLabel.text];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
