//
//  personalStoreVC.m
//  YuCheng
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "personalStoreVC.h"
#import "NewCollectionCell.h"
#import "MyStoreHeadView.h"
#import "ProductInfoVC.h"
#import "PersonalOneCollectionCell.h"
#import "MyFlowLayout.h"
#import "PersonalHeadCell.h"
#import "ProductModel.h"

@interface personalStoreVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MyFlowLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collection;

@property (nonatomic, strong) NSMutableArray *goodsArr;

@property (nonatomic, assign) NSInteger pageData;

@property (nonatomic, copy) NSString *bannerStr;

@end

@implementation personalStoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.title = _titleStr;

	[self createView];

	[self createData];

	[self createRefresh];
}



#pragma mark - createRefresh
- (void)createRefresh {
	// 下拉刷新
	MJRefreshGifHeader *header = [MJRefreshGifHeader  headerWithRefreshingTarget:self refreshingAction:@selector(headerRefersh)];
	self.collection.mj_header = header;

	MJRefreshBackFooter *footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefersh)];
	self.collection.mj_footer = footer;
}

- (void)headerRefersh {
	[self.collection.mj_header endRefreshing];
}

- (void)footerRefersh {
	_pageData += 1;

	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/goodsList.php?act=shop" params:@{@"supplier_id" : _supplier_id, @"page" : [NSString stringWithFormat:@"%ld", (long)_pageData]} Success:^(id responseObject) {

		NSMutableArray *tempArr = [ProductModel BaseModel:responseObject[@"goods_list"]];
		[_goodsArr addObjectsFromArray:tempArr];

		dispatch_async(dispatch_get_main_queue(), ^{
			if (_goodsArr.count > 0) {
				[_collection reloadData];
			}
			[self.collection.mj_footer endRefreshing];
		});

	} Failed:^(NSError *error) {
		
	}];

}



#pragma mark - createData
- (void)createData {
	_pageData = 1;
	_goodsArr = [NSMutableArray arrayWithCapacity:0];
	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/goodsList.php?act=shop" params:@{@"supplier_id" : _supplier_id} Success:^(id responseObject) {

		_goodsArr = [ProductModel BaseModel:responseObject[@"goods_list"]];

		dispatch_async(dispatch_get_main_queue(), ^{
			if (_goodsArr.count > 0) {
				[_collection reloadData];
				_bannerStr = [NSString stringWithFormat:@"%@%@", API_BASE_URL, responseObject[@"supplier"][@"shop_index_img"]];
			}
		});

	} Failed:^(NSError *error) {

	}];
}

#pragma mark - creareView
- (void)createView {
	self.automaticallyAdjustsScrollViewInsets = NO;
	MyFlowLayout *flowLayout = [[MyFlowLayout alloc] init];
	flowLayout.MyDelegate = self;
//	flowLayout.itemSize = CGSizeMake((WIDTH - UNITHEIGHT * 30.0f) / 2, UNITHEIGHT * 238.1);
//	flowLayout.minimumInteritemSpacing = 10;
//	flowLayout.minimumLineSpacing = 10;
//	flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);

	self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64) collectionViewLayout:flowLayout];
	[self.view addSubview:_collection];
	_collection.backgroundColor = [UIColor colorWithHexString:@"#E5E5E5"];
	_collection.delegate = self;
	_collection.dataSource = self;
	_collection.showsVerticalScrollIndicator = NO;

	[_collection registerClass:[NewCollectionCell class] forCellWithReuseIdentifier:@"personalStoreCell"];

	[_collection registerClass:[PersonalOneCollectionCell class] forCellWithReuseIdentifier:@"personalOneCell"];

	[_collection registerClass:[PersonalHeadCell class] forCellWithReuseIdentifier:@"personalHeadCell"];

	[_collection registerClass:[MyStoreHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"personalStoreHeadCell"];

}

#pragma mark - collectionDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return _goodsArr.count + 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0) {
		PersonalHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"personalHeadCell" forIndexPath:indexPath];
		[cell.headImageView sd_setImageWithURL:[NSURL URLWithString:_bannerStr] placeholderImage:[UIImage imageNamed:@""]];

		return cell;
	} else if (indexPath.row == 2) {
		PersonalOneCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"personalOneCell" forIndexPath:indexPath];
		cell.titleLabel.text = _titleStr;

		return cell;
	} else {
		NewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"personalStoreCell" forIndexPath:indexPath];
		cell.layer.masksToBounds = YES;
		cell.layer.cornerRadius = UNITHEIGHT * 2;
		if (indexPath.row == 1) {
			cell.model = _goodsArr.firstObject;
		} else {
			cell.model = _goodsArr[indexPath.row - 2];
		}

		return cell;
	}
}



#pragma mark - collectionOneCell
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

	if (indexPath.item == 0) {
		return CGSizeMake(WIDTH, UNITHEIGHT * 193);
	} else if (indexPath.item == 2) {

		return CGSizeMake((WIDTH - UNITHEIGHT * 30.0f) / 2, UNITHEIGHT * 56);
	} else {

		return CGSizeMake((WIDTH - UNITHEIGHT * 30.0f) / 2, UNITHEIGHT * 238.1);
	}
}

#pragma mark - head
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//	return 1;
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//
//	return CGSizeMake(WIDTH, UNITHEIGHT * 193);
//}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//
//	MyStoreHeadView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"personalStoreHeadCell" forIndexPath:indexPath];
//
//	return cell;
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.item != 0 && indexPath.item != 2) {

		ProductInfoVC *productVC = [[ProductInfoVC alloc] init];
		productVC.stats = normalStats;

		if (indexPath.row == 1) {
			productVC.goodsID = [_goodsArr.firstObject goods_id];
		} else {
			productVC.goodsID = [_goodsArr[indexPath.row - 2] goods_id];
		}

		[self.navigationController pushViewController:productVC animated:YES];
	}
}



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
	return NO;
}



#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.tabBarController.tabBar.hidden = YES;
//	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
	self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	self.navigationController.navigationBar.hidden = NO;
//	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	self.tabBarController.tabBar.hidden = NO;
//	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
