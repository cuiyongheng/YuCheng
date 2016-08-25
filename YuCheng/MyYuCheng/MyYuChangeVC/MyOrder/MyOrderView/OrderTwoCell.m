//
//  OrderTwoCell.m
//  YuCheng
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "OrderTwoCell.h"

@implementation OrderTwoCell

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
//	_stateLabel.text = @"等待发货";
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
////	self.serviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
////	[_serviceButton setBackgroundImage:[UIImage imageNamed:@"yc-55"] forState:UIControlStateNormal];
////	[self.contentView addSubview:_serviceButton];
//
//
//	self.refundButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	_refundButton.backgroundColor = [UIColor colorWithHexString:@"#191919"];
//	[_refundButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//	[_refundButton setTitle:@"申请退款" forState:UIControlStateNormal];
//	_refundButton.titleLabel.font = font(11);
//	[self.contentView addSubview:_refundButton];
//
//	self.remindButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	_remindButton.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
//	[_remindButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//	[_remindButton setTitle:@"提醒发货" forState:UIControlStateNormal];
//	_remindButton.titleLabel.font = font(11);
//	[self.contentView addSubview:_remindButton];

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
////	[_serviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
////		make.right.mas_equalTo(_baseCell.nameBackView.mas_right).with.offset(-UNITHEIGHT * 10);
////		make.height.and.width.mas_equalTo(UNITHEIGHT * 27);
////		make.top.mas_equalTo(_baseCell.nameBackView).with.offset(UNITHEIGHT * 6);
////	}];
//
//	[_refundButton mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.bottom.mas_equalTo(_baseCell.moneyView);
//		make.left.mas_equalTo(_baseCell.picImageView.mas_right);
//		make.width.mas_equalTo(UNITHEIGHT * 100.5);
//		make.height.mas_equalTo(UNITHEIGHT * 25);
//	}];
//
//	[_remindButton mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.bottom.mas_equalTo(_baseCell.moneyView);
//		make.left.mas_equalTo(_refundButton.mas_right);
//		make.width.mas_equalTo(UNITHEIGHT * 100.5);
//		make.height.mas_equalTo(UNITHEIGHT * 25);
//	}];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
