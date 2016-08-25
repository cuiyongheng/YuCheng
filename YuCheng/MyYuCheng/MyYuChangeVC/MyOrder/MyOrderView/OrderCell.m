//
//  OrderCell.m
//  YuCheng
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	self.baseCell = [[ShoppingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	_baseCell.frame = CGRectMake(0, 0, WIDTH - UNITHEIGHT * 10, UNITHEIGHT * 134);
	[self.contentView addSubview:_baseCell];

//	self.stateLabel = [[UILabel alloc] init];
//	_stateLabel.text = @"等待付款";
//	_stateLabel.font = font(11);
//	_stateLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
//	[self.contentView addSubview:_stateLabel];
//
//	self.numberLabel = [[UILabel alloc] init];
//	_numberLabel.text = @"订单号：1234567890";
//	_numberLabel.textColor = [UIColor colorWithHexString:@"#717071"];
//	_numberLabel.font = font(11);
//	[self.contentView addSubview:_numberLabel];
//
//	self.payButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	_payButton.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
//	[_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//	[_payButton setTitle:@"立即付款" forState:UIControlStateNormal];
//	_payButton.titleLabel.font = font(11);
//	[_payButton addTarget:self action:@selector(payButton:) forControlEvents:UIControlEventTouchUpInside];
//	[self.contentView addSubview:_payButton];

}

- (void)layoutSubviews {
	[super layoutSubviews];
//	[_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.right.mas_equalTo(_baseCell.moneyView).with.offset(-UNITHEIGHT * 12);
//		make.height.mas_equalTo(UNITHEIGHT * 20);
//		make.top.mas_equalTo(_baseCell.moneyView).with.offset(UNITHEIGHT * 10);
//	}];
//
//	[_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.mas_equalTo(_baseCell.titleLabel);
//		make.height.mas_equalTo(UNITHEIGHT * 10);
//		make.bottom.mas_equalTo(_baseCell.moneyView).with.offset(-UNITHEIGHT * 30);
//	}];
//
//	[_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.bottom.mas_equalTo(_baseCell.moneyView);
//		make.width.mas_equalTo(UNITHEIGHT * 201);
//		make.right.mas_equalTo(_baseCell.moneyView);
//		make.height.mas_equalTo(UNITHEIGHT * 25);
//	}];
}

//- (void)payButton:(UIButton *)button {
//	[self.delegate payButtonAction:button.tag];
//}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
