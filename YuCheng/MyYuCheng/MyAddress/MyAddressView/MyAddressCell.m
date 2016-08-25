//
//  MyAddressCell.m
//  YuCheng
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyAddressCell.h"

@implementation MyAddressCell

{
	NSString * address_id;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	self.nameLabel = [[UILabel alloc] init];
	_nameLabel.text = @"刘公子";
	_nameLabel.font = font(15);
	[self.contentView addSubview:_nameLabel];

	self.phoneLabel = [[UILabel alloc] init];
	_phoneLabel.text = @"13888888888";
	_phoneLabel.font = font(11);
	_phoneLabel.textColor = [UIColor colorWithHexString:@"#717071"];
	_phoneLabel.textAlignment = NSTextAlignmentRight;
	[self.contentView addSubview:_phoneLabel];

	self.addressLabel = [[UILabel alloc] init];
	_addressLabel.textAlignment = NSTextAlignmentRight;
	_addressLabel.text = @"云南省XXXXXXXXXXXX";
	_addressLabel.font = font(11);
	_addressLabel.textColor = [UIColor colorWithHexString:@"#717071"];
	[self.contentView addSubview:_addressLabel];

	self.lineView = [[UIView alloc] init];
	_lineView.backgroundColor = [UIColor colorWithHexString:@"#a5a5a5"];
	[self.contentView addSubview:_lineView];

	self.statusLabel = [[UILabel alloc] init];
	_statusLabel.text = @"默认地址";
	_statusLabel.textAlignment = NSTextAlignmentCenter;
	_statusLabel.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
	_statusLabel.textColor = [UIColor whiteColor];
	_statusLabel.font = font(11);
	_statusLabel.hidden = YES;
	[self.contentView addSubview:_statusLabel];

	self.deleteView = [[UIView alloc] init];
	_deleteView.backgroundColor = [UIColor colorWithHexString:@"792b34"];
	[self.contentView addSubview:_deleteView];

	self.deleteImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete"]];
	[_deleteView addSubview:_deleteImageView];

	self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	[_deleteButton setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
	[_deleteButton addTarget:self action:@selector(deleteButton:) forControlEvents:UIControlEventTouchUpInside];
	[_deleteView addSubview:_deleteButton];

	self.changeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"change"]];
	[_deleteView addSubview:_changeImageView];

	self.reviseButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	[_reviseButton setBackgroundImage:[UIImage imageNamed:@"change"] forState:UIControlStateNormal];
	[_reviseButton addTarget:self action:@selector(reviseButton:) forControlEvents:UIControlEventTouchUpInside];
	[_deleteView addSubview:_reviseButton];

	self.deleteLabel = [[UILabel alloc] init];
	_deleteLabel.text = @"删除";
	_deleteLabel.font = font(13);
	_deleteLabel.textColor = [UIColor whiteColor];
	_deleteLabel.textAlignment = NSTextAlignmentCenter;
	[_deleteView addSubview:_deleteLabel];

	self.reviseLabel = [[UILabel alloc] init];
	_reviseLabel.text = @"修改";
	_reviseLabel.font = font(13);
	_reviseLabel.textColor = [UIColor whiteColor];
	_reviseLabel.textAlignment = NSTextAlignmentCenter;
	[_deleteView addSubview:_reviseLabel];

}

- (void)layoutSubviews {
	[super layoutSubviews];
	[_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 25);
		make.top.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 30);
	}];

	[_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(self.contentView);
		make.height.mas_equalTo(UNITHEIGHT * 30);
		make.top.mas_equalTo(_nameLabel);
		make.width.mas_equalTo(UNITHEIGHT * 150);
	}];

	[_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.height.mas_equalTo(_phoneLabel);
		make.top.mas_equalTo(_phoneLabel.mas_bottom);
		make.width.mas_equalTo(UNITHEIGHT * 250);
	}];

	[_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 25);
		make.right.mas_equalTo(self.contentView);
		make.height.mas_equalTo(1);
		make.bottom.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 1);
	}];

	[_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_nameLabel.mas_right).with.offset(UNITHEIGHT * 10);
		make.centerY.mas_equalTo(_nameLabel);
		make.height.mas_equalTo(UNITHEIGHT * 20);
		make.width.mas_equalTo(UNITHEIGHT * 54.5);
	}];

	[_deleteView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.height.mas_equalTo(self.contentView);
		make.left.mas_equalTo(self.contentView.mas_right);
		make.width.mas_equalTo(UNITHEIGHT * 112);
	}];

	[_deleteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(_deleteView).with.offset(-UNITHEIGHT * 22);
		make.top.mas_equalTo(_deleteView).with.offset(UNITHEIGHT * 13.5);
		make.width.mas_equalTo(UNITHEIGHT * 20);
		make.height.mas_equalTo(UNITHEIGHT * 25);
	}];

	[_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(_deleteView).with.offset(-UNITHEIGHT * 15);
		make.top.mas_equalTo(_deleteImageView);
		make.width.mas_equalTo(UNITHEIGHT * 30);
		make.height.mas_equalTo(UNITHEIGHT * 60);
	}];

	[_changeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_deleteView).with.offset(UNITHEIGHT * 13.5);
		make.width.mas_equalTo(UNITHEIGHT * 20);
		make.left.mas_equalTo(_deleteView).with.offset(UNITHEIGHT * 20);
		make.height.mas_equalTo(UNITHEIGHT * 25);
	}];

	[_reviseButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_changeImageView);
		make.width.mas_equalTo(UNITHEIGHT * 30);
		make.left.mas_equalTo(_deleteView).with.offset(UNITHEIGHT * 15);
		make.height.mas_equalTo(UNITHEIGHT * 60);
	}];

	[_deleteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_deleteButton);
		make.top.mas_equalTo(_deleteImageView.mas_bottom).with.offset(UNITHEIGHT * 10);
	}];

	[_reviseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_reviseButton);
		make.top.mas_equalTo(_deleteImageView.mas_bottom).with.offset(UNITHEIGHT * 10);
	}];
}

- (void)setModel:(AddressModel *)model {
	_model = model;

	_nameLabel.text = [NSString stringWithFormat:@"%@", model.consignee];
	_phoneLabel.text = [NSString stringWithFormat:@"%@", model.mobile];
	_addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@", model.province_name, model.city_name, model.district_name, model.address];
	_addressLabel.numberOfLines = 2;
	[_addressLabel sizeToFit];
	address_id = model.address_id;

}

- (void)setDefaultAddressStr:(NSString *)defaultAddressStr {
	_defaultAddressStr = defaultAddressStr;
	if ([self.defaultAddressStr isEqualToString:address_id]) {
		_statusLabel.hidden = NO;
	} else {
		_statusLabel.hidden = YES;
	}
}

- (void)deleteButton:(UIButton *)button {
	[self.delegate deleteAction:button.tag];
}

- (void)reviseButton:(UIButton *)button {
	[self.delegate reviseAction:button.tag];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
