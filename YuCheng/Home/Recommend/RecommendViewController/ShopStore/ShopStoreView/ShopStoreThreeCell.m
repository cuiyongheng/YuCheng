//
//  ShopStoreThreeCell.m
//  YuCheng
//
//  Created by apple on 16/6/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShopStoreThreeCell.h"

@implementation ShopStoreThreeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	self.titleLabel = [[UILabel alloc] init];
	_titleLabel.text = @"资质证书";
	_titleLabel.font = font(12);
	[self.contentView addSubview:_titleLabel];

	self.oneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
	_oneImageView.userInteractionEnabled = YES;
	[self.contentView addSubview:_oneImageView];

	self.twoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
	_twoImageView.userInteractionEnabled = YES;
	[self.contentView addSubview:_twoImageView];

	self.threeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
	_threeImageView.userInteractionEnabled = YES;
	[self.contentView addSubview:_threeImageView];

	self.fourImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
	_fourImageView.userInteractionEnabled = YES;
	[self.contentView addSubview:_fourImageView];

	UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneTap:)];
	[_oneImageView addGestureRecognizer:oneTap];

	UITapGestureRecognizer *twoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneTap:)];
	[_twoImageView addGestureRecognizer:twoTap];

	UITapGestureRecognizer *threeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneTap:)];
	[_threeImageView addGestureRecognizer:threeTap];

	UITapGestureRecognizer *fourTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneTap:)];
	[_fourImageView addGestureRecognizer:fourTap];



	self.lineView = [[UIView alloc] init];
	_lineView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
	[self.contentView addSubview:_lineView];
}

- (void)layoutSubviews {
	[super layoutSubviews];

	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 16.5);
		make.height.mas_equalTo(UNITHEIGHT * 10);
		make.top.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 16.5);
	}];

	[_oneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 27.5);
		make.height.width.mas_equalTo(UNITHEIGHT * 81);
		make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(UNITHEIGHT * 16.5);
	}];

	[_twoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_oneImageView.mas_right).with.offset(UNITHEIGHT * 2.5);
		make.height.width.mas_equalTo(UNITHEIGHT * 81);
		make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(UNITHEIGHT * 16.5);
	}];

	[_threeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_twoImageView.mas_right).with.offset(UNITHEIGHT * 2.5);
		make.height.width.mas_equalTo(UNITHEIGHT * 81);
		make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(UNITHEIGHT * 16.5);
	}];

	[_fourImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_threeImageView.mas_right).with.offset(UNITHEIGHT * 2.5);
		make.height.width.mas_equalTo(UNITHEIGHT * 81);
		make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(UNITHEIGHT * 16.5);
	}];


	[_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(-UNITHEIGHT * 3);
		make.width.mas_equalTo(UNITHEIGHT * 342);
		make.centerX.mas_equalTo(self.contentView);
		make.height.mas_equalTo(1);
	}];
}



- (void)setCreditArr:(NSMutableArray *)creditArr {
	_creditArr = creditArr;
	if (creditArr.count >= 1) {
		[_oneImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, creditArr[0]]] placeholderImage:[UIImage imageNamed:@""]];
	} else {
		_oneImageView.userInteractionEnabled = NO;
		_twoImageView.userInteractionEnabled = NO;
		_threeImageView.userInteractionEnabled = NO;
		_fourImageView.userInteractionEnabled = NO;
	}

	if (creditArr.count >= 2) {
		[_twoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, creditArr[1]]] placeholderImage:[UIImage imageNamed:@""]];
	} else {
		_twoImageView.userInteractionEnabled = NO;
		_threeImageView.userInteractionEnabled = NO;
		_fourImageView.userInteractionEnabled = NO;
	}

	if (creditArr.count >= 3) {
		[_threeImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, creditArr[2]]] placeholderImage:[UIImage imageNamed:@""]];
	} else {
		_threeImageView.userInteractionEnabled = NO;
		_fourImageView.userInteractionEnabled = NO;
	}

	if (creditArr.count >= 4) {
		[_fourImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, creditArr[3]]] placeholderImage:[UIImage imageNamed:@""]];
	} else {
		_fourImageView.userInteractionEnabled = NO;
	}
}

- (void)oneTap:(UITapGestureRecognizer *)tap {
	[self.delegate multiplyingImageView:tap.view.tag];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
