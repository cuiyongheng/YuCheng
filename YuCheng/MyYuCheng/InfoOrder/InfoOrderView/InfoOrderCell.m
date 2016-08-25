//
//  InfoOrderCell.m
//  YuCheng
//
//  Created by apple on 16/7/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "InfoOrderCell.h"

@implementation InfoOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	UIView *oneLineView = [[UIView alloc] init];
	oneLineView.backgroundColor = [UIColor blackColor];
	[self addSubview:oneLineView];

	[oneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self).with.offset(UNITHEIGHT * 10);
		make.right.mas_equalTo(self).with.offset(-UNITHEIGHT * 10);
		make.height.mas_equalTo(1);
		make.top.mas_equalTo(self);
	}];

	self.picImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
	[self addSubview:_picImageView];

	[_picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(oneLineView);
		make.height.width.mas_equalTo(UNITHEIGHT * 100);
		make.top.mas_equalTo(oneLineView).with.offset(UNITHEIGHT * 10);
	}];

	self.titleLabel = [[UILabel alloc] init];
		_titleLabel.text = @"糯冰种晴水飘阳绿";
	_titleLabel.font = font(14);
	[self addSubview:_titleLabel];

	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_picImageView.mas_right).with.offset(UNITHEIGHT * 10);
		make.top.mas_equalTo(_picImageView);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

	self.moneyLabel = [[UILabel alloc] init];
		_moneyLabel.text = @"¥14000";
	_moneyLabel.font = font(14);
	[self addSubview:_moneyLabel];

	[_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_picImageView.mas_right).with.offset(UNITHEIGHT * 10);
		make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(UNITHEIGHT * 5);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

	self.nameLabel = [[UILabel alloc] init];
	_nameLabel.text = @"店名";
	_nameLabel.font = font(14);
	[self addSubview:_nameLabel];

	[_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_picImageView.mas_right).with.offset(UNITHEIGHT * 10);
		make.top.mas_equalTo(_moneyLabel.mas_bottom).with.offset(UNITHEIGHT * 5);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

	self.startLabel = [[UILabel alloc] init];
	_startLabel.text = @"状态：已完成";
	_startLabel.font = font(14);
	[self addSubview:_startLabel];

	[_startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_picImageView.mas_right).with.offset(UNITHEIGHT * 10);
		make.top.mas_equalTo(_nameLabel.mas_bottom).with.offset(UNITHEIGHT * 5);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

	self.refundButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_refundButton setTitle:@"退款" forState:UIControlStateNormal];
	_refundButton.layer.borderWidth = 1;
	[_refundButton addTarget:self action:@selector(refundButton:) forControlEvents:UIControlEventTouchUpInside];
	[_refundButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[self addSubview:_refundButton];

	[_refundButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.mas_equalTo(_picImageView);
		make.right.mas_equalTo(oneLineView);
		make.width.mas_equalTo(UNITHEIGHT * 100);
		make.height.mas_equalTo(UNITHEIGHT * 30);
	}];

	UIView *twoLineView = [[UIView alloc] init];
	twoLineView.backgroundColor = [UIColor blackColor];
	[self addSubview:twoLineView];

	[twoLineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(oneLineView);
		make.height.mas_equalTo(1);
		make.top.mas_equalTo(_picImageView.mas_bottom).with.offset(UNITHEIGHT * 10);
	}];
}

- (void)setGoodsModel:(infoProductModel *)goodsModel {
	_goodsModel = goodsModel;
	[_picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, goodsModel.goods_thumb]] placeholderImage:[UIImage imageNamed:@""]];
	_titleLabel.text = goodsModel.goods_name;
	_moneyLabel.text = [NSString stringWithFormat:@"%@", goodsModel.goods_price];

	if ([goodsModel.is_back isEqual:@0]) {
		_refundButton.hidden = NO;
	} else {
		_refundButton.hidden = YES;
	}

}

- (void)refundButton:(UIButton *)button {
	[self.delegate refundButton:button.tag];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
