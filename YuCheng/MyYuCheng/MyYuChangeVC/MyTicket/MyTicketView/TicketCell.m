//
//  TicketCell.m
//  YuCheng
//
//  Created by apple on 16/6/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TicketCell.h"

@implementation TicketCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

- (void)createView {
	self.backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"卡券_03"]];
	[self.contentView addSubview:_backImageView];

	self.timeLabel = [[UILabel alloc] init];
	_timeLabel.font = font(18);
//	_timeLabel.text = @"有效期：2016.6.21-2016.7.30";
	[self.contentView addSubview:_timeLabel];

	self.explainLabel = [[UILabel alloc] init];
//	_explainLabel.text = @"新用户体验卷";
	_explainLabel.font = font(14);
	_explainLabel.textColor = [UIColor whiteColor];
	[self.contentView addSubview:_explainLabel];

	self.moneyLabel = [[UILabel alloc] init];
//	_moneyLabel.text = @"¥100";
	_moneyLabel.font = font(20);
	_moneyLabel.textColor = [UIColor whiteColor];
	[self.contentView addSubview:_moneyLabel];

	self.startImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"time"]];
	_startImageView.hidden = YES;
	[self.contentView addSubview:_startImageView];

	self.titleLabel = [[UILabel alloc] init];
//	_titleLabel.text = @"消费满1000元可用";
	_titleLabel.font = font(14);
	_titleLabel.textColor = [UIColor whiteColor];
	[self.contentView addSubview:_titleLabel];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	[_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(UNITHEIGHT * 20);
		make.top.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 5);
		make.right.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 10);
		make.bottom.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 5);
	}];

	[_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.mas_equalTo(_backImageView).with.offset(-UNITHEIGHT * 20);
		make.centerX.mas_equalTo(self.contentView);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

	[_explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 50);
		make.height.mas_equalTo(UNITHEIGHT * 20);
		make.left.mas_equalTo(_backImageView).with.offset(UNITHEIGHT * 10);
	}];

	[_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(_backImageView).with.offset(-UNITHEIGHT * 20);
		make.top.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 30);
		make.height.mas_equalTo(UNITHEIGHT * 40);
	}];

	[_startImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 80);
		make.top.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 40);
		make.width.height.mas_equalTo(UNITHEIGHT * 60);
	}];

	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.mas_equalTo(_moneyLabel.mas_top);
		make.height.mas_equalTo(UNITHEIGHT * 20);
		make.right.mas_equalTo(_moneyLabel);
	}];
}

- (void)setModel:(TicketModel *)model {
	_model = model;
	_timeLabel.text = [NSString stringWithFormat:@"有效期：%@-%@", model.use_startdate, model.use_enddate];
	_moneyLabel.text = [NSString stringWithFormat:@"%@", model.type_money];
	_explainLabel.text = [NSString stringWithFormat:@"%@", model.type_name];
	_titleLabel.text = [NSString stringWithFormat:@"消费满%@元可用", model.min_goods_amount];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
