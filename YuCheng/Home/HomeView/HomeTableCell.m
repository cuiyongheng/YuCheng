//
//  HomeTableCell.m
//  YuCheng
//
//  Created by apple on 16/5/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HomeTableCell.h"

@implementation HomeTableCell

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
	[self.contentView addSubview:_bigImageView];

//	self.backView = [[UIView alloc] init];
//	_backView.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
//	[self.contentView addSubview:_backView];
//
//	self.leftImageView = [[UIImageView alloc] init];
//	_leftImageView.image = [UIImage imageNamed:@""];
//	_leftImageView.userInteractionEnabled = YES;
//	_leftImageView.layer.cornerRadius = UNITHEIGHT * 2;
//	[self.contentView addSubview:_leftImageView];
//
//	UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTap:)];
//	[_leftImageView addGestureRecognizer:leftTap];
//
//	self.middleImageView = [[UIImageView alloc] init];
//	_middleImageView.image = [UIImage imageNamed:@""];
//	_middleImageView.userInteractionEnabled = YES;
//	_middleImageView.layer.cornerRadius = UNITHEIGHT * 2;
//	[self.contentView addSubview:_middleImageView];
//
//	UITapGestureRecognizer *middleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(middleTap:)];
//	[_middleImageView addGestureRecognizer:middleTap];
//
//	self.rightImageView = [[UIImageView alloc] init];
//	_rightImageView.image = [UIImage imageNamed:@""];
//	_rightImageView.userInteractionEnabled = YES;
//	_rightImageView.layer.cornerRadius = UNITHEIGHT * 2;
//	[self.contentView addSubview:_rightImageView];
//
//	UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightTap:)];
//	[_rightImageView addGestureRecognizer:rightTap];

//	self.leftLabel = [[UILabel alloc] init];
////	_leftLabel.text = @"糯冰种清水飘阳绿";
//	_leftLabel.textAlignment = NSTextAlignmentCenter;
//	_leftLabel.font = font(14);
//	[self.contentView addSubview:_leftLabel];
//
//	self.leftMoneyLabel = [[UILabel alloc] init];
//	_leftMoneyLabel.textAlignment = NSTextAlignmentCenter;
////	_leftMoneyLabel.text = @"¥41000";
//	_leftMoneyLabel.font = font(14);
//	_leftMoneyLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
//	[self.contentView addSubview:_leftMoneyLabel];
//
//	self.middleLabel = [[UILabel alloc] init];
////	_middleLabel.text = @"糯冰种清水飘阳绿";
//	_middleLabel.textAlignment = NSTextAlignmentCenter;
//	_middleLabel.font = font(14);
//	[self.contentView addSubview:_middleLabel];
//
//	self.middleMoneyLabel = [[UILabel alloc] init];
//	_middleMoneyLabel.textAlignment = NSTextAlignmentCenter;
////	_middleMoneyLabel.text = @"¥41000";
//	_middleMoneyLabel.font = font(14);
//	_middleMoneyLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
//	[self.contentView addSubview:_middleMoneyLabel];
//
//	self.rightLabel = [[UILabel alloc] init];
////	_rightLabel.text = @"糯冰种清水飘阳绿";
//	_rightLabel.textAlignment = NSTextAlignmentCenter;
//	_rightLabel.font = font(14);
//	[self.contentView addSubview:_rightLabel];
//
//	self.rightMoneyLabel = [[UILabel alloc] init];
//	_rightMoneyLabel.textAlignment = NSTextAlignmentCenter;
////	_rightMoneyLabel.text = @"¥41000";
//	_rightMoneyLabel.font = font(14);
//	_rightMoneyLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
//	[self.contentView addSubview:_rightMoneyLabel];

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

	_hiddenView = [[UIView alloc] init];
	_hiddenView.backgroundColor = [UIColor blackColor];
	_hiddenView.alpha = 0.3;
	_hiddenView.userInteractionEnabled = NO;
	[self.contentView addSubview:_hiddenView];

	_classifyLabel = [[UILabel alloc] init];
	_classifyLabel.font = font(16);
	_classifyLabel.text = @"分类";
	_classifyLabel.textColor = [UIColor whiteColor];
	[self.contentView addSubview:_classifyLabel];

	self.scroll = [[UIScrollView alloc] init];
	_scroll.backgroundColor = [UIColor whiteColor];
	_scroll.showsHorizontalScrollIndicator = NO;
	[self.contentView addSubview:_scroll];

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

//	[_backView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.and.right.mas_equalTo(self.contentView);
////		make.top.mas_equalTo(_bigImageView.mas_bottom);
//		make.bottom.mas_equalTo(self.contentView);
//		make.height.mas_equalTo(UNITHEIGHT * 194);
//	}];
//
	[_bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.and.right.mas_equalTo(self.contentView);
		make.height.mas_equalTo(UNITHEIGHT * 187.7);
		make.top.mas_equalTo(self.contentView);
//		make.bottom.mas_equalTo(_backView.mas_top);
	}];
//
//	[_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.mas_equalTo(UNITHEIGHT * 5);
//		make.top.mas_equalTo(_bigImageView.mas_bottom).with.offset(UNITHEIGHT * 13.8);
//		make.height.and.width.mas_equalTo(UNITHEIGHT * 118);
//	}];
//
//	[_middleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.mas_equalTo(_leftImageView.mas_right).with.offset(UNITHEIGHT * 5);
//		make.top.and.height.and.width.mas_equalTo(_leftImageView);
//	}];
//
//	[_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.mas_equalTo(_middleImageView.mas_right).with.offset(UNITHEIGHT * 5);
//		make.top.and.height.and.width.mas_equalTo(_leftImageView);
//	}];
//
//	[_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.centerX.mas_equalTo(_leftImageView);
//		make.top.mas_equalTo(_leftImageView.mas_bottom).with.offset(UNITHEIGHT * 10);
//		make.height.mas_equalTo(UNITHEIGHT * 20.0f);
//		make.width.mas_equalTo(UNITHEIGHT * 120);
//	}];
//
//	[_leftMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.centerX.mas_equalTo(_leftImageView);
//		make.top.mas_equalTo(_leftLabel.mas_bottom).with.offset(UNITHEIGHT * 5);
//		make.height.mas_equalTo(UNITHEIGHT * 20);
//	}];
//
//	[_middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.centerX.mas_equalTo(_middleImageView);
//		make.top.mas_equalTo(_middleImageView.mas_bottom).with.offset(UNITHEIGHT * 10);
//		make.height.mas_equalTo(UNITHEIGHT * 20.0f);
//		make.width.mas_equalTo(UNITHEIGHT * 120);
//	}];
//
//	[_middleMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.centerX.mas_equalTo(_middleImageView);
//		make.top.mas_equalTo(_middleLabel.mas_bottom).with.offset(UNITHEIGHT * 5);
//		make.height.mas_equalTo(UNITHEIGHT * 20);
//	}];
//
//	[_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.centerX.mas_equalTo(_rightImageView);
//		make.top.mas_equalTo(_rightImageView.mas_bottom).with.offset(UNITHEIGHT * 10);
//		make.height.mas_equalTo(UNITHEIGHT * 20.0f);
//		make.width.mas_equalTo(UNITHEIGHT * 120);
//	}];
//
//	[_rightMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.centerX.mas_equalTo(_rightImageView);
//		make.top.mas_equalTo(_rightLabel.mas_bottom).with.offset(UNITHEIGHT * 5);
//		make.height.mas_equalTo(UNITHEIGHT * 20);
//	}];

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

	[_hiddenView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.bottom.mas_equalTo(_bigImageView);
	}];

	[_classifyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.centerY.mas_equalTo(_bigImageView);
		make.height.mas_equalTo(UNITHEIGHT * 20);
		make.width.mas_lessThanOrEqualTo(_bigImageView);
	}];

	[_scroll mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_bigImageView.mas_bottom);
		make.bottom.mas_equalTo(self.contentView);
		make.left.right.mas_equalTo(self.contentView);
	}];

}

//- (void)leftTap:(UITapGestureRecognizer *)tap {
//	[self.delegate leftGoods:tap.view.tag];
//}
//
//- (void)rightTap:(UITapGestureRecognizer *)tap {
//	[self.delegate rightGoods:tap.view.tag];
//}
//
//- (void)middleTap:(UITapGestureRecognizer *)tap {
//	[self.delegate middleGoods:tap.view.tag];
//}

- (void)setModel:(HomeModel *)model {
	_model = model;
//	_titleLabel.text = model.supplier_name;
//
//	[_bigImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, model.shop_index_img]] placeholderImage:[UIImage imageNamed:@""]];
//	[_bigImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
//	_bigImageView.contentMode =  UIViewContentModeScaleAspectFill;
//	_bigImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//	_bigImageView.clipsToBounds = YES;
//
//	if (model.goods_list.count > 1) {
//		[_leftImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, model.goods_list[0][@"original_img"]]] placeholderImage:[UIImage imageNamed:@""]];
//		_leftLabel.text = [NSString stringWithFormat:@"%@", model.goods_list[0][@"goods_name"]];
//		_leftMoneyLabel.text = [NSString stringWithFormat:@"%@", model.goods_list[0][@"shop_price"]];
//	}
//	if (model.goods_list.count > 2) {
//		[_middleImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, model.goods_list[1][@"original_img"]]] placeholderImage:[UIImage imageNamed:@""]];
//		_middleLabel.text = [NSString stringWithFormat:@"%@", model.goods_list[1][@"goods_name"]];
//		_middleMoneyLabel.text = [NSString stringWithFormat:@"%@", model.goods_list[1][@"shop_price"]];
//	}
//	if (model.goods_list.count > 3) {
//		[_rightImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, model.goods_list[2][@"original_img"]]] placeholderImage:[UIImage imageNamed:@""]];
//		_rightLabel.text = [NSString stringWithFormat:@"%@", model.goods_list[2][@"goods_name"]];
//		_rightMoneyLabel.text = [NSString stringWithFormat:@"%@", model.goods_list[2][@"shop_price"]];
//	}

	_classifyLabel.text = [NSString stringWithFormat:@"%@", model.cat_name];
	[_bigImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, model.img]] placeholderImage:[UIImage imageNamed:@""]];

	_scroll.contentSize = CGSizeMake(UNITWIDTH * 158.4 * model.goods.count, 0);
	for (NSInteger i = 0; i < model.goods.count; i++) {
		UIImageView *imageView = [[UIImageView alloc] init];
		imageView.frame = CGRectMake(UNITWIDTH * 158.4 * i, UNITHEIGHT * 13.5, UNITWIDTH * 152, UNITWIDTH * 160.4);
		[imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, model.goods[i][@"goods_thumb"]]] placeholderImage:[UIImage imageNamed:@""]];
		imageView.userInteractionEnabled = YES;
		imageView.tag = 12000 + i;
		[_scroll addSubview:imageView];

		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
		[imageView addGestureRecognizer:tap];
	}
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
	[self.delegate tapClassifyImageView:tap.view.tag - 12000 scrollTag:_scroll.tag];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
