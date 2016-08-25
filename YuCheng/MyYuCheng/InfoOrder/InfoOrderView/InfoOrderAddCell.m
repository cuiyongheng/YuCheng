//
//  InfoOrderAddCell.m
//  YuCheng
//
//  Created by apple on 16/7/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "InfoOrderAddCell.h"

@implementation InfoOrderAddCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	UIView *threeLineView = [[UIView alloc] init];
	threeLineView.backgroundColor = [UIColor blackColor];
	[self addSubview:threeLineView];

	[threeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.mas_equalTo(self.contentView).with.offset(-1);
		make.height.mas_equalTo(1);
		make.left.mas_equalTo(self).with.offset(UNITHEIGHT * 10);
		make.right.mas_equalTo(self).with.offset(-UNITHEIGHT * 10);
	}];
	
	self.addImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"address"]];
	[self addSubview:_addImageView];

	[_addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(threeLineView);
		make.top.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 15);
		make.height.mas_equalTo(UNITHEIGHT * 35);
		make.width.mas_equalTo(UNITHEIGHT * 32);
	}];


	self.peopleLabel = [[UILabel alloc] init];
	//	_peopleLabel.text = @"收货人：刘公子";
	_peopleLabel.font = font(14);
	[self addSubview:_peopleLabel];

	[_peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_addImageView.mas_right).with.offset(UNITHEIGHT * 10);
		make.top.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 5);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

	self.addLabel = [[UILabel alloc] init];
	//	_addLabel.text = @"收货地址：云南省XXXXXXXXXXX";
	_addLabel.font = font(14);
	[self addSubview:_addLabel];

	[_addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_peopleLabel);
		make.top.mas_equalTo(_peopleLabel.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

	self.phoneLabel = [[UILabel alloc] init];
	//	_phoneLabel.text = @"13888888";
	_phoneLabel.font = font(14);
	[self addSubview:_phoneLabel];

	[_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(threeLineView);
		make.height.top.mas_equalTo(_peopleLabel);
	}];

}

- (void)setModel:(InfoOrderModel *)model {
	_model = model;
	_phoneLabel.text = model.mobile;
	_addLabel.text = [NSString stringWithFormat:@"收货地址：%@%@%@", model.province_name, model.city_name, model.district_name];
	_peopleLabel.text = [NSString stringWithFormat:@"收货人：%@", model.consignee];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
