//
//  ClassifyCell.m
//  YuCheng
//
//  Created by apple on 16/5/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ClassifyCell.h"
#import "ClassifyCollectionCell.h"
#import "BreedModel.h"

@implementation ClassifyCell

{
	NSMutableArray *collectArr;
	NSMutableArray *breedCollectArr;

	BOOL isOne;
	NSInteger breedCount;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];

		//		UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"玉城LOGO-15.jpg"]];
		//		imageView.frame = CGRectMake(-25, 0, [UIScreen mainScreen].bounds.size.width, 250);
		//
		//		self.backgroundView =  imageView;

		self.backgroundColor = [UIColor blackColor];

		breedCollectArr = [NSMutableArray arrayWithCapacity:0];
		isOne = 0;
	}
	return self;
}

- (void)createView {

	UIView *bottomView = [[UIView alloc] init];
	bottomView.frame = CGRectMake(0, 0, WIDTH, UNITHEIGHT * 149);
	bottomView.clipsToBounds = YES;
	bottomView.backgroundColor = [UIColor blackColor];
	[self.contentView addSubview:bottomView];

	self.backImageView = [[UIImageView alloc] init];
	_backImageView.frame = CGRectMake(0, -UNITHEIGHT * 40, WIDTH, UNITHEIGHT * 230);
	_backImageView.backgroundColor = [UIColor blackColor];
	[bottomView addSubview:_backImageView];

	self.backView = [[UIView alloc] init];
	_backView.backgroundColor = [UIColor blackColor];
	_backView.alpha = 0.3;
	_backView.userInteractionEnabled = NO;
	[self.contentView addSubview:_backView];

	self.titleLabel = [[UILabel alloc] init];
	_titleLabel.numberOfLines = 0;
	_titleLabel.textAlignment = NSTextAlignmentCenter;
	_titleLabel.font = boldFont(16.5);
	_titleLabel.textColor = [UIColor whiteColor];
	[self.contentView addSubview:_titleLabel];

	self.foldView = [[UIView alloc] init];
	_foldView.backgroundColor = [UIColor whiteColor];
	_foldView.hidden = YES;
	[self.contentView addSubview:_foldView];

	//	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foldView:)];
	//	[_foldView addGestureRecognizer:tap];
//
//	self.pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	[_pushButton addTarget:self action:@selector(pushButton:) forControlEvents:UIControlEventTouchUpInside];
//	//	[_pushButton setTitle:@"书包" forState:UIControlStateNormal];
//	[_pushButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//	_pushButton.backgroundColor = [UIColor yellowColor];
//	_pushButton.hidden = YES;
//	[self.contentView addSubview:_pushButton];

	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	flowLayout.minimumInteritemSpacing = UNITHEIGHT * 10;
	flowLayout.minimumLineSpacing = UNITHEIGHT * 10;
	flowLayout.itemSize = CGSizeMake(WIDTH / 5, UNITHEIGHT * 30);
	flowLayout.sectionInset = UIEdgeInsetsMake(UNITHEIGHT * 30, UNITHEIGHT * 30, UNITHEIGHT * 30, UNITHEIGHT * 30);

	self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, UNITHEIGHT * 55, WIDTH, UNITHEIGHT * 100) collectionViewLayout:flowLayout];
	_collectionView.delegate = self;
	_collectionView.dataSource = self;
	_collectionView.backgroundColor = [UIColor whiteColor];
	_collectionView.hidden = YES;
	_collectionView.bounces = NO;
	[self.contentView addSubview:_collectionView];

	[_collectionView registerClass:[ClassifyCollectionCell class] forCellWithReuseIdentifier:@"collectionCell"];

	_nameLabel = [[UILabel alloc] init];
	_nameLabel.font = font(16.5);
	_nameLabel.textAlignment = NSTextAlignmentCenter;
	_nameLabel.hidden = YES;
	_nameLabel.textAlignment = NSTextAlignmentCenter;
	_nameLabel.numberOfLines = 0;
	[self.contentView addSubview:_nameLabel];
	_nameLabel.textColor = [UIColor whiteColor];
	_nameLabel.backgroundColor = [UIColor blackColor];

}

//- (void)pushButton:(UIButton *)button {
//	[self.delegate pushNextVC];
//}


- (void)foldView:(UITapGestureRecognizer *)tap {

	//	[self.delegate foldToView:tap.view];

	//	[UIView animateWithDuration:0.4 animations:^{
	//		// 动画部分都写在block里
	//		tap.view.transform = CGAffineTransformScale(tap.view.transform, 1, (CGFloat)1 / (CGFloat)300);
	//	}];
	//
	//	[self performSelector:@selector(foldToView:) withObject:tap.view afterDelay:0.4];

	//	NSLog(@"%.2f", tap.view.frame.size.height);

}

- (void)foldToView:(UIView *)foldView {
	foldView.hidden = YES;
}


- (void)layoutSubviews {
	[super layoutSubviews];

	//	[_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
	//		make.left.right.mas_equalTo(self.contentView);
	//		make.height.mas_equalTo(240);
	//		make.top.mas_equalTo(self.contentView).with.offset(-40);
	//	}];

	[_backView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.bottom.mas_equalTo(self.contentView);
	}];

	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.centerY.mas_equalTo(self.contentView);
	}];

	[_foldView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.left.right.mas_equalTo(self.contentView);
		make.height.mas_equalTo(1);
	}];
//
//	[_pushButton mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.centerX.centerY.mas_equalTo(_foldView);
//		make.height.mas_equalTo(100);
//		make.width.mas_equalTo(100);
//	}];

	[_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(self.contentView);
		make.top.mas_equalTo(self.contentView);
		make.height.mas_equalTo(UNITHEIGHT * 55);
	}];

	[_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_nameLabel.mas_bottom);
		make.width.mas_equalTo(self.contentView);
		make.bottom.mas_equalTo(self.contentView);
	}];

}



#pragma mark - 视差效果
- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view
{
	CGRect rectInSuperview = [tableView convertRect:self.frame toView:view];

	float distanceFromCenter = CGRectGetHeight(view.frame)/2 - CGRectGetMinY(rectInSuperview);
	float difference = CGRectGetHeight(self.backImageView.frame) - CGRectGetHeight(self.frame);
	float move = (distanceFromCenter / CGRectGetHeight(view.frame)) * difference;

	CGRect imageRect = self.backImageView.frame;
	imageRect.origin.y = -(difference/2)+move;
	self.backImageView.frame = imageRect;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

	if (breedCollectArr.count == 0) {
		return collectArr.count;
	} else {
		return breedCount;
	}
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	ClassifyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
	if (breedCollectArr.count == 0) {
		cell.label.text = [NSString stringWithFormat:@"%@", collectArr[indexPath.row]];
	} else {
		cell.label.text = [NSString stringWithFormat:@"%@", breedCollectArr[indexPath.row]];
	}

	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	ClassifyCollectionCell *cell = (ClassifyCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
	
	[self.delegate pushNextVC:cell.label.text];
}



- (void)setModel:(ClassifyModel *)model {
	_model = model;
	_titleLabel.text = [NSString stringWithFormat:@"%@", model.attr_name];
	_nameLabel.text = [NSString stringWithFormat:@"%@", model.attr_name];

	collectArr = [NSMutableArray arrayWithArray:model.attr_values];

	dispatch_async(dispatch_get_main_queue(), ^{
		[_collectionView reloadData];
	});
}

- (void)setBreedArr:(NSMutableArray *)breedArr {
	_breedArr = breedArr;

	for (BreedModel *model in breedArr) {
		[breedCollectArr addObject:model.cat_name];
	}

	dispatch_async(dispatch_get_main_queue(), ^{
		[_collectionView reloadData];
	});

	if (breedArr.count) {
		breedCount = breedArr.count;
		isOne = 1;
	}


}

@end
