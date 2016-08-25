//
//  OrderlogisticsHeadView.m
//  YuCheng
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "OrderlogisticsHeadView.h"

@implementation OrderlogisticsHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	UIView *topView = [[UIView alloc] init];
	topView.backgroundColor = [UIColor colorWithRed:207 / 255.0 green:207 / 255.0 blue:207 / 255.0 alpha:1];
	[self addSubview:topView];

	[topView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self).with.offset(UNITHEIGHT * 20);
		make.right.mas_equalTo(self).with.offset(-UNITHEIGHT * 20);
		make.top.mas_equalTo(self);
		make.height.mas_equalTo(1);
	}];

	self.picImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"玉城LOGO-15.jpg"]];
	[self addSubview:_picImageView];

	[_picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(topView);
		make.top.mas_equalTo(topView).with.offset(UNITHEIGHT * 10);
		make.width.height.mas_equalTo(UNITHEIGHT * 100);
	}];

	self.titleLabel = [[UILabel alloc] init];
	_titleLabel.text = @"糯冰种晴水飘阳绿";
	_titleLabel.font = boldFont(14);
	[self addSubview:_titleLabel];

	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_picImageView.mas_right).with.offset(UNITHEIGHT * 10);
		make.top.mas_equalTo(_picImageView);
		make.height.mas_equalTo(UNITHEIGHT * 20);
		make.right.mas_equalTo(topView);
	}];

	self.moneyLabel = [[UILabel alloc] init];
	_moneyLabel.text = @"¥41000";
	_moneyLabel.font = font(14);
	[self addSubview:_moneyLabel];

	[_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.left.mas_equalTo(_titleLabel);
		make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(UNITHEIGHT * 10);
	}];

	self.nameLabel = [[UILabel alloc] init];
	_nameLabel.text = @"店名";
	_nameLabel.font = font(14);
	[self addSubview:_nameLabel];

	[_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.left.mas_equalTo(_titleLabel);
		make.top.mas_equalTo(_moneyLabel.mas_bottom).with.offset(UNITHEIGHT * 10);
	}];

	UIView *bottomView = [[UIView alloc] init];
	bottomView.backgroundColor = [UIColor colorWithRed:207 / 255.0 green:207 / 255.0 blue:207 / 255.0 alpha:1];
	[self addSubview:bottomView];

	[bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.right.left.mas_equalTo(topView);
		make.top.mas_equalTo(_picImageView.mas_bottom).with.offset(UNITHEIGHT * 10);
	}];

	self.startLabel = [[UILabel alloc] init];
	_startLabel.text = @"状态：等待付款";
	_startLabel.font = font(14);
	_startLabel.numberOfLines = 0;
	[self addSubview:_startLabel];

	[_startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(topView);
		make.height.mas_equalTo(UNITHEIGHT * 30);
		make.top.mas_equalTo(bottomView).with.offset(UNITHEIGHT * 10);
		make.right.mas_equalTo(self).with.offset(UNITHEIGHT * 20);
	}];
}

- (void)setModel:(InfoOrderGoodsModel *)model {
	_model = model;

	_titleLabel.text = model.goods_name;
	_moneyLabel.text = model.back_goods_price;
	[_picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, model.goods_thumb]] placeholderImage:[UIImage imageNamed:@""]];
	_nameLabel.text = model.supplier_name;
	_startLabel.text = [NSString stringWithFormat:@"状态：%@" , model.status_back_desc];
	[_startLabel sizeToFit];

}

@end

