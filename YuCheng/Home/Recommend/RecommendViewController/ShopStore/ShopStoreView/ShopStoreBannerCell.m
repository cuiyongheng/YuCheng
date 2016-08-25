//
//  ShopStoreBannerCell.m
//  YuCheng
//
//  Created by apple on 16/6/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShopStoreBannerCell.h"

@implementation ShopStoreBannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	self.bannerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
	_bannerImageView.layer.borderColor = [UIColor blackColor].CGColor;
	_bannerImageView.layer.borderWidth = 1;
	[self.contentView addSubview:_bannerImageView];

//	self.serverButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	_serverButton.layer.masksToBounds = YES;
//	_serverButton.layer.cornerRadius = UNITHEIGHT * 17.0f;
//	[_serverButton setBackgroundImage:[UIImage imageNamed:@"yc-20"] forState:UIControlStateNormal];
//	[self.contentView addSubview:_serverButton];

	self.numberValueLabel = [[UILabel alloc] init];
//	_numberValueLabel.text = @"86";
	_numberValueLabel.font = font(20);
	_numberValueLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
	_numberValueLabel.textAlignment = NSTextAlignmentCenter;
	[self.contentView addSubview:_numberValueLabel];

	self.numberLabel = [[UILabel alloc] init];
	_numberLabel.text = @"商品数量";
	_numberLabel.font = font(11.5);
	_numberLabel.textAlignment = NSTextAlignmentCenter;
	_numberLabel.textColor = [UIColor blackColor];
	[self.contentView addSubview:_numberLabel];

	self.sellOutValueLabel = [[UILabel alloc] init];
//	_sellOutValueLabel.text = @"33";
	_sellOutValueLabel.font = font(20);
	_sellOutValueLabel.textAlignment = NSTextAlignmentCenter;
	_sellOutValueLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
	[self.contentView addSubview:_sellOutValueLabel];

	self.sellOutLabel = [[UILabel alloc] init];
	_sellOutLabel.text = @"已卖商品";
	_sellOutLabel.textAlignment = NSTextAlignmentCenter;
	_sellOutLabel.textColor = [UIColor blackColor];
	_sellOutLabel.font = font(11.5);
	[self.contentView addSubview:_sellOutLabel];

	self.goodLabel = [[UILabel alloc] init];
	_goodLabel.font = font(20);
	_goodLabel.textColor = [UIColor colorWithHexString:@"792b34"];
	_goodLabel.textAlignment = NSTextAlignmentCenter;
//	_goodLabel.text = @"99.1%";
	[self.contentView addSubview:_goodLabel];

	self.goodValueLabel = [[UILabel alloc] init];
	_goodValueLabel.font = font(11.5);
	_goodValueLabel.textColor = [UIColor blackColor];
	_goodValueLabel.textAlignment = NSTextAlignmentCenter;
	_goodValueLabel.text = @"好评率";
	[self.contentView addSubview:_goodValueLabel];

	self.lineView = [[UIView alloc] init];
	_lineView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
	[self.contentView addSubview:_lineView];

}

- (void)layoutSubviews {
	[super layoutSubviews];

	[_bannerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.mas_equalTo(self.contentView);
		make.height.mas_equalTo(UNITHEIGHT * 375);
	}];

//	[_serverButton mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.right.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 23);
//		make.bottom.mas_equalTo(_bannerImageView.mas_bottom).with.offset(-UNITHEIGHT * 23);
//		make.height.width.mas_equalTo(UNITHEIGHT * 34);
//	}];

	[_numberValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 68);
		make.top.mas_equalTo(_bannerImageView.mas_bottom).with.offset(UNITHEIGHT * 29);
	}];

	[_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_numberValueLabel);
		make.top.mas_equalTo(_numberValueLabel.mas_bottom).with.offset(UNITHEIGHT * 14);
	}];

	[_sellOutValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.contentView);
		make.top.mas_equalTo(_numberValueLabel);
	}];

	[_sellOutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.contentView);
		make.top.mas_equalTo(_sellOutValueLabel.mas_bottom).with.offset(UNITHEIGHT * 14);
	}];

	[_goodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 62);
		make.top.mas_equalTo(_bannerImageView.mas_bottom).with.offset(UNITHEIGHT * 29);
	}];

	[_goodValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_goodLabel);
		make.top.mas_equalTo(_goodLabel.mas_bottom).with.offset(UNITHEIGHT * 14);
	}];

	[_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(-UNITHEIGHT * 3);
		make.width.mas_equalTo(UNITHEIGHT * 342);
		make.centerX.mas_equalTo(self.contentView);
		make.height.mas_equalTo(1);
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
