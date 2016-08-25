//
//  ShoppingCell.m
//  YuCheng
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShoppingCell.h"

@implementation ShoppingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	self.backView = [[UIView alloc] init];
	_backView.backgroundColor = [UIColor clearColor];
	[self.contentView addSubview:_backView];

	self.picImageView = [[UIImageView alloc] init];
	[_backView addSubview:_picImageView];
	_picImageView.image = [UIImage imageNamed:@"玉城LOGO-16.jpg"];

//	self.nameBackView = [[UIView alloc] init];
//	_nameBackView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
//	[_backView addSubview:_nameBackView];

	self.moneyView = [[UIView alloc] init];
	_moneyView.backgroundColor = [UIColor colorWithHexString:@"#e5e6e6"];
	[_backView addSubview:_moneyView];

//	self.brandImageView = [[UIImageView alloc] init];
//	_brandImageView.image = [UIImage imageNamed:@"ICON-27"];
//	[_backView addSubview:_brandImageView];

//	self.nameLabel = [[UILabel alloc] init];
//	_nameLabel.text = @"店名";
//	_nameLabel.numberOfLines = 0;
//	_nameLabel.font = font(11);
//	_nameLabel.textColor = [UIColor colorWithHexString:@"#717071"];
//	_nameLabel.textAlignment = NSTextAlignmentCenter;
//	[_backView addSubview:_nameLabel];

	self.titleLabel = [[UILabel alloc] init];
	_titleLabel.text = @"冰种紫罗兰飘花";
	_titleLabel.font = font(13);
	_titleLabel.numberOfLines = 0;
	_titleLabel.textColor = [UIColor colorWithHexString:@"#221814"];
	[_backView addSubview:_titleLabel];

	self.moneyLabel = [[UILabel alloc] init];
	_moneyLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
	_moneyLabel.font = font(16);
	_moneyLabel.text = @"¥30000";
	[_backView addSubview:_moneyLabel];

	// 删除
	self.delegateView = [[UIView alloc] init];
	_delegateView.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
	_delegateView.hidden = YES;
	[self.contentView addSubview:_delegateView];

	self.delegateButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_delegateButton setBackgroundImage:[UIImage imageNamed:@"ICON-28"] forState:UIControlStateNormal];
	[self.delegateView addSubview:_delegateButton];

	// 选择
	self.chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_chooseButton addTarget:self action:@selector(choosebutton:) forControlEvents:UIControlEventTouchUpInside];
	[self.backView addSubview:_chooseButton];
	_chooseButton.backgroundColor = [UIColor redColor];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	[_backView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.bottom.mas_equalTo(self.contentView);
	}];

	[_picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(UNITHEIGHT * 10);
		make.height.and.width.mas_equalTo(UNITHEIGHT * 124);
		make.top.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 10);
	}];

//	[_nameBackView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.mas_equalTo(_picImageView.mas_right);
//		make.top.mas_equalTo(_picImageView);
//		make.width.mas_equalTo(UNITHEIGHT * 201);
//		make.height.mas_equalTo(UNITHEIGHT * 39.5);
//	}];

	[_moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_picImageView.mas_right);
		make.top.mas_equalTo(_picImageView);
		make.width.mas_equalTo(UNITHEIGHT * 201);
		make.bottom.mas_equalTo(_picImageView);
	}];

//	[_brandImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.width.mas_equalTo(UNITHEIGHT * 26.5);
//		make.height.mas_equalTo(UNITHEIGHT * 24);
//		make.centerY.mas_equalTo(_nameBackView);
//		make.left.mas_equalTo(_nameBackView).with.offset(UNITHEIGHT * 10);
//	}];

//	[_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.mas_equalTo(_brandImageView.mas_right).with.offset(UNITHEIGHT * 10);
//		make.right.mas_equalTo(_nameBackView).with.offset(-UNITHEIGHT * 47);
//		make.height.mas_equalTo(UNITHEIGHT * 24);
//		make.top.mas_equalTo(_brandImageView);
//	}];

	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_moneyView).with.offset(UNITHEIGHT * 10);
		make.right.mas_equalTo(_moneyView);
		make.height.mas_equalTo(UNITHEIGHT * 30);
		make.top.mas_equalTo(_moneyView).with.offset(UNITHEIGHT * 5);
	}];

	[_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_titleLabel);
		make.width.mas_equalTo(_titleLabel);
		make.top.mas_equalTo(_titleLabel.mas_bottom);
		make.height.mas_equalTo(UNITHEIGHT * 30);
	}];

	[_delegateView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView.mas_right);
		make.bottom.mas_equalTo(self.contentView);
		make.width.mas_equalTo(UNITHEIGHT * 69);
		make.top.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 10);
	}];

	[_delegateButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.and.centerY.mas_equalTo(_delegateView);
		make.height.and.width.mas_equalTo(UNITHEIGHT * 24);
	}];

	[_chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(self.contentView.mas_left);
		make.centerY.mas_equalTo(self.contentView);
		make.height.width.mas_equalTo(UNITHEIGHT * 20);
	}];
}

- (void)choosebutton:(UIButton *)button {

}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
