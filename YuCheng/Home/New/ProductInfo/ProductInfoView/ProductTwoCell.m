//
//  ProductTwoCell.m
//  YuCheng
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ProductTwoCell.h"

@implementation ProductTwoCell

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
	[self.contentView addSubview:_backView];

	self.lineView = [[UIView alloc] init];
	_lineView.backgroundColor = [UIColor blackColor];
	[self.contentView addSubview:_lineView];

	self.titleLabel = [[UILabel alloc] init];
	_titleLabel.text = @"商品详情";
	_titleLabel.font = font(11);
	_titleLabel.textAlignment = NSTextAlignmentCenter;
	_titleLabel.textColor = [UIColor colorWithHexString:@"#717071"];
	[self.contentView addSubview:_titleLabel];

	self.kucunLabel = [[UILabel alloc] init];
//	_kucunLabel.text = @"库存：  仅此一件。";
	_kucunLabel.textColor = [UIColor colorWithHexString:@"#221814"];
	_kucunLabel.font = font(11);
	_kucunLabel.numberOfLines = 2;
	[_kucunLabel sizeToFit];
	[self.contentView addSubview:_kucunLabel];

	self.sizeLabel = [[UILabel alloc] init];
//	_sizeLabel.text = @"尺寸：  内径：56.7mm  宽：17mm  厚：8.2mm";
	_sizeLabel.textColor = [UIColor colorWithHexString:@"#221814"];
	_sizeLabel.font = font(11);
	_sizeLabel.numberOfLines = 2;
	[_sizeLabel sizeToFit];
	[self.contentView addSubview:_sizeLabel];

	self.cololLabel = [[UILabel alloc] init];
//	_cololLabel.text = @"颜色：  晴水飘阳绿。";
	_cololLabel.textColor = [UIColor colorWithHexString:@"#221814"];
	_cololLabel.font = font(11);
	_cololLabel.numberOfLines = 2;
	[_cololLabel sizeToFit];
	[self.contentView addSubview:_cololLabel];

	self.alphaLabel = [[UILabel alloc] init];
//	_alphaLabel.text = @"透明度：  三分之一透明。";
	_alphaLabel.textColor = [UIColor colorWithHexString:@"#221814"];
	_alphaLabel.font = font(11);
	_alphaLabel.numberOfLines = 2;
	[_alphaLabel sizeToFit];
	[self.contentView addSubview:_alphaLabel];

	self.defcetLabel = [[UILabel alloc] init];
//	_defcetLabel.text = @"瑕坯裂絮：  肉眼不见绺裂，但略微有棉，瑕不掩瑜。";
	_defcetLabel.textColor = [UIColor colorWithHexString:@"#221814"];
	_defcetLabel.font = font(11);
	_defcetLabel.numberOfLines = 2;
	[_defcetLabel sizeToFit];
	[self.contentView addSubview:_defcetLabel];

	self.productionLabel = [[UILabel alloc] init];
//	_productionLabel.text = @"原石产地：  缅甸北部密支那宝石级翡翠矿区。";
	_productionLabel.textColor = [UIColor colorWithHexString:@"#221814"];
	_productionLabel.font = font(11);
	_productionLabel.numberOfLines = 2;
	[_productionLabel sizeToFit];
	[self.contentView addSubview:_productionLabel];

	self.levelLabel = [[UILabel alloc] init];
//	_levelLabel.text = @"工艺水平：  全手工精细雕刻；经钻石粉千次抛光。";
	_levelLabel.textColor = [UIColor colorWithHexString:@"#221814"];
	_levelLabel.font = font(11);
	_levelLabel.numberOfLines = 2;
	[_levelLabel sizeToFit];
	[self.contentView addSubview:_levelLabel];

	self.certificateLabel = [[UILabel alloc] init];
//	_certificateLabel.text = @"国检证书：  本品为天然缅甸A货翡翠，成交时出具权威检测证书，欢迎到任何权威珠宝检测机构复检。";
	_certificateLabel.textColor = [UIColor colorWithHexString:@"#221814"];
	_certificateLabel.font = font(11);
	_certificateLabel.numberOfLines = 2;
	[_certificateLabel sizeToFit];
	[self.contentView addSubview:_certificateLabel];

//	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//	paragraphStyle.lineSpacing = 5;//行间距
//
//	//设置字号和行间距
//	NSDictionary *ats = @{
//						  NSFontAttributeName : [UIFont systemFontOfSize:11.0f],
//						  NSParagraphStyleAttributeName : paragraphStyle,
//						  };
//
//	_certificateLabel.attributedText = [[NSAttributedString alloc] initWithString:_certificateLabel.text attributes:ats];//设置行间距



//	self.testingLabel = [[UILabel alloc] init];
//	_testingLabel.text = @"威检测证书：  欢迎到任何权威珠宝检测机构复检";
//	_testingLabel.textColor = [UIColor colorWithHexString:@"#221814"];
//	_testingLabel.font = font(11);
//	[self.contentView addSubview:_testingLabel];

	self.peisongLabel = [[UILabel alloc] init];
//	_peisongLabel.text = @"随单配件：  珠宝盒、国检A货证书、挂件另增精美挂绳，其他赠品按实物邮寄为准。";
	_peisongLabel.textColor = [UIColor colorWithHexString:@"#221814"];
	_peisongLabel.font = font(11);
	_peisongLabel.numberOfLines = 2;
	[_peisongLabel sizeToFit];
	[self.contentView addSubview:_peisongLabel];

//	NSMutableParagraphStyle *paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
//	paragraphStyle2.lineSpacing = 5;//行间距
//
//	//设置字号和行间距
//	NSDictionary *ats2 = @{
//						  NSFontAttributeName : [UIFont systemFontOfSize:11.0f],
//						  NSParagraphStyleAttributeName : paragraphStyle2,
//						  };
//
//	_peisongLabel.attributedText = [[NSAttributedString alloc] initWithString:_peisongLabel.text attributes:ats2];//设置行间距
//


	self.shouhouLabel = [[UILabel alloc] init];
//	_shouhouLabel.text = @"售后承诺：  签收之时起7日内，不需任何理由均可自由退换，保证提供完美服务，并承担一切法律责任。";
	_shouhouLabel.textColor = [UIColor colorWithHexString:@"#221814"];
	_shouhouLabel.font = font(11);
	_shouhouLabel.numberOfLines = 2;
	[_shouhouLabel sizeToFit];
	[self.contentView addSubview:_shouhouLabel];

//	NSMutableParagraphStyle *paragraphStyle3 = [[NSMutableParagraphStyle alloc] init];
//	paragraphStyle3.lineSpacing = 5;//行间距
//
//	//设置字号和行间距
//	NSDictionary *ats3 = @{
//						   NSFontAttributeName : [UIFont systemFontOfSize:11.0f],
//						   NSParagraphStyleAttributeName : paragraphStyle3,
//						   };
//
//	_shouhouLabel.attributedText = [[NSAttributedString alloc] initWithString:_shouhouLabel.text attributes:ats3];//设置行间距



	self.peisongTimeLabel = [[UILabel alloc] init];
//	_peisongTimeLabel.text = @"配送时间：  付款之时起72小时内发货，使用顺丰快递或EMS特快专递，三到五天即可到达，特殊情况适当顺延。";
	_peisongTimeLabel.textColor = [UIColor colorWithHexString:@"#221814"];
	_peisongTimeLabel.font = font(11);
	_peisongTimeLabel.numberOfLines = 2;
	[_peisongTimeLabel sizeToFit];
	[self.contentView addSubview:_peisongTimeLabel];

//	NSMutableParagraphStyle *paragraphStyle4 = [[NSMutableParagraphStyle alloc] init];
//	paragraphStyle4.lineSpacing = 5;//行间距
//
//	//设置字号和行间距
//	NSDictionary *ats4 = @{
//						   NSFontAttributeName : [UIFont systemFontOfSize:11.0f],
//						   NSParagraphStyleAttributeName : paragraphStyle4,
//						   };
//
//	_peisongTimeLabel.attributedText = [[NSAttributedString alloc] initWithString:_peisongTimeLabel.text attributes:ats4];//设置行间距



	self.bianjiLabel = [[UILabel alloc] init];
//	_bianjiLabel.text = @"编辑：  刘公子";
	_bianjiLabel.textColor = [UIColor colorWithHexString:@"#221814"];
	_bianjiLabel.font = font(11);
	_bianjiLabel.numberOfLines = 2;
	[_bianjiLabel sizeToFit];
	[self.contentView addSubview:_bianjiLabel];

	self.sheyingLabel = [[UILabel alloc] init];
//	_sheyingLabel.text = @"摄影师：  刘公子";
	_sheyingLabel.textColor = [UIColor colorWithHexString:@"#221814"];
	_sheyingLabel.font = font(11);
	_sheyingLabel.numberOfLines = 2;
	[_sheyingLabel sizeToFit];
	[self.contentView addSubview:_sheyingLabel];

	self.timeLabel = [[UILabel alloc] init];
//	_timeLabel.text = @"摄影时间：  2016-05-26";
	_timeLabel.textColor = [UIColor colorWithHexString:@"#221814"];
	_timeLabel.font = font(11);
	_timeLabel.numberOfLines = 2;
	[_timeLabel sizeToFit];
	[self.contentView addSubview:_timeLabel];
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
		make.top.mas_equalTo(_backView).with.offset(UNITHEIGHT * 13);
		make.height.mas_equalTo(UNITHEIGHT * 20.0f);
	}];

	[_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(UNITHEIGHT * 11);
		make.left.mas_equalTo(_backView).with.offset(UNITHEIGHT * 30);
		make.right.mas_equalTo(_backView).with.offset(-UNITHEIGHT * 30);
		make.height.mas_equalTo(UNITHEIGHT * 0.3);
	}];

	[_kucunLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_backView).with.offset(UNITHEIGHT * 35.5);
		make.height.mas_equalTo(UNITHEIGHT * 30);
		make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(UNITHEIGHT * 15);
		make.right.mas_equalTo(_lineView);
	}];

	[_sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_backView).with.offset(UNITHEIGHT * 35.5);
		make.height.mas_equalTo(UNITHEIGHT * 20);
		make.top.mas_equalTo(_kucunLabel.mas_bottom);
		make.right.mas_equalTo(_lineView);
	}];

	[_cololLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.and.left.mas_equalTo(_sizeLabel);
		make.top.mas_equalTo(_sizeLabel.mas_bottom);
		make.right.mas_equalTo(_lineView);
	}];

	[_alphaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.and.left.mas_equalTo(_sizeLabel);
		make.top.mas_equalTo(_cololLabel.mas_bottom);
		make.right.mas_equalTo(_lineView);
	}];

	[_defcetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.and.left.mas_equalTo(_sizeLabel);
		make.top.mas_equalTo(_alphaLabel.mas_bottom);
		make.right.mas_equalTo(_lineView);
	}];

	[_productionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.and.left.mas_equalTo(_sizeLabel);
		make.top.mas_equalTo(_defcetLabel.mas_bottom);
		make.right.mas_equalTo(_lineView);
	}];

	[_levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.and.left.mas_equalTo(_sizeLabel);
		make.top.mas_equalTo(_productionLabel.mas_bottom);
		make.right.mas_equalTo(_lineView);
	}];

	[_certificateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_sizeLabel);
		make.height.mas_equalTo(UNITHEIGHT * 35);
		make.top.mas_equalTo(_levelLabel.mas_bottom);
		make.right.mas_equalTo(_lineView);
	}];

//	[_testingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.height.and.left.mas_equalTo(_sizeLabel);
//		make.top.mas_equalTo(_certificateLabel.mas_bottom);
//		make.right.mas_equalTo(_backView);
//	}];

	[_peisongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_sizeLabel);
		make.height.mas_equalTo(UNITHEIGHT * 35);
		make.top.mas_equalTo(_certificateLabel.mas_bottom);
		make.right.mas_equalTo(_lineView);
	}];

	[_shouhouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_sizeLabel);
		make.top.mas_equalTo(_peisongLabel.mas_bottom);
		make.height.mas_equalTo(UNITHEIGHT * 35);
		make.right.mas_equalTo(_lineView);
	}];

	[_peisongTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_sizeLabel);
		make.top.mas_equalTo(_shouhouLabel.mas_bottom);
		make.right.mas_equalTo(_lineView);
		make.height.mas_equalTo(UNITHEIGHT * 35);
	}];

	[_bianjiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.and.left.mas_equalTo(_sizeLabel);
		make.top.mas_equalTo(_peisongTimeLabel.mas_bottom);
		make.right.mas_equalTo(_lineView);
	}];

	[_sheyingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.and.left.mas_equalTo(_sizeLabel);
		make.top.mas_equalTo(_bianjiLabel.mas_bottom);
		make.right.mas_equalTo(_lineView);
	}];

	[_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.and.left.mas_equalTo(_sizeLabel);
		make.top.mas_equalTo(_sheyingLabel.mas_bottom);
		make.right.mas_equalTo(_lineView);
	}];
}

- (void)setModel:(ProductInfoModel *)model {
	_model = model;

	_cololLabel.text = [NSString stringWithFormat:@"颜色：%@", model.goods_color];
	_alphaLabel.text = [NSString stringWithFormat:@"透明度：%@", model.transparency];
	_defcetLabel.text = [NSString stringWithFormat:@"瑕坯裂絮：%@", model.defect];
	_productionLabel.text = [NSString stringWithFormat:@"原石产地：%@", model.origin_place];
	_levelLabel.text = [NSString stringWithFormat:@"工艺水平：%@", model.craft];
	_bianjiLabel.text = [NSString stringWithFormat:@"编辑：%@", model.editor];
	_sheyingLabel.text = [NSString stringWithFormat:@"摄影师：%@", model.photographer];
	_timeLabel.text = [NSString stringWithFormat:@"拍摄时间：%@", model.photo_time];
	_kucunLabel.text = [NSString stringWithFormat:@"库存：%@", model.goods_number];
	_sizeLabel.text = [NSString stringWithFormat:@"尺寸： 内径：%@ 宽：%@ 厚：%@", model.inside_diameter, model.goods_width, model.goods_thickness];
}

- (void)setModelDic:(NSMutableDictionary *)modelDic {
	_modelDic = modelDic;
	_certificateLabel.text = [NSString stringWithFormat:@"国检证书：%@" ,_modelDic[@"certificate_desc"]];
	_shouhouLabel.text = [NSString stringWithFormat:@"售后承诺：%@" ,_modelDic[@"aftersale_promise_desc"]];
	_peisongLabel.text = [NSString stringWithFormat:@"随单配件：%@", _modelDic[@"accessory_desc"]];
	_peisongTimeLabel.text = [NSString stringWithFormat:@"配送时间：%@" ,_modelDic[@"delivery_time_desc"]];



	_certificateLabel.numberOfLines = 2;
	[_certificateLabel sizeToFit];
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	paragraphStyle.lineSpacing = 5;//行间距

	//设置字号和行间距
	NSDictionary *ats = @{
						  NSFontAttributeName : [UIFont systemFontOfSize:11.0f],
						  NSParagraphStyleAttributeName : paragraphStyle,
						  };

	_certificateLabel.attributedText = [[NSAttributedString alloc] initWithString:_certificateLabel.text attributes:ats];//设置行间距



	_peisongLabel.numberOfLines = 2;
	[_peisongLabel sizeToFit];

	NSMutableParagraphStyle *paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
	paragraphStyle2.lineSpacing = 5;//行间距

	//设置字号和行间距
	NSDictionary *ats2 = @{
						   NSFontAttributeName : [UIFont systemFontOfSize:11.0f],
						   NSParagraphStyleAttributeName : paragraphStyle2,
						   };

	_peisongLabel.attributedText = [[NSAttributedString alloc] initWithString:_peisongLabel.text attributes:ats2];//设置行间距



	_shouhouLabel.numberOfLines = 2;
	[_shouhouLabel sizeToFit];

	NSMutableParagraphStyle *paragraphStyle3 = [[NSMutableParagraphStyle alloc] init];
	paragraphStyle3.lineSpacing = 5;//行间距

	//设置字号和行间距
	NSDictionary *ats3 = @{
						   NSFontAttributeName : [UIFont systemFontOfSize:11.0f],
						   NSParagraphStyleAttributeName : paragraphStyle3,
						   };

	_shouhouLabel.attributedText = [[NSAttributedString alloc] initWithString:_shouhouLabel.text attributes:ats3];//设置行间距



	_peisongTimeLabel.numberOfLines = 2;
	[_peisongTimeLabel sizeToFit];

	NSMutableParagraphStyle *paragraphStyle4 = [[NSMutableParagraphStyle alloc] init];
	paragraphStyle4.lineSpacing = 5;//行间距

	//设置字号和行间距
	NSDictionary *ats4 = @{
						   NSFontAttributeName : [UIFont systemFontOfSize:11.0f],
						   NSParagraphStyleAttributeName : paragraphStyle4,
						   };

	_peisongTimeLabel.attributedText = [[NSAttributedString alloc] initWithString:_peisongTimeLabel.text attributes:ats4];//设置行间距
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
