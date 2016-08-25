//
//  NewCollectionCell.m
//  YuCheng
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NewCollectionCell.h"

@implementation NewCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self createView];
		self.backgroundColor = [UIColor whiteColor];
	}
	return self;
}

- (void)createView {
	self.picImageView = [[UIImageView alloc] init];
	_picImageView.image = [UIImage imageNamed:@"玉城LOGO-19.jpg"];
	[self.contentView addSubview:_picImageView];
	

	[_picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.and.left.and.right.mas_equalTo(self.contentView);
		make.height.mas_equalTo(UNITHEIGHT * 172.4);
	}];

	self.titleLabel = [[UILabel alloc] init];
//	_titleLabel.text = @"糯冰种晴水飘阳绿";
	_titleLabel.font = font(14);
	[self.contentView addSubview:_titleLabel];

	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_picImageView.mas_bottom).with.offset(UNITHEIGHT * 5);
		make.height.mas_equalTo(UNITHEIGHT * 20);
		make.width.mas_equalTo(UNITHEIGHT * 130);
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 5);
	}];

	self.moneyLabel = [[UILabel alloc] init];
//	_moneyLabel.text = @"¥41000";
	_moneyLabel.font = font(14);
	[self.contentView addSubview:_moneyLabel];

	[_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_titleLabel);
		make.top.mas_equalTo(_titleLabel.mas_bottom);
		make.height.mas_equalTo(_titleLabel);
	}];

	self.timeLabel = [[UILabel alloc] init];
//	_timeLabel.text = @"2016-5-10上架";
	_timeLabel.font = font(12);
	[self.contentView addSubview:_timeLabel];

	[_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_titleLabel);
		make.top.mas_equalTo(_moneyLabel.mas_bottom);
		make.height.mas_equalTo(_titleLabel);
	}];

	self.shopButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.contentView addSubview:_shopButton];
	[_shopButton addTarget:self action:@selector(shopAction:) forControlEvents:UIControlEventTouchUpInside];
	_shopButton.layer.cornerRadius = UNITHEIGHT * 34 / 2;
	_shopButton.layer.masksToBounds = YES;
	[_shopButton setBackgroundImage:[UIImage imageNamed:@"address"] forState:UIControlStateNormal];

	[_shopButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(self.contentView.mas_right).with.offset(-UNITHEIGHT * 10);
		make.height.and.width.mas_equalTo(UNITHEIGHT * 34.0f);
		make.top.mas_equalTo(_picImageView.mas_bottom).with.offset(UNITHEIGHT * 10);
	}];

	self.addLabel = [[UILabel alloc] init];
	_addLabel.font = font(12);
//	_addLabel.text = @"瑞丽";
	[self.contentView addSubview:_addLabel];

	[_addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_shopButton);
		make.height.mas_equalTo(UNITHEIGHT * 20);
		make.top.mas_equalTo(_shopButton.mas_bottom);
	}];

	self.selloutLabel = [[UILabel alloc] init];
	_selloutLabel.textColor = [UIColor whiteColor];
	_selloutLabel.text = @"已售";
	_selloutLabel.font = font(30);
	_selloutLabel.hidden = YES;
	[self addSubview:_selloutLabel];

	[_selloutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.centerY.mas_equalTo(_picImageView);
	}];
}

- (void)setModel:(ProductModel *)model {
	_model = model;
	if (model.original_img) {
		[_picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, model.original_img]] placeholderImage:[UIImage imageNamed:@""]];
	} else {
		[_picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, model.goods_thumb]] placeholderImage:[UIImage imageNamed:@""]];
	}

	_titleLabel.text = [NSString stringWithFormat:@"%@", model.goods_name];
	_moneyLabel.text = [NSString stringWithFormat:@"%@", model.shop_price];
	_timeLabel.text = [NSString stringWithFormat:@"%@", model.shop_name];
	_addLabel.text = [NSString stringWithFormat:@"%@", model.shop_city];
}

- (void)shopAction:(UIButton *)button {
//	[self.delegate pushShopping:button];
}

@end
