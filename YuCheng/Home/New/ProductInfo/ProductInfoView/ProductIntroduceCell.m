//
//  ProductIntroduceCell.m
//  YuCheng
//
//  Created by apple on 16/6/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ProductIntroduceCell.h"

@implementation ProductIntroduceCell

{
	NSArray *transparentImageArr;
	NSArray *transparentTitleArr;
	NSArray *transparentIntroduceArr;

	NSArray *textureImageArr;
	NSArray *textureTitleArr;
	NSArray *textureIntroduceArr;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
		self.backgroundColor = [UIColor clearColor];
		[self createData];
	}
	return self;
}

- (void)createData {
	transparentImageArr = @[@"yc-90.png", @"yc-91.png", @"yc-92.png", @"yc-93.png", @"yc-94.png"];
	transparentTitleArr = @[@"玻璃种", @"冰玻种", @"冰种", @"糯冰种", @"细糯种"];
	transparentIntroduceArr = @[@"透明\n内部汇聚光较强\n多数光线可透过\n内部特征清晰可见\n标注：\n透明", @"半透明\n内部汇聚光强\n大部分光线可透过\n内部特征可见\n标注：\n三分之二透明", @"尚透明\n内部汇聚光弱\n部分光线可透过\n内部特征可见\n标注：\n二分之一透明", @"微透明\n内部有微量汇聚光\n部分光线可透过\n内部特征模糊可见\n网站标注：\n略微透明", @"不透明\n内部无汇聚光\n基本无光线透过\n内部特征不可见\n网站标注：\n不透明"];

	textureImageArr = @[@"yc-95.png", @"yc-96.png", @"yc-97.png", @"yc-98.png", @"yc-99.png"];
	textureTitleArr = @[@"极细/极纯净", @"细/纯净", @"较细/较纯净", @"粗/尚纯净", @"较粗/不纯净"];
	textureIntroduceArr = @[@"矿物颗粒小于0.1mm\n结构非常细腻致密，粒度均匀，10倍放大镜下不见粒度及复合原生、次生矿物充填痕隙。 未见内外特征，或仅在不显眼处有点状物、絮状物，对整体美观无影响。", @"矿物颗粒小于0.1~0.5mm\n结构细腻致密，粒度均匀，10倍放大镜下不见粒度及复合原生、次生矿物充填痕隙，偶见翠性。 细微的内、外特征，肉眼较难见，对整体美观几乎无影响。", @"矿物颗粒小于0.5～1.0mm\n结构致密，粒度尚均匀，10倍放大镜下见少量粒度及复合原生、次生矿物充填痕隙，偶见翠性。 具较明显的内、外特征，肉眼较可见，对整体美观有轻微影响。", @"矿物颗粒小于1.0～2.0mm\n结构不够致密，粒度不均匀。10倍放大镜下见细小复合原生及次生矿物充填痕隙，见多量翠性。 具细微的内、外特征，肉眼易见，对整体美观有影响。", @"矿物颗粒大于2.0mm\n结构疏松，粒度大小悬殊。肉眼可见痕、复合原生及次生矿物充填痕隙等，见大量翠性。 具细微的内、外特征，肉眼易见，对整体美观和有较明显影响。"];
}

- (void)createView {
	self.backView = [[UIView alloc] init];
	_backView.backgroundColor = [UIColor whiteColor];
	_backView.alpha = 0.98;
	_backView.userInteractionEnabled = NO;
	[self.contentView addSubview:_backView];

	self.titleLabel = [[UILabel alloc] init];
	_titleLabel.font = font(11);
	_titleLabel.textAlignment = NSTextAlignmentCenter;
	_titleLabel.textColor = [UIColor colorWithHexString:@"#717071"];
	[self.contentView addSubview:_titleLabel];

//	self.lineView = [[UIView alloc] init];
//	_lineView.backgroundColor = [UIColor colorWithHexString:@"#717071"];
//	[self.contentView addSubview:_lineView];

	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	flowLayout.itemSize = CGSizeMake(UNITHEIGHT * 90, UNITHEIGHT * 270);
	flowLayout.sectionInset = UIEdgeInsetsMake(UNITHEIGHT * 12.9, UNITHEIGHT * 30, UNITHEIGHT * 45.5, UNITHEIGHT * 30);
	flowLayout.minimumInteritemSpacing = UNITHEIGHT * 10;
	flowLayout.minimumLineSpacing = UNITHEIGHT * 10;

	self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(UNITHEIGHT * 10, UNITHEIGHT * 50, WIDTH - UNITHEIGHT * 20, UNITHEIGHT * 575) collectionViewLayout:flowLayout];
	_collectionView.delegate = self;
	_collectionView.dataSource = self;
	_collectionView.bounces = NO;
	_collectionView.userInteractionEnabled = NO;
	_collectionView.hidden = YES;
	_collectionView.backgroundColor = [UIColor whiteColor];
	[self.contentView addSubview:_collectionView];

	[_collectionView registerClass:[IntroduceCollectionCell class] forCellWithReuseIdentifier:@"introduceCell"];
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
		make.height.mas_equalTo(UNITHEIGHT * 20);
		make.top.mas_equalTo(_backView).with.offset(UNITHEIGHT * 13);
	}];

//	[_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(UNITHEIGHT * 11);
//		make.left.mas_equalTo(_backView).with.offset(UNITHEIGHT * 30);
//		make.right.mas_equalTo(_backView).with.offset(-UNITHEIGHT * 30);
//		make.height.mas_equalTo(1);
//	}];
}

#pragma mark - collectionDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	IntroduceCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"introduceCell" forIndexPath:indexPath];

	if (_isTransparent) {
		cell.headImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", transparentImageArr[indexPath.row]]];
		cell.titleLabel.text = [NSString stringWithFormat:@"%@", transparentTitleArr[indexPath.row]];
		cell.introduceLabel.text = [NSString stringWithFormat:@"%@", transparentIntroduceArr[indexPath.row]];
		_titleLabel.text = @"翡翠透明度";
	} else {
		cell.headImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", textureImageArr[indexPath.row]]];
		cell.titleLabel.text = [NSString stringWithFormat:@"%@", textureTitleArr[indexPath.row]];
		cell.introduceLabel.text = [NSString stringWithFormat:@"%@", textureIntroduceArr[indexPath.row]];
		_titleLabel.text = @"翡翠的质地";
		[cell.introduceLabel sizeToFit];
	}

	return cell;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
