//
//  ShopStoreFourCell.m
//  YuCheng
//
//  Created by apple on 16/6/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShopStoreFourCell.h"
#import "ShopStoreCollectionCell.h"

@implementation ShopStoreFourCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	self.titleLabel = [[UILabel alloc] init];
	_titleLabel.text = @"公司照片";
	_titleLabel.font = font(12);
	[self.contentView addSubview:_titleLabel];

	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	flowLayout.sectionInset = UIEdgeInsetsMake(0, UNITHEIGHT * 27.5, 0, UNITHEIGHT * 27.5);
	flowLayout.itemSize = CGSizeMake(UNITHEIGHT * 100, UNITHEIGHT * 146);
	flowLayout.minimumInteritemSpacing = UNITHEIGHT * 6;
	flowLayout.minimumLineSpacing = UNITHEIGHT * 6;

	self.collection = [[UICollectionView alloc] initWithFrame:self.contentView.frame collectionViewLayout:flowLayout];
	_collection.delegate = self;
	_collection.dataSource = self;
	_collection.bounces = NO;
	_collection.userInteractionEnabled = NO;
	_collection.showsVerticalScrollIndicator = NO;
	_collection.backgroundColor = [UIColor whiteColor];
	[self.contentView addSubview:_collection];

	[_collection registerClass:[ShopStoreCollectionCell class] forCellWithReuseIdentifier:@"shopStoreCollectionCell"];

}

- (void)layoutSubviews {
	[super layoutSubviews];
	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 27.5);
		make.height.mas_equalTo(UNITHEIGHT * 10);
		make.top.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 16.5);
	}];

	[_collection mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(UNITHEIGHT * 16.5);
		make.height.mas_equalTo(UNITHEIGHT * 305);
		make.left.right.mas_equalTo(self.contentView);
	}];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	ShopStoreCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shopStoreCollectionCell" forIndexPath:indexPath];

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
