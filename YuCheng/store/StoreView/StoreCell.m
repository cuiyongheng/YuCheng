//
//  StoreCell.m
//  YuCheng
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "StoreCell.h"

@implementation StoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	self.picImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"玉城LOGO-15.jpg"]];
	[self.contentView addSubview:_picImageView];

	self.nameLabel = [[UILabel alloc] init];
	_nameLabel.font = boldFont(11.5);
	_nameLabel.numberOfLines = 0;
	_nameLabel.textAlignment = NSTextAlignmentCenter;
	_nameLabel.text = @"荣宸珠宝";
	[self.contentView addSubview:_nameLabel];

	self.englishLabel = [[UILabel alloc] init];
	_englishLabel.text = @"RONGCHENG";
	_englishLabel.font = boldFont(8);
	_englishLabel.numberOfLines = 0;
	_englishLabel.textAlignment = NSTextAlignmentCenter;
	[self.contentView addSubview:_englishLabel];

	self.salesLabel = [[UILabel alloc] init];
	_salesLabel.text = @"销量：111111";
	_salesLabel.textAlignment = NSTextAlignmentCenter;
	_salesLabel.font = font(8);
	[self.contentView addSubview:_salesLabel];

	self.goodLabel = [[UILabel alloc] init];
	_goodLabel.textAlignment = NSTextAlignmentCenter;
	_goodLabel.text = @"好评率：100%";
	_goodLabel.font = font(8);
	[self.contentView addSubview:_goodLabel];

	self.lineView = [[UILabel alloc] init];
	_lineView.backgroundColor = [UIColor blackColor];
	[self.contentView addSubview:_lineView];

	self.comeStoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.contentView addSubview:_comeStoreButton];
	_comeStoreButton.backgroundColor = [UIColor whiteColor];
	[_comeStoreButton setTitle:@"进入店铺" forState:UIControlStateNormal];
	_comeStoreButton.titleLabel.font = font(12);
	[_comeStoreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	_comeStoreButton.backgroundColor = [UIColor whiteColor];
	_comeStoreButton.layer.borderWidth = 1;
	[_comeStoreButton addTarget:self action:@selector(comeStoreButton:) forControlEvents:UIControlEventTouchUpInside];


	self.oneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"玉城LOGO-16.jpg"]];
	[self.contentView addSubview:_oneImageView];

	self.twoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"玉城LOGO-17.jpg"]];
	[self.contentView addSubview:_twoImageView];

	self.threeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"玉城LOGO-18.jpg"]];
	[self.contentView addSubview:_threeImageView];

	self.oneTitleLabel = [[UILabel alloc] init];
	_oneTitleLabel.text = @"糯冰种晴水飘阳绿";
	_oneTitleLabel.font = font(9);
	[self.contentView addSubview:_oneTitleLabel];

	self.oneMoneyLabel = [[UILabel alloc] init];
	_oneMoneyLabel.text = @"¥41000";
	_oneMoneyLabel.font = font(8);
	[self.contentView addSubview:_oneMoneyLabel];

	self.twoTitleLael = [[UILabel alloc] init];
	_twoTitleLael.text = @"糯冰种晴水飘阳绿";
	_twoTitleLael.font = font(9);
	[self.contentView addSubview:_twoTitleLael];

	self.twoMoneyLabel = [[UILabel alloc] init];
	_twoMoneyLabel.text = @"¥41000";
	_twoMoneyLabel.font = font(8);
	[self.contentView addSubview:_twoMoneyLabel];

	self.threeTitleLabel = [[UILabel alloc] init];
	_threeTitleLabel.text = @"糯冰种晴水飘阳绿";
	_threeTitleLabel.font = font(9);
	[self.contentView addSubview:_threeTitleLabel];

	self.threeMoneyLabel = [[UILabel alloc] init];
	_threeMoneyLabel.text = @"¥41000";
	_threeMoneyLabel.font = font(8);
	[self.contentView addSubview:_threeMoneyLabel];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	[_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(UNITHEIGHT * 14.5);
		make.centerX.mas_equalTo(_picImageView);
		make.height.mas_equalTo(UNITHEIGHT * 30);
		make.width.mas_equalTo(UNITHEIGHT * 84);
	}];

	[_englishLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_picImageView);
		make.height.mas_equalTo(UNITHEIGHT * 10);
		make.top.mas_equalTo(_nameLabel.mas_bottom);
		make.width.mas_equalTo(UNITHEIGHT * 84);
	}];

	[_picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 25);
		make.top.mas_equalTo(_englishLabel.mas_bottom).with.offset(UNITHEIGHT * 5);
		make.width.and.height.mas_equalTo(UNITHEIGHT * 54);
	}];

	[_salesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_englishLabel);
		make.top.mas_equalTo(_picImageView.mas_bottom).with.offset(UNITHEIGHT * 5);
		make.height.mas_equalTo(UNITHEIGHT * 10);
		make.width.mas_equalTo(_englishLabel);
	}];

	[_goodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_nameLabel);
		make.height.mas_equalTo(UNITHEIGHT * 10);
		make.width.mas_equalTo(_englishLabel);
		make.top.mas_equalTo(_salesLabel.mas_bottom);
	}];

	[_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 5);
		make.right.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 5);
		make.height.mas_equalTo(1);
		make.bottom.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 40);
	}];

	[_comeStoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_lineView).with.offset(UNITHEIGHT * 9);
		make.width.mas_equalTo(UNITHEIGHT * 150);
		make.height.mas_equalTo(UNITHEIGHT * 22);
		make.centerX.mas_equalTo(self.contentView);
	}];

	[_oneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_picImageView.mas_right).with.offset(UNITHEIGHT * 32.5);
		make.height.and.width.mas_equalTo(UNITHEIGHT * 82);
		make.top.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 37);
	}];

	[_twoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_oneImageView.mas_right).with.offset(UNITHEIGHT * 3);
		make.height.and.width.and.top.mas_equalTo(_oneImageView);
	}];

	[_threeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_twoImageView.mas_right).with.offset(UNITHEIGHT * 3);
		make.height.and.width.and.top.mas_equalTo(_oneImageView);
	}];

	[_oneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_oneImageView.mas_bottom).with.offset(UNITHEIGHT * 2);
		make.width.mas_equalTo(_oneImageView);
		make.height.mas_equalTo(15);
		make.left.mas_equalTo(_oneImageView);
	}];

	[_oneMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.and.width.mas_equalTo(_oneTitleLabel);
		make.height.mas_equalTo(UNITHEIGHT * 10);
		make.top.mas_equalTo(_oneTitleLabel.mas_bottom);
	}];

	[_twoTitleLael mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_twoImageView.mas_bottom).with.offset(UNITHEIGHT * 2);
		make.width.mas_equalTo(_twoImageView);
		make.height.mas_equalTo(15);
		make.left.mas_equalTo(_twoImageView);
	}];

	[_twoMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.and.width.mas_equalTo(_twoTitleLael);
		make.height.mas_equalTo(UNITHEIGHT * 10);
		make.top.mas_equalTo(_twoTitleLael.mas_bottom);
	}];

	[_threeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_threeImageView.mas_bottom).with.offset(UNITHEIGHT * 2);
		make.width.mas_equalTo(_threeImageView);
		make.height.mas_equalTo(15);
		make.left.mas_equalTo(_threeImageView);
	}];

	[_threeMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.and.width.mas_equalTo(_threeTitleLabel);
		make.height.mas_equalTo(UNITHEIGHT * 10);
		make.top.mas_equalTo(_threeTitleLabel.mas_bottom);
	}];
}

- (void)comeStoreButton:(UIButton *)button {
	[self.delegate comeinStore:button.tag];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
