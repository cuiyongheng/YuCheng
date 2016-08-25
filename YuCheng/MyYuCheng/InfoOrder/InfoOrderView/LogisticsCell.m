//
//  LogisticsCell.m
//  YuCheng
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LogisticsCell.h"

@implementation LogisticsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	self.backView = [[UIView alloc] init];
	_backView.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1];
	[self.contentView addSubview:_backView];

	self.roundView = [[UIView alloc] init];
	_roundView.backgroundColor = [UIColor colorWithRed:161 / 255.0 green:182 / 255.0 blue:223 / 255.0 alpha:1];
	_roundView.layer.cornerRadius = UNITHEIGHT * 4;
	_roundView.layer.masksToBounds = YES;
	[self.contentView addSubview:_roundView];

	self.upView = [[UIView alloc] init];
	_upView.backgroundColor = [UIColor blackColor];
	[self.contentView addSubview:_upView];

	self.downView = [[UIView alloc] init];
	_downView.backgroundColor = [UIColor blackColor];
	[self.contentView addSubview:_downView];

	self.hotView = [[UILabel alloc] init];
	_hotView.textColor = [UIColor whiteColor];
	_hotView.text = @"最新";
	_hotView.font = font(14);
	_hotView.backgroundColor = [UIColor redColor];
	[self.contentView addSubview:_hotView];

	_timeLabel = [[UILabel alloc] init];
//	_timeLabel.text = @"2016年7月7日 上午8:41:25";
	_timeLabel.font = boldFont(14);
	[self.contentView addSubview:_timeLabel];

	_infoLabel = [[UILabel alloc] init];
//	_infoLabel.text = @"已签收,感谢使用顺丰,期待再次为您服务";
	_infoLabel.font = font(14);
	_infoLabel.numberOfLines = 0;
	[self.contentView addSubview:_infoLabel];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	[_backView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 20);
		make.right.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 20);
		make.top.bottom.mas_equalTo(self.contentView);
	}];

	[_roundView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(self.contentView);
		make.width.height.mas_equalTo(UNITHEIGHT * 8);
		make.left.mas_equalTo(_backView).with.offset(UNITHEIGHT * 20);
	}];

	[_upView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.mas_equalTo(1);
		make.top.mas_equalTo(self.contentView);
		make.bottom.mas_equalTo(self.contentView.mas_centerY).with.offset(-UNITHEIGHT * 6);
		make.centerX.mas_equalTo(_roundView);
	}];

	[_downView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.contentView.mas_centerY).with.offset(UNITHEIGHT * 6);
		make.width.mas_equalTo(1);
		make.bottom.mas_equalTo(self.contentView);
		make.centerX.mas_equalTo(_roundView);
	}];

	[_hotView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(_backView);
		make.left.mas_equalTo(_roundView.mas_right).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 15);
		make.width.mas_equalTo(UNITHEIGHT * 30);
	}];

	[_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_hotView.mas_right).with.offset(UNITHEIGHT * 10);
		make.top.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 5);
		make.height.mas_equalTo(UNITHEIGHT * 15);
	}];

	[_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_timeLabel);
		make.height.mas_equalTo(UNITHEIGHT * 35);
		make.top.mas_equalTo(self.timeLabel.mas_bottom);
		make.right.mas_equalTo(_backView).with.offset(-UNITHEIGHT * 10);
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
