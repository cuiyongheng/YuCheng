//
//  ProductOrderCell.m
//  YuCheng
//
//  Created by apple on 16/6/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ProductOrderCell.h"

@implementation ProductOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

- (void)createView {
	self.backView = [[UIView alloc] init];
	_backView.backgroundColor = [UIColor whiteColor];
	_backView.alpha = 0.98;
	[self.contentView addSubview:_backView];

//	self.alertLabel = [[UILabel alloc] init];
////	_alertLabel.text = @"支付定金后商家将在30分钟内与您联系配合您完成交易";
//	_alertLabel.textColor = [UIColor colorWithHexString:@"#717071"];
//	_alertLabel.font = font(12);
//	[self.contentView addSubview:_alertLabel];
//
//	self.dutyLabel = [[UILabel alloc] init];
//	_dutyLabel.textColor = [UIColor colorWithHexString:@"#717071"];
//	_dutyLabel.font = font(12);
////	_dutyLabel.text = @"商家承担关税，运费";
//	[self.contentView addSubview:_dutyLabel];

	self.topLine = [[UIView alloc] init];
	_topLine.backgroundColor = [UIColor colorWithHexString:@"#717071"];
	[self.contentView addSubview:_topLine];

	self.bottonLine = [[UIView alloc] init];
	_bottonLine.backgroundColor = [UIColor colorWithHexString:@"#717071"];
	[self.contentView addSubview:_bottonLine];

	// 对号
	for (NSInteger i = 0; i < 4; i++) {
		UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yc-100"]];
		imageView.frame = CGRectMake(UNITHEIGHT * 41.5 + (UNITHEIGHT * 72.875 * i), UNITHEIGHT * 24, UNITHEIGHT * 13, UNITHEIGHT * 13);
		[self.contentView addSubview:imageView];
	}

	self.oneLabel = [[UILabel alloc] init];
	_oneLabel.text = @"正品保证";
	_oneLabel.font = font(12);
	_oneLabel.textColor = [UIColor colorWithHexString:@"#717071"];
	[self.contentView addSubview:_oneLabel];

	self.twoLabel = [[UILabel alloc] init];
	_twoLabel.textColor = [UIColor colorWithHexString:@"#717071"];
	_twoLabel.text = @"权威鉴定";
	_twoLabel.font = font(12);
	[self.contentView addSubview:_twoLabel];

	self.threeLabel = [[UILabel alloc] init];
	_threeLabel.textColor = [UIColor colorWithHexString:@"#717071"];
	_threeLabel.text = @"源头供货";
	_threeLabel.font = font(12);
	[self.contentView addSubview:_threeLabel];

	self.fourLabel = [[UILabel alloc] init];
	_fourLabel.textColor = [UIColor colorWithHexString:@"#717071"];
	_fourLabel.text = @"3天退换";
	_fourLabel.font = font(12);
	[self.contentView addSubview:_fourLabel];

	self.explainOneLabel = [[UILabel alloc] init];
	_explainOneLabel.text = @"本商品支持顺丰代收货款";
	_explainOneLabel.font = font(9);
	_explainOneLabel.textColor = [UIColor colorWithHexString:@"#717071"];
	[self.contentView addSubview:_explainOneLabel];

	self.explainTwoLabel = [[UILabel alloc] init];
	_explainTwoLabel.text = @"本商品支持三天无理由退换货";
	_explainTwoLabel.font = font(9);
	_explainTwoLabel.textColor = [UIColor colorWithHexString:@"#717071"];
	[self.contentView addSubview:_explainTwoLabel];

	for (NSInteger i = 0; i < 2; i++) {
		UIView *roundView = [[UIView alloc] init];
		roundView.backgroundColor = [UIColor blackColor];
		roundView.layer.masksToBounds = YES;
		roundView.layer.cornerRadius = UNITHEIGHT * 2;
		[self.contentView addSubview:roundView];
		roundView.frame = CGRectMake(UNITHEIGHT * 43.5, UNITHEIGHT * 66 + (UNITHEIGHT * 21 * i), UNITHEIGHT * 4, UNITHEIGHT * 4);
	}
}

- (void)layoutSubviews {
	[super layoutSubviews];

	[_backView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 10);
		make.right.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 10);
		make.top.mas_equalTo(self.contentView);
		make.bottom.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 6);
	}];

//	[_alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.mas_equalTo(_backView).with.offset(UNITHEIGHT * 30);
//		make.top.mas_equalTo(_backView).with.offset(UNITHEIGHT * 18);
//		make.right.mas_equalTo(_backView.mas_right).with.offset(-UNITHEIGHT * 30);
//		make.height.mas_equalTo(UNITHEIGHT * 10);
//	}];
//
//	[_dutyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.right.mas_equalTo(_alertLabel);
//		make.top.mas_equalTo(_alertLabel.mas_bottom).with.offset(UNITHEIGHT * 14);
//		make.height.mas_equalTo(UNITHEIGHT * 10);
//	}];

	[self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.contentView);
		make.height.mas_equalTo(UNITHEIGHT * 0.3);
		make.width.mas_equalTo(UNITHEIGHT * 291.5);
		make.top.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 10);
	}];

	[self.bottonLine mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.height.mas_equalTo(_topLine);
		make.top.mas_equalTo(_topLine).with.offset(UNITHEIGHT * 41);
		make.centerX.mas_equalTo(self.contentView);
	}];

	[_oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_bottonLine).with.offset(UNITHEIGHT * 15);
		make.top.mas_equalTo(_topLine).with.offset(UNITHEIGHT * 14);
	}];

	[_twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_oneLabel).with.offset(UNITHEIGHT * 72.875);
		make.top.mas_equalTo(_oneLabel);
	}];

	[_threeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_twoLabel).with.offset(UNITHEIGHT * 72.875);
		make.top.mas_equalTo(_oneLabel);
	}];

	[_fourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_threeLabel).with.offset(UNITHEIGHT * 72.875);
		make.top.mas_equalTo(_oneLabel);
	}];

	[_explainOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_backView).with.offset(UNITHEIGHT * 40);
		make.top.mas_equalTo(_bottonLine).with.offset(UNITHEIGHT * 11);
	}];

	[_explainTwoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_backView).with.offset(UNITHEIGHT * 40);
		make.top.mas_equalTo(_explainOneLabel.mas_bottom).with.offset(UNITHEIGHT * 11);
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
