//
//  MyEvaluateFinishCell.m
//  YuCheng
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyEvaluateFinishCell.h"

@implementation MyEvaluateFinishCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	self.nameView = [[UIView alloc] init];
	_nameView.backgroundColor = [UIColor colorWithRed:247 / 255.0 green:247 / 255.0 blue:247 / 255.0 alpha:1];
	[self.contentView addSubview:_nameView];

	self.headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ICON-27"]];
	[self.contentView addSubview:_headImageView];

	self.nameLabel = [[UILabel alloc] init];
//	_nameLabel.text = @"店名";
	_nameLabel.textAlignment = NSTextAlignmentCenter;
	_nameLabel.font = font(16);
	[self.contentView addSubview:_nameLabel];

	self.picImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
	[self.contentView addSubview:_picImageView];

	self.moneyView = [[UIView alloc] init];
	_moneyView.backgroundColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1];
	[self.contentView addSubview:_moneyView];

	self.titleLabel = [[UILabel alloc] init];
//	_titleLabel.text = @"糯冰种晴水飘阳绿";
	_titleLabel.font = font(14);
	[self.contentView addSubview:_titleLabel];

	self.moneyLabel = [[UILabel alloc] init];
//	_moneyLabel.text = @"¥41000";
	_moneyLabel.font = font(13);
	[self.contentView addSubview:_moneyLabel];

	self.timeLabel = [[UILabel alloc] init];
	_timeLabel.text = @"成交时间： 2016-6-27";
	_timeLabel.font = font(13);
	[self.contentView addSubview:_timeLabel];

	self.dingdanLabel = [[UILabel alloc] init];
//	_dingdanLabel.text = @"订单号：123456789";
	_dingdanLabel.font = font(13);
	_dingdanLabel.textAlignment = NSTextAlignmentRight;
	[self.contentView addSubview:_dingdanLabel];

	self.lineView = [[UIView alloc] init];
	_lineView.backgroundColor = [UIColor colorWithHexString:@"#a5a5a5"];
	[self.contentView addSubview:_lineView];

//	self.pingjiaButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	_pingjiaButton.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
//	[_pingjiaButton setTitle:@"去评价" forState:UIControlStateNormal];
//	[_pingjiaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//	_pingjiaButton.titleLabel.font = font(14);
//	[_pingjiaButton addTarget:self action:@selector(pingjiaButton:) forControlEvents:UIControlEventTouchUpInside];
//	[self.contentView addSubview:_pingjiaButton];

	self.infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_infoButton setBackgroundImage:[UIImage imageNamed:@"yc6.24-74"] forState:UIControlStateNormal];
	[_infoButton addTarget:self action:@selector(infoButton:) forControlEvents:UIControlEventTouchUpInside];
	[self.contentView addSubview:_infoButton];

	self.finishTimeLabel = [[UILabel alloc] init];
//	_finishTimeLabel.text = @"完成时间：2016.6.22";
	_finishTimeLabel.font = font(13);
	[self.contentView addSubview:_finishTimeLabel];

//	self.pingjiaLabel = [[UILabel alloc] init];
//	_pingjiaLabel.text = @"评价：";
//	_pingjiaLabel.font = font(13);
//	[self.contentView addSubview:_pingjiaLabel];

//	self.starView = [[StarView alloc] initWithbig:0];
//	[self.contentView addSubview:_starView];

}



- (void)layoutSubviews {
	[super layoutSubviews];
	[_nameView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(UNITHEIGHT * 10);
		make.right.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 10);
		make.top.mas_equalTo(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 50);
	}];

	[_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_nameView).with.offset(UNITHEIGHT * 10);
		make.centerY.mas_equalTo(_nameView);
		make.width.height.mas_equalTo(UNITHEIGHT * 25);
	}];

	[_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_headImageView.mas_right).with.offset(UNITHEIGHT * 10);
		make.right.mas_equalTo(_nameView).with.offset(-UNITHEIGHT * 30);
		make.centerY.mas_equalTo(_nameView);
	}];

	[_picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_nameView.mas_bottom);
		make.left.mas_equalTo(_nameView);
		make.width.height.mas_equalTo(UNITHEIGHT * 124);
	}];

	[_moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_picImageView.mas_right);
		make.bottom.top.mas_equalTo(_picImageView);
		make.right.mas_equalTo(_nameView);
	}];

	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_moneyView).with.offset(UNITHEIGHT * 10);
		make.top.mas_equalTo(_moneyView).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

	[_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_titleLabel);
		make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

	[_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_picImageView);
		make.top.mas_equalTo(_picImageView.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

	[_dingdanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(_timeLabel);
		make.right.mas_equalTo(_moneyView);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

	[_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_picImageView);
		make.right.mas_equalTo(_moneyView);
		make.height.mas_equalTo(1);
		make.top.mas_equalTo(_dingdanLabel.mas_bottom).with.offset(UNITHEIGHT * 10);
	}];

//	[_pingjiaButton mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.centerX.mas_equalTo(self.contentView);
//		make.height.mas_equalTo(UNITHEIGHT * 30);
//		make.width.mas_equalTo(UNITHEIGHT * 100);
//		make.top.mas_equalTo(_lineView).with.offset(UNITHEIGHT * 10);
//	}];

	[_infoButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(_nameView).with.offset(-UNITHEIGHT * 10);
		make.centerY.mas_equalTo(_nameView);
		make.width.height.mas_equalTo(UNITHEIGHT * 25);
	}];

	[_finishTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_lineView);
		make.top.mas_equalTo(_lineView).with.offset(UNITHEIGHT * 10);
	}];

	[_starView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(_lineView);
		make.centerY.mas_equalTo(_finishTimeLabel);
		make.height.mas_equalTo(UNITHEIGHT * 30);
		make.width.mas_equalTo(UNITHEIGHT * 100);
	}];

	[_pingjiaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(_starView.mas_left).with.offset(-UNITHEIGHT * 5);
		make.centerY.mas_equalTo(_starView);
	}];
}

- (void)infoButton:(UIButton *)button {
	[self.delegate pushInfoOrede:button.tag];
}

- (void)setModel:(MyEvaluateModel *)model {
	_model = model;
	_nameLabel.text = [NSString stringWithFormat:@"%@", model.shopname];
	[_picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, model.goods_thumb]] placeholderImage:[UIImage imageNamed:@""]];
	_titleLabel.text = [NSString stringWithFormat:@"%@", model.goods_name];
	_moneyLabel.text = [NSString stringWithFormat:@"%@", model.shop_price];
	_dingdanLabel.text = [NSString stringWithFormat:@"订单号：%@", model.goods_sn];
	_timeLabel.text = [NSString stringWithFormat:@"成交时间： %@", model.add_time_str];

	NSString *str = model.shipping_time_end;//时间戳
	NSTimeInterval time = [str doubleValue] + 28800;//因为时差问题要加8小时 == 28800 sec
	NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
	//实例化一个NSDateFormatter对象
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	//设定时间格式,这里可以设置成自己需要的格式
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];

	NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
	_finishTimeLabel.text = [NSString stringWithFormat:@"完成时间：%@", currentDateStr];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
