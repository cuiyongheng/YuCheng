//
//  ProductOneCell.m
//  YuCheng
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ProductOneCell.h"

@implementation ProductOneCell

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

//	self.lineView = [[UIView alloc] init];
//	_lineView.backgroundColor = [UIColor blackColor];
//	[self.contentView addSubview:_lineView];

	self.titleLabel = [[UILabel alloc] init];
//	_titleLabel.text = @"糯冰种清水飘阳绿";
	_titleLabel.font = font(13);
	_titleLabel.textColor = [UIColor colorWithHexString:@"#221814"];
	[self.contentView addSubview:_titleLabel];

	self.moneyLabel = [[UILabel alloc] init];
//	_moneyLabel.text = @"¥41000";
	_moneyLabel.font = font(16);
	_moneyLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
	[self.contentView addSubview:_moneyLabel];

	self.navigationView = [[RIghtNavigationView alloc] initWithFrame:CGRectMake(WIDTH - UNITHEIGHT * 92 - UNITHEIGHT * 37 - UNITHEIGHT * 75, UNITHEIGHT * 7, UNITHEIGHT * 65 + UNITHEIGHT * 37 + UNITHEIGHT * 75 + UNITHEIGHT * 37.5, UNITHEIGHT * 27.5)];
	[self.contentView addSubview:_navigationView];

//	self.scrollView = [[UIScrollView alloc] init];
//	[self.contentView addSubview:_scrollView];
//	_scrollView.contentSize = CGSizeMake((UNITHEIGHT * 134 + UNITHEIGHT * 12.5) * 5 - UNITHEIGHT * 12.5, 0);
//	_scrollView.showsHorizontalScrollIndicator = NO;
//
//	for (NSInteger i = 0; i < 5; i++) {
//		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((UNITHEIGHT * 134 + UNITHEIGHT * 12.5) * i, 0, UNITHEIGHT * 134, UNITHEIGHT * 134)];
//		imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"/Users/apple/Desktop/YuCheng/YuCheng/image/玉城LOGO-%ld.jpg", (long)(i + 15)]];
//		[_scrollView addSubview:imageView];
//	}

//	self.marketLabel = [[UILabel alloc] init];
//	_marketLabel.text = @"支付定金";
//	_marketLabel.font = font(13);
//	_marketLabel.textColor = [UIColor colorWithHexString:@"#9f9fa0"];
//	[self.contentView addSubview:_marketLabel];
//
//	self.marketMoneyLabel = [[UILabel alloc] init];
//	_marketMoneyLabel.textColor = [UIColor redColor];
//	_marketMoneyLabel.text = @"¥1500";
//	_marketMoneyLabel.font = font(16);
//	[self.contentView addSubview:_marketMoneyLabel];
//
//	self.orderMoneyLabel = [[UILabel alloc] init];
//	_orderMoneyLabel.text = @"支付定金：¥1500";
//	_orderMoneyLabel.font = font(9);
//	_orderMoneyLabel.textColor = [UIColor colorWithHexString:@"#9f9fa0"];
//	[self.contentView addSubview:_orderMoneyLabel];

}

- (void)layoutSubviews {
	[super layoutSubviews];

	[_backView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 10);
		make.right.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 10);
		make.top.mas_equalTo(self.contentView);
		make.bottom.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 6);
	}];

//	[_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.centerX.mas_equalTo(self.contentView);
//		make.height.mas_equalTo(3);
//		make.width.mas_equalTo(UNITHEIGHT * 53);
//		make.top.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 11.5);
//	}];

	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.contentView);
		make.top.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 50.5);
		make.height.mas_equalTo(UNITHEIGHT * 15);
	}];

	[_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(UNITHEIGHT * 17);
		make.height.mas_equalTo(_titleLabel);
		make.centerX.mas_equalTo(self.contentView);
	}];

//	[_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.mas_equalTo(self.backView).with.offset(UNITHEIGHT * 12.5);
//		make.top.mas_equalTo(_moneyLabel.mas_bottom).with.offset(UNITHEIGHT * 48);
//		make.height.mas_equalTo(UNITHEIGHT * 134);
//		make.right.mas_equalTo(self.backView).with.offset(-UNITHEIGHT * 12.5);
//	}];

//	[_marketLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.top.mas_equalTo(_moneyLabel.mas_bottom).with.offset(UNITHEIGHT * 15);
//		make.centerX.mas_equalTo(self.contentView);
//	}];
//
//	[_marketMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.top.mas_equalTo(_marketLabel.mas_bottom).with.offset(UNITHEIGHT * 10);
//		make.centerX.mas_equalTo(self.contentView);
//	}];


//
//	[_orderMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.mas_equalTo(self.contentView.mas_centerX).with.offset(-UNITHEIGHT * 30);
//		make.top.mas_equalTo(_marketMoneyLabel.mas_bottom).with.offset(0);
//	}];

}

- (void)setModel:(ProductInfoModel *)model {
	_model = model;
//	_marketMoneyLabel.text = [NSString stringWithFormat:@"%@", model.deposit];
	_titleLabel.text = [NSString stringWithFormat:@"%@", model.goods_name];
	_moneyLabel.text = [NSString stringWithFormat:@"%@", model.shop_price];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
