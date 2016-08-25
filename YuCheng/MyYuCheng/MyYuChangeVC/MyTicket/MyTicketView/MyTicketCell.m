//
//  MyTicketCell.m
//  YuCheng
//
//  Created by apple on 16/6/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyTicketCell.h"

@implementation MyTicketCell

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
	[self.contentView addSubview:_backView];

	self.moneyLabel = [[UILabel alloc] init];
	_moneyLabel.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
	_moneyLabel.font = font(30);
	_moneyLabel.text = @"¥100";
	_moneyLabel.textAlignment = NSTextAlignmentCenter;
	_moneyLabel.textColor = [UIColor whiteColor];
	[self.contentView addSubview:_moneyLabel];

	self.conditionLabel = [[UILabel alloc] init];
	_conditionLabel.font = font(18);
	_conditionLabel.text = @"满1000减100";
	_conditionLabel.textAlignment = NSTextAlignmentCenter;
	_conditionLabel.textColor = [UIColor blackColor];
	[self.contentView addSubview:_conditionLabel];

	self.timeLabel = [[UILabel alloc] init];
	_timeLabel.font = font(16);
	_timeLabel.text = @"有效期：2016.6.21-2016.7.21";
	_timeLabel.textAlignment = NSTextAlignmentCenter;
	_timeLabel.textColor = [UIColor blackColor];
	[self.contentView addSubview:_timeLabel];

	for (NSInteger i = 0; i < 14; i++) {
		UIView *roundView = [[UIView alloc] initWithFrame:CGRectMake(UNITHEIGHT * 12 + (UNITHEIGHT * 25.5 * i), UNITHEIGHT * 65 - UNITHEIGHT * 10, UNITHEIGHT * 20, UNITHEIGHT * 20)];
		roundView.layer.cornerRadius = UNITHEIGHT * 10;
		roundView.layer.masksToBounds = YES;
		roundView.backgroundColor = [UIColor whiteColor];
		[self.contentView addSubview:roundView];
	}

}

- (void)layoutSubviews {
	[super layoutSubviews];
	[_backView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(UNITHEIGHT * 5);
		make.right.mas_equalTo(-UNITHEIGHT * 5);
		make.top.mas_equalTo(UNITHEIGHT * 5);
		make.bottom.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 5);
	}];

	[_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.mas_equalTo(self.backView);
		make.height.mas_equalTo(UNITHEIGHT * 60);
	}];

	[_conditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.contentView);
		make.top.mas_equalTo(_moneyLabel.mas_bottom).with.offset(UNITHEIGHT * 20);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

	[_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.contentView);
		make.height.mas_equalTo(UNITHEIGHT * 10);
		make.top.mas_equalTo(_conditionLabel.mas_bottom).with.offset(UNITHEIGHT * 20);
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
