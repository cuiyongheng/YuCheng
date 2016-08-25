//
//  RecommendNewCell.m
//  YuCheng
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RecommendNewCell.h"

@implementation RecommendNewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
//	self.titleLabel = [[UILabel alloc] init];
//	_titleLabel.text = @"荣宸珠宝\nRONGCHENG";
//	_titleLabel.numberOfLines = 0;
//	_titleLabel.textAlignment = NSTextAlignmentCenter;
//	_titleLabel.font = boldFont(11.44);
//	[self.contentView addSubview:_titleLabel];

	self.bigImageView = [[UIImageView alloc] init];
	_bigImageView.image = [UIImage imageNamed:@""];
	_bigImageView.layer.cornerRadius = UNITHEIGHT * 2;
	_bigImageView.layer.masksToBounds = YES;
	[self.contentView addSubview:_bigImageView];

	self.brandImageView = [[UIImageView alloc] init];
	_brandImageView.image = [UIImage imageNamed:@""];
	_brandImageView.layer.cornerRadius = UNITHEIGHT * 2;
	_brandImageView.layer.masksToBounds = YES;
	[self.contentView addSubview:_brandImageView];

//	self.backView = [[UIView alloc] init];
//	_backView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
//	[self.contentView addSubview:_backView];

	self.intervalView = [[UIView alloc] init];
	_intervalView.backgroundColor = [UIColor colorWithHexString:@"eeefef"];
	[self.contentView addSubview:_intervalView];

	self.leftImageView = [[UIImageView alloc] init];
	_leftImageView.image = [UIImage imageNamed:@""];
	_leftImageView.layer.cornerRadius = UNITHEIGHT * 2;
	_leftImageView.layer.masksToBounds = YES;
	[self.contentView addSubview:_leftImageView];

	self.middleImageView = [[UIImageView alloc] init];
	_middleImageView.image = [UIImage imageNamed:@""];
	_middleImageView.layer.cornerRadius = UNITHEIGHT * 2;
	_middleImageView.layer.masksToBounds = YES;
	[self.contentView addSubview:_middleImageView];

	self.rightImageView = [[UIImageView alloc] init];
	_rightImageView.image = [UIImage imageNamed:@""];
	_rightImageView.layer.cornerRadius = UNITHEIGHT * 2;
	_rightImageView.layer.masksToBounds = YES;
	[self.contentView addSubview:_rightImageView];

	self.leftLabel = [[UILabel alloc] init];
//	_leftLabel.text = @"糯冰种清水飘阳绿";
	_leftLabel.textAlignment = NSTextAlignmentCenter;
	_leftLabel.font = font(13);
	[self.contentView addSubview:_leftLabel];

	self.leftMoneyLabel = [[UILabel alloc] init];
	_leftMoneyLabel.textAlignment = NSTextAlignmentCenter;
//	_leftMoneyLabel.text = @"¥41000";
	_leftMoneyLabel.font = font(11);
	_leftMoneyLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
	[self.contentView addSubview:_leftMoneyLabel];

	self.middleLabel = [[UILabel alloc] init];
//	_middleLabel.text = @"糯冰种清水飘阳绿";
	_middleLabel.textAlignment = NSTextAlignmentCenter;
	_middleLabel.font = font(13);
	[self.contentView addSubview:_middleLabel];

	self.middleMoneyLabel = [[UILabel alloc] init];
	_middleMoneyLabel.textAlignment = NSTextAlignmentCenter;
//	_middleMoneyLabel.text = @"¥41000";
	_middleMoneyLabel.font = font(11);
	_middleMoneyLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
	[self.contentView addSubview:_middleMoneyLabel];

	self.rightLabel = [[UILabel alloc] init];
//	_rightLabel.text = @"糯冰种清水飘阳绿";
	_rightLabel.textAlignment = NSTextAlignmentCenter;
	_rightLabel.font = font(13);
	[self.contentView addSubview:_rightLabel];

	self.rightMoneyLabel = [[UILabel alloc] init];
	_rightMoneyLabel.textAlignment = NSTextAlignmentCenter;
//	_rightMoneyLabel.text = @"¥41000";
	_rightMoneyLabel.font = font(11);
	_rightMoneyLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
	[self.contentView addSubview:_rightMoneyLabel];

	//	self.lineView = [[UIView alloc] init];
	//	_lineView.backgroundColor = [UIColor colorWithHexString:@"#717071"];
	//	[self.contentView addSubview:_lineView];
	//
	//	self.comeButton = [UIButton buttonWithType:UIButtonTypeCustom];
	//	[_comeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	//	[_comeButton setTitle:@"进入店铺" forState:UIControlStateNormal];
	//	_comeButton.layer.borderWidth = 1;
	//	[_comeButton addTarget:self action:@selector(comeAction:) forControlEvents:UIControlEventTouchUpInside];
	//	_comeButton.titleLabel.font = font(12);
	//	_comeButton.layer.borderColor = [UIColor blackColor].CGColor;
	//	[self.contentView addSubview:_comeButton];



}

//- (void)comeAction:(UIButton *)button {
//	[self.delegate comeinStore:button.tag];
//}

- (void)layoutSubviews {
	[super layoutSubviews];

//	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.centerX.mas_equalTo(self.contentView);
//		make.height.mas_equalTo(UNITHEIGHT * 48.55);
//		make.top.mas_equalTo(self.contentView);
//	}];

	[_brandImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_bigImageView);
		make.height.width.mas_equalTo(UNITHEIGHT * 48);
		make.left.mas_equalTo(_bigImageView).with.offset(UNITHEIGHT * 21.5);
	}];

//	[_backView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.and.right.mas_equalTo(self.contentView);
//		make.top.mas_equalTo(_bigImageView.mas_bottom);
//		make.bottom.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 25);
//	}];

	[_intervalView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(self.contentView);
		make.bottom.mas_equalTo(self.contentView);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

	[_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(UNITHEIGHT * 5);
		make.top.mas_equalTo(self.contentView.mas_bottom).with.offset(-UNITHEIGHT * 210);
		make.height.and.width.mas_equalTo(UNITHEIGHT * 120);
	}];

	[_bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 7);
		make.right.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 7);
		//		make.height.mas_equalTo(UNITHEIGHT * 246.5);
		make.top.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 7);
		make.bottom.mas_equalTo(_leftImageView.mas_top).with.offset(-UNITHEIGHT * 7);
	}];

	[_middleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_leftImageView.mas_right).with.offset(UNITHEIGHT * 5);
		make.top.and.height.and.width.mas_equalTo(_leftImageView);
	}];

	[_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_middleImageView.mas_right).with.offset(UNITHEIGHT * 5);
		make.top.and.height.and.mas_equalTo(_leftImageView);
		make.right.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 5);
	}];

	[_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_leftImageView);
		make.top.mas_equalTo(_leftImageView.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 10.0f);
		make.width.mas_equalTo(UNITHEIGHT * 120);
	}];

	[_leftMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_leftImageView);
		make.top.mas_equalTo(_leftLabel.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 10);
	}];

	[_middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_middleImageView);
		make.top.mas_equalTo(_middleImageView.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 10.0f);
		make.width.mas_equalTo(UNITHEIGHT * 120);
	}];

	[_middleMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_middleImageView);
		make.top.mas_equalTo(_middleLabel.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 10);
	}];

	[_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_rightImageView);
		make.top.mas_equalTo(_rightImageView.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 10.0f);
		make.width.mas_equalTo(UNITHEIGHT * 120);
	}];

	[_rightMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_rightImageView);
		make.top.mas_equalTo(_rightLabel.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 10);
	}];

	//	[_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
	//		make.top.mas_equalTo(_leftMoneyLabel.mas_bottom).with.offset(UNITHEIGHT * 13.8f);
	//		make.left.mas_equalTo(UNITHEIGHT * 5);
	//		make.right.mas_equalTo(-UNITHEIGHT * 5);
	//		make.height.mas_equalTo(1);
	//	}];
	//
	//	[_comeButton mas_makeConstraints:^(MASConstraintMaker *make) {
	//		make.centerX.mas_equalTo(self.contentView);
	//		make.height.mas_equalTo(UNITHEIGHT * 19);
	//		make.width.mas_equalTo(UNITHEIGHT * 111.6);
	//		make.top.mas_equalTo(_lineView.mas_bottom).with.offset(UNITHEIGHT * 8.77f);
	//	}];
}

- (void)setModel:(RecommendModel *)model {
	_model = model;
	[_brandImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, model.shop_logo]] placeholderImage:[UIImage imageNamed:@""]];
	_brandImageView.contentMode =  UIViewContentModeScaleAspectFill;
	_brandImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	_brandImageView.clipsToBounds = YES;

	[_bigImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, model.shop_index_img]] placeholderImage:[UIImage imageNamed:@""]];
	[_bigImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
	_bigImageView.contentMode =  UIViewContentModeScaleAspectFill;
	_bigImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	_bigImageView.clipsToBounds = YES;

	if (model.goods_list.count > 1) {
		[_leftImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, model.goods_list[1][@"original_img"]]] placeholderImage:[UIImage imageNamed:@""]];
		_leftLabel.text = [NSString stringWithFormat:@"%@", model.goods_list[1][@"goods_name"]];
		_leftMoneyLabel.text = [NSString stringWithFormat:@"%@", model.goods_list[1][@"shop_price"]];
	}

	if (model.goods_list.count > 2) {
		[_middleImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, model.goods_list[2][@"original_img"]]] placeholderImage:[UIImage imageNamed:@""]];
		_middleLabel.text = [NSString stringWithFormat:@"%@", model.goods_list[2][@"goods_name"]];
		_middleMoneyLabel.text = [NSString stringWithFormat:@"%@", model.goods_list[2][@"shop_price"]];
	}

	if (model.goods_list.count > 3) {
		[_rightImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, model.goods_list[3][@"original_img"]]] placeholderImage:[UIImage imageNamed:@""]];
		_rightLabel.text = [NSString stringWithFormat:@"%@", model.goods_list[3][@"goods_name"]];
		_rightMoneyLabel.text = [NSString stringWithFormat:@"%@", model.goods_list[3][@"shop_price"]];
	}
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
