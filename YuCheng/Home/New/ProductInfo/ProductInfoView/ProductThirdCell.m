//
//  ProductThirdCell.m
//  YuCheng
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ProductThirdCell.h"
#import "SDPhotoBrowser.h"

@interface ProductThirdCell ()<SDPhotoBrowserDelegate>

@end

@implementation ProductThirdCell

{
	NSInteger picCount;
}

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
	_backView.alpha = 0.98;
	_backView.userInteractionEnabled = NO;
	[self.contentView addSubview:_backView];

	self.titleLabel = [[UILabel alloc] init];
	_titleLabel.text = @"相关证书";
	_titleLabel.font = font(11);
	_titleLabel.textAlignment = NSTextAlignmentCenter;
	_titleLabel.textColor = [UIColor colorWithHexString:@"#717071"];
	[self.contentView addSubview:_titleLabel];

	self.lineView = [[UIView alloc] init];
	_lineView.hidden = YES;
	_lineView.backgroundColor = [UIColor colorWithHexString:@"#e2e2e2"];
	[self.contentView addSubview:_lineView];

	self.picView = [[UIView alloc] init];
	_picView.hidden = YES;
	_picView.userInteractionEnabled = NO;
	[self.contentView addSubview:_picView];
}

- (void)layoutSubviews {
	[super layoutSubviews];

	[_backView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 10);
		make.right.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 10);
		make.top.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 6);
		make.bottom.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 6);
	}];

	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.contentView);
		make.height.mas_equalTo(UNITHEIGHT * 10);
		make.top.mas_equalTo(_backView).with.offset(UNITHEIGHT * 16);
	}];

	[_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(UNITHEIGHT * 11);
		make.left.mas_equalTo(_backView).with.offset(UNITHEIGHT * 30);
		make.right.mas_equalTo(_backView).with.offset(-UNITHEIGHT * 30);
		make.height.mas_equalTo(1);
	}];

	[_picView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 10);
		make.right.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 10);
		make.bottom.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 6);
		make.top.mas_equalTo(_lineView.mas_bottom).with.offset(UNITHEIGHT * 10);
	}];
}

- (void)setPicArr:(NSMutableArray *)picArr {
	for (NSInteger i = 0; i < picArr.count; i++) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(UNITHEIGHT * 5, (UNITHEIGHT * 500 * i), WIDTH - UNITHEIGHT * 30, UNITHEIGHT * 480)];
		imageView.layer.borderColor = [UIColor whiteColor].CGColor;
		imageView.layer.borderWidth = 1;
		[imageView sd_setImageWithURL:[NSURL URLWithString:picArr[i]] placeholderImage:[UIImage imageNamed:@""]];
		[self.picView addSubview:imageView];
	}
}

- (void)setPorductArr:(NSMutableArray *)porductArr {

	picCount = porductArr.count - 1;
	for (NSInteger i = 0; i < porductArr.count - 1; i++) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(UNITHEIGHT * 31.5, (UNITHEIGHT * 302 * i), UNITHEIGHT * 292, UNITHEIGHT * 292)];
		[imageView sd_setImageWithURL:[NSURL URLWithString:porductArr[i]] placeholderImage:[UIImage imageNamed:@""]];
		[self.picView addSubview:imageView];
		imageView.userInteractionEnabled = YES;

		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.backgroundColor = [UIColor clearColor];
		[self addSubview:button];
		button.tag = 1500 + i;
		[button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];

		[button mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.right.top.bottom.mas_equalTo(imageView);
		}];
	}
}

- (void)tapAction:(UIButton *)button {
	[self.delegate multiplieurPic:button.tag - 1500 total:picCount];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
