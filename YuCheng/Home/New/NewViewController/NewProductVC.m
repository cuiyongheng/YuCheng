//
//  NewProductVC.m
//  YuCheng
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NewProductVC.h"
#import "NewCollectionCell.h"
#import "NewHeadCell.h"
#import "ProductInfoVC.h"
#import "ProductModel.h"
#import "ClassifyCollectionCell.h"
#import "BreedModel.h"
#import "ChooseModel.h"
#import "ChooseHearCell.h"
#import "ChooseFootCel.h"

@interface NewProductVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, NewCollectionCellDelegate, ChooseFootCelDelegate>

@property (nonatomic, strong) UICollectionView *collection;

@property (nonatomic, strong) NSMutableArray *productArr;

@property (nonatomic, strong) UISegmentedControl *segment;

@property (nonatomic, strong) UICollectionView *segCollection;

@property (nonatomic, assign) BOOL isLeftFold;

@property (nonatomic, assign) BOOL isRightFold;

@property (nonatomic, assign) BOOL ismiddleFold;

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UIButton *middleButton;



@property (nonatomic, strong) NSMutableArray *breedArr;// 品类
@property (nonatomic, strong) NSMutableArray *autoArr;// 智能排序
@property (nonatomic, strong) NSMutableArray *chooseArr;// 筛选

@property (nonatomic, strong) NSMutableArray *goodsArr;

@property (nonatomic, assign) NSInteger chooseInt;

@property (nonatomic, strong)  NSMutableDictionary *chooseDic;

@property (nonatomic, strong) NSIndexPath *myIndexPath;

@property (nonatomic, strong) NSIndexPath *twoIndexPath;

@property (nonatomic, strong) NSIndexPath *threeIndexPath;

@property (nonatomic, strong) NSIndexPath *fourIndexPath;

@property (nonatomic, strong) NSIndexPath *fiveIndexPath;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) NSInteger choosePage;

@property (nonatomic, strong) NSMutableDictionary *chooseParamsDic;

@property (nonatomic, strong) NSMutableDictionary *tempDic;

@end

@implementation NewProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	[self createView];

	[self createData];

	[self createRefresh];

	self.navigationItem.rightBarButtonItem = nil;
	self.view.backgroundColor = [UIColor colorWithHexString:@"#E5E5E5"];
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

	_page += 1;
	if (_isNewProduct) {

		[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/goodsList.php?act=new" params:@{@"page" : [NSString stringWithFormat:@"%ld", (long)_page]} Success:^(id responseObject) {
			
			NSMutableArray *tempArr = [ProductModel BaseModel:responseObject[@"goods_list"]];
			[_productArr addObjectsFromArray:tempArr];

			dispatch_async(dispatch_get_main_queue(), ^{
				[_collection reloadData];
				[self.collection.mj_footer endRefreshing];
			});

		} Failed:^(NSError *error) {
			
		}];
	} else {
		_choosePage += 1;
		NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:_chooseParamsDic[@"chooseParamsDic"]];
		[tempDic setObject:[NSString stringWithFormat:@"%ld" ,(long)_choosePage] forKey:@"page"];

		if (_chooseParamsDic.count > 0) {
			[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/goodsList.php?act=filter" params:tempDic Success:^(id responseObject) {

				//				_breedArr = [BreedModel BaseModel:responseObject[@"category_list"]];
				//				_autoArr = [NSMutableArray arrayWithObjects:@"人气", @"最新", @"价格", nil];
				//				_chooseArr = [ChooseModel BaseModel:responseObject[@"attr_list"]];
				NSMutableArray *tempArr = [ProductModel BaseModel:responseObject[@"goods_list"]];
				[_productArr addObjectsFromArray:tempArr];

				dispatch_async(dispatch_get_main_queue(), ^{
					[_segCollection reloadData];
					[_collection reloadData];
					[self.collection.mj_footer endRefreshing];
				});

			} Failed:^(NSError *error) {
				
			}];

		} else {

			NSDictionary *paramDic;
			if (_cat_id) {
				paramDic = @{@"cat_id" : _cat_id, @"page" : [NSString stringWithFormat:@"%ld", (long)_choosePage]};
			} else {
				paramDic = @{@"attr_key" : _attr_key, @"page" : [NSString stringWithFormat:@"%ld", (long)_choosePage]};
			}

			[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/goodsList.php?act=filter" params:paramDic Success:^(id responseObject) {

//				_breedArr = [BreedModel BaseModel:responseObject[@"category_list"]];
//				_autoArr = [NSMutableArray arrayWithObjects:@"人气", @"最新", @"价格", nil];
//				_chooseArr = [ChooseModel BaseModel:responseObject[@"attr_list"]];
				NSMutableArray *tempArr = [ProductModel BaseModel:responseObject[@"goods_list"]];
				[_productArr addObjectsFromArray:tempArr];

				dispatch_async(dispatch_get_main_queue(), ^{
					[_segCollection reloadData];
					[_collection reloadData];
					[self.collection.mj_footer endRefreshing];
				});

			} Failed:^(NSError *error) {
				
			}];
		}
	}
}



#pragma mark - createData
- (void)createData {
	_chooseDic = [NSMutableDictionary dictionaryWithCapacity:0];
	_page = 1;
	_choosePage = 1;
	_chooseParamsDic = [NSMutableDictionary dictionaryWithCapacity:0];

	if (_isNewProduct) {
		self.title = @"新品";
		// 新品页
		_productArr = [NSMutableArray arrayWithCapacity:0];
		[NetWorkingTool GetNetWorking:@"http://www.jadechina.cn/mapi/goodsList.php?act=new" Params:nil Success:^(id responseObject) {

			_productArr = [ProductModel BaseModel:responseObject[@"goods_list"]];

			dispatch_async(dispatch_get_main_queue(), ^{
				[_collection reloadData];
			});

		} Failed:^(NSError *error) {
			
		}];
	} else {
		// 筛选页
		//		self.breedArr = [NSMutableArray arrayWithCapacity:0];
		self.title = [NSString stringWithFormat:@"%@", _attr_key];
		NSDictionary *paramDic;
		if (_cat_id) {
			paramDic = @{@"cat_id" : _cat_id};
		} else {
			paramDic = @{@"attr_key" : _attr_key};
		}

		_breedArr = [NSMutableArray arrayWithCapacity:0];
		_productArr = [NSMutableArray arrayWithCapacity:0];
		_chooseArr = [NSMutableArray arrayWithCapacity:0];

		[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/goodsList.php?act=filter" params:paramDic Success:^(id responseObject) {

			_breedArr = [BreedModel BaseModel:responseObject[@"category_list"]];
			_autoArr = [NSMutableArray arrayWithObjects:@"人气", @"最新", @"价格", nil];
			_productArr = [ProductModel BaseModel:responseObject[@"goods_list"]];
			_chooseArr = [ChooseModel BaseModel:responseObject[@"attr_list"]];

			dispatch_async(dispatch_get_main_queue(), ^{
				[_segCollection reloadData];
				[_collection reloadData];

			});

		} Failed:^(NSError *error) {
			
		}];
	}
}



#pragma mark - createView
- (void)createView {
	self.automaticallyAdjustsScrollViewInsets = NO;
	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	flowLayout.itemSize = CGSizeMake((WIDTH - UNITHEIGHT * 30.0f) / 2, UNITHEIGHT * 238.1);
	flowLayout.minimumInteritemSpacing = UNITHEIGHT * 10;
	flowLayout.minimumLineSpacing = UNITHEIGHT * 10;
	flowLayout.sectionInset = UIEdgeInsetsMake(0, UNITHEIGHT * 10, 0, UNITHEIGHT * 10);

	self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64) collectionViewLayout:flowLayout];
	[self.view addSubview:_collection];
	_collection.backgroundColor = [UIColor colorWithHexString:@"#E5E5E5"];
	_collection.delegate = self;
	_collection.dataSource = self;
	_collection.showsVerticalScrollIndicator = NO;

	[_collection registerClass:[NewCollectionCell class] forCellWithReuseIdentifier:@"newCell"];

	[_collection registerClass:[NewHeadCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"newHeadCell"];

	[_collection registerClass:[ChooseFootCel class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"chooseFootCell"];


	// 筛选页
	if (!_isNewProduct) {
		self.collection.frame = CGRectMake(0, 64 + UNITHEIGHT * 35 + UNITHEIGHT * 10, WIDTH, HEIGHT - 64 - UNITHEIGHT * 45);

		// seg
//		self.segment = [[UISegmentedControl alloc] initWithItems:@[@"手镯", @"智能排序", @"筛选"]];
//		_segment.frame = CGRectMake(-UNITHEIGHT * 3, 64, WIDTH + UNITHEIGHT * 6, UNITHEIGHT * 43.5);
//		_segment.tintColor = [UIColor whiteColor];
//		_segment.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
//		[_segment addTarget:self action:@selector(classifyAction:) forControlEvents:UIControlEventValueChanged];
//		_segment.selectedSegmentIndex = 0;
//		[self.view addSubview:_segment];
//
//		UIFont *font = [UIFont boldSystemFontOfSize:12.0f];
//		NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
//		[_segment setTitleTextAttributes:attributes forState:UIControlStateNormal];
//		NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
//		NSDictionary *selectdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#792b34"],NSForegroundColorAttributeName,nil];
//		[_segment setTitleTextAttributes:dic forState:UIControlStateNormal];
//		[_segment setTitleTextAttributes:selectdic forState:UIControlStateSelected];

		self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
		_leftButton.frame = CGRectMake(0, 65, WIDTH / 3, UNITHEIGHT * 35);
		_leftButton.layer.borderWidth = 1;
		_leftButton.layer.borderColor = [UIColor whiteColor].CGColor;
		_leftButton.backgroundColor = [UIColor whiteColor];
		[_leftButton setTitle:@"品类" forState:UIControlStateNormal];
		[_leftButton setTitleColor:[UIColor colorWithHexString:@"#9f9fa0"] forState:UIControlStateNormal];
		_leftButton.titleLabel.font = font(16);
		[_leftButton addTarget:self action:@selector(classifyAction:) forControlEvents:UIControlEventTouchUpInside];
		_leftButton.tag = 200000;
		[self.view addSubview:_leftButton];

		self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
		_rightButton.frame = CGRectMake((WIDTH / 3) * 2, 65, WIDTH / 3, UNITHEIGHT * 35);
		_rightButton.layer.borderWidth = 1;
		_rightButton.layer.borderColor = [UIColor whiteColor].CGColor;
		_rightButton.backgroundColor = [UIColor whiteColor];
		[_rightButton setTitle:@"筛选" forState:UIControlStateNormal];
		[_rightButton setTitleColor:[UIColor colorWithHexString:@"#9f9fa0"] forState:UIControlStateNormal];
		[_rightButton addTarget:self action:@selector(classifyAction:) forControlEvents:UIControlEventTouchUpInside];
		_rightButton.titleLabel.font = font(16);
		_rightButton.tag = 200002;
		[self.view addSubview:_rightButton];

		self.middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
		_middleButton.frame = CGRectMake(WIDTH / 3, 65, WIDTH / 3, UNITHEIGHT * 35);
		_middleButton.layer.borderWidth = 1;
		_middleButton.layer.borderColor = [UIColor whiteColor].CGColor;
		_middleButton.titleLabel.font = font(16);
		_middleButton.backgroundColor = [UIColor whiteColor];
		[_middleButton setTitle:@"智能排序" forState:UIControlStateNormal];
		[_middleButton setTitleColor:[UIColor colorWithHexString:@"#9f9fa0"] forState:UIControlStateNormal];
		[_middleButton addTarget:self action:@selector(classifyAction:) forControlEvents:UIControlEventTouchUpInside];
		_middleButton.tag = 200001;
		[self.view addSubview:_middleButton];
	}

	UICollectionViewFlowLayout *segFlowLayout = [[UICollectionViewFlowLayout alloc] init];
	segFlowLayout.minimumInteritemSpacing = UNITHEIGHT * 10;
	segFlowLayout.minimumLineSpacing = UNITHEIGHT * 20;
	segFlowLayout.itemSize = CGSizeMake(WIDTH / 5, UNITHEIGHT * 30);
	segFlowLayout.sectionInset = UIEdgeInsetsMake(UNITHEIGHT * 30, UNITHEIGHT * 30, UNITHEIGHT * 30, UNITHEIGHT * 30);

	self.segCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64 + UNITHEIGHT * 35, WIDTH, UNITHEIGHT * 100) collectionViewLayout:segFlowLayout];
	self.segCollection.backgroundColor = [UIColor whiteColor];
	_segCollection.hidden = YES;
	_segCollection.delegate = self;
	_segCollection.dataSource = self;
	[self.view addSubview:_segCollection];

	[_segCollection registerClass:[ClassifyCollectionCell class] forCellWithReuseIdentifier:@"classifyCell"];

	[_segCollection registerClass:[ChooseHearCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"chooseCell"];

	[_segCollection registerClass:[ChooseFootCel class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"chooseFootCell"];
}



#pragma mark - collectionDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	if (collectionView == _collection) {
		return _productArr.count;
	} else {
		if (_chooseInt == 1) {
			return _breedArr.count;
		} else if (_chooseInt == 2) {
			return 3;
		} else if (_chooseInt == 3) {
			return [[_chooseArr[section] attr_values] count];
		} else {
			return 0;
		}
	}
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

	if (collectionView == _collection) {

		NewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newCell" forIndexPath:indexPath];
		cell.delegate = self;
		cell.model = _productArr[indexPath.row];
		cell.layer.masksToBounds = YES;
		cell.layer.cornerRadius = UNITHEIGHT * 2;

		return cell;
	} else {

		if (_chooseInt == 1) {
			ClassifyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"classifyCell" forIndexPath:indexPath];
			BreedModel *breedModel = _breedArr[indexPath.row];
			cell.label.text = [NSString stringWithFormat:@"%@", breedModel.cat_name];
			return cell;
		} else if (_chooseInt == 2) {
			ClassifyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"classifyCell" forIndexPath:indexPath];
			cell.label.text = [NSString stringWithFormat:@"%@", _autoArr[indexPath.row]];
			return cell;
		} else {
			ClassifyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"classifyCell" forIndexPath:indexPath];
			ChooseModel *model = _chooseArr[indexPath.section];
			cell.label.text = [NSString stringWithFormat:@"%@", model.attr_values[indexPath.row]];
			cell.label.tag = 300000 + (indexPath.section * 10000) + indexPath.row;
			return cell;
		}
	}
}



#pragma mark - head
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	if (_chooseInt == 3) {
		if (collectionView == _collection) {
			return 1;
		} else {
			return _chooseArr.count;
		}
	} else {
		return 1;
	}
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
	if (_isNewProduct) {
		return CGSizeMake(WIDTH, UNITHEIGHT * 206.4);
	} else {
		if (_chooseInt == 3) {
			if (collectionView == _collection) {
				return CGSizeMake(0, 0);
			} else {
				return CGSizeMake(WIDTH, UNITHEIGHT * 30);
			}
		} else {
			return CGSizeMake(0, 0);
		}
	}
}

#pragma mark - foot
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
	if (_chooseInt == 3) {
		if (section == _chooseArr.count - 1) {
			if (collectionView == _collection) {
				return CGSizeMake(0, 0);
			} else {
				return CGSizeMake(WIDTH, UNITHEIGHT * 50);
			}
		} else {
			return CGSizeMake(0, 0);
		}
	} else {
		return CGSizeMake(0, 0);
	}
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

	if (kind == UICollectionElementKindSectionHeader) {

		if (collectionView == _collection) {
			NewHeadCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"newHeadCell" forIndexPath:indexPath];

			return cell;
		} else {
			ChooseHearCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"chooseCell" forIndexPath:indexPath];
			ChooseModel *headModel = _chooseArr[indexPath.section];
			cell.chooselabel.text = [NSString stringWithFormat:@"%@", headModel.attr_name];

			return cell;
		}
	} else {
		ChooseFootCel *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"chooseFootCell" forIndexPath:indexPath];
		cell.delegate = self;

		return cell;
	}

}



#pragma mark - 筛选
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	if (collectionView == _collection) {
		ProductInfoVC *productVC = [[ProductInfoVC alloc] init];
		productVC.stats = normalStats;
		productVC.goodsID = [_productArr[indexPath.row] goods_id];
		[self.navigationController pushViewController:productVC animated:YES];
	} else {
		_choosePage = 1;
		// 筛选
		NSDictionary *paramDic;
		if (_chooseInt == 1) {
			paramDic = @{@"cat_id" : [_breedArr[indexPath.row] cat_id]};
			[_chooseParamsDic setObject:@{@"cat_id" : [_breedArr[indexPath.row] cat_id], @"page" : [NSString stringWithFormat:@"%ld" ,(long)_choosePage]} forKey:@"chooseParamsDic"];
		} else if (_chooseInt == 2) {
			if (indexPath.row == 0) {
				paramDic = @{@"orderby" : @"hot"};
				[_chooseParamsDic setObject:@{@"orderby" : @"hot", @"page" : [NSString stringWithFormat:@"%ld" ,(long)_choosePage]} forKey:@"chooseParamsDic"];
			} else if (indexPath.row == 1) {
				paramDic = @{@"orderby" : @"time"};
				[_chooseParamsDic setObject:@{@"orderby" : @"time", @"page" : [NSString stringWithFormat:@"%ld" ,(long)_choosePage]} forKey:@"chooseParamsDic"];
			} else if (indexPath.row == 2) {
				paramDic = @{@"orderby" : @"price"};
				[_chooseParamsDic setObject:@{@"orderby" : @"price", @"page" : [NSString stringWithFormat:@"%ld" ,(long)_choosePage]} forKey:@"chooseParamsDic"];
			}
		}


		if (_chooseInt == 1) {
			[self classifyAction:_leftButton];
		} else if (_chooseInt == 2) {
			[self classifyAction:_middleButton];
		}

		if (_chooseInt == 1 || _chooseInt == 2) {
			_breedArr = [NSMutableArray arrayWithCapacity:0];
			_productArr = [NSMutableArray arrayWithCapacity:0];
			_chooseArr = [NSMutableArray arrayWithCapacity:0];
			[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/goodsList.php?act=filter" params:paramDic Success:^(id responseObject) {

				_breedArr = [BreedModel BaseModel:responseObject[@"category_list"]];
				_autoArr = [NSMutableArray arrayWithObjects:@"人气", @"最新", @"价格", nil];
				_productArr = [ProductModel BaseModel:responseObject[@"goods_list"]];
				_chooseArr = [ChooseModel BaseModel:responseObject[@"attr_list"]];

				dispatch_async(dispatch_get_main_queue(), ^{
					[_segCollection reloadData];
					[_collection reloadData];

				});

			} Failed:^(NSError *error) {
				
			}];
		} else if (_chooseInt == 3) {

			if (indexPath.section == 0) {

				for (NSInteger i = 0; i < 100; i++) {
					UILabel *label = (UILabel *)[self.view viewWithTag:300000 + i];
					label.backgroundColor = [UIColor whiteColor];
				}
				UILabel *label = (UILabel *)[self.view viewWithTag:300000 + indexPath.row];
				label.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
				_myIndexPath = indexPath;
				[_chooseDic setObject:label.text forKey:@"0"];
			} else if (indexPath.section == 1) {
				for (NSInteger i = 0; i < 100; i++) {
					UILabel *label = (UILabel *)[self.view viewWithTag:310000 + i];
					label.backgroundColor = [UIColor whiteColor];
				}
				UILabel *label = (UILabel *)[self.view viewWithTag:310000 + indexPath.row];
				label.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
				_twoIndexPath = indexPath;
				[_chooseDic setObject:label.text forKey:@"1"];
			} else if (indexPath.section == 2) {
				for (NSInteger i = 0; i < 100; i++) {
					UILabel *label = (UILabel *)[self.view viewWithTag:320000 + i];
					label.backgroundColor = [UIColor whiteColor];
				}
				_threeIndexPath = indexPath;
				UILabel *label = (UILabel *)[self.view viewWithTag:320000 + indexPath.row];
				label.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
				[_chooseDic setObject:label.text forKey:@"2"];
			} else if (indexPath.section == 3) {
				for (NSInteger i = 0; i < 100; i++) {
					UILabel *label = (UILabel *)[self.view viewWithTag:330000 + i];
					label.backgroundColor = [UIColor whiteColor];
				}
				UILabel *label = (UILabel *)[self.view viewWithTag:330000 + indexPath.row];
				label.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
				_fourIndexPath = indexPath;
				[_chooseDic setObject:label.text forKey:@"3"];
			} else if (indexPath.section == 4) {
				for (NSInteger i = 0; i < 100; i++) {
					UILabel *label = (UILabel *)[self.view viewWithTag:340000 + i];
					label.backgroundColor = [UIColor whiteColor];
				}
				UILabel *label = (UILabel *)[self.view viewWithTag:340000 + indexPath.row];
				label.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
				_fiveIndexPath = indexPath;
				[_chooseDic setObject:label.text forKey:@"4"];
			}
		}
	}
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) {
	if (_chooseInt == 3) {

		if (indexPath.section == 0) {

			for (NSInteger i = 0; i < 100; i++) {
				UILabel *label = (UILabel *)[self.view viewWithTag:300000 + i];
				label.backgroundColor = [UIColor whiteColor];
			}
			if (_myIndexPath) {
				UILabel *label = (UILabel *)[self.view viewWithTag:300000 + _myIndexPath.row];
				label.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
			}
		} else if (indexPath.section == 1) {
			for (NSInteger i = 0; i < 100; i++) {
				UILabel *label = (UILabel *)[self.view viewWithTag:310000 + i];
				label.backgroundColor = [UIColor whiteColor];
			}
			if (_twoIndexPath) {
				UILabel *label = (UILabel *)[self.view viewWithTag:310000 + _twoIndexPath.row];
				label.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
			}
		} else if (indexPath.section == 2) {
			for (NSInteger i = 0; i < 100; i++) {
				UILabel *label = (UILabel *)[self.view viewWithTag:320000 + i];
				label.backgroundColor = [UIColor whiteColor];
			}
			if (_threeIndexPath) {
				UILabel *label = (UILabel *)[self.view viewWithTag:320000 + _threeIndexPath.row];
				label.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
			}
		} else if (indexPath.section == 3) {
			for (NSInteger i = 0; i < 100; i++) {
				UILabel *label = (UILabel *)[self.view viewWithTag:330000 + i];
				label.backgroundColor = [UIColor whiteColor];
			}
			if (_fourIndexPath) {
				UILabel *label = (UILabel *)[self.view viewWithTag:330000 + _fourIndexPath.row];
				label.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
			}
		} else if (indexPath.section == 4) {
			for (NSInteger i = 0; i < 100; i++) {
				UILabel *label = (UILabel *)[self.view viewWithTag:340000 + i];
				label.backgroundColor = [UIColor whiteColor];
			}
			if (_fiveIndexPath) {
				UILabel *label = (UILabel *)[self.view viewWithTag:340000 + _fiveIndexPath.row];
				label.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
			}
		}
	}
}

- (void)chooseTureButton {
	NSString *str;
	_choosePage = 1;

	for (NSString *chooseStr in _chooseDic.allValues) {
		if (!str) {
			str = [NSString stringWithFormat:@"%@", chooseStr];
		} else {
			str = [NSString stringWithFormat:@"%@,%@", str, chooseStr];
		}
	}
	NSDictionary *paramsDic = @{@"attr_key" : str};
	[_chooseParamsDic setObject:@{@"attr_key" : str, @"page" : [NSString stringWithFormat:@"%ld", (long)_choosePage]} forKey:@"chooseParamsDic"];

	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/goodsList.php?act=filter" params:paramsDic Success:^(id responseObject) {

		_breedArr = [NSMutableArray arrayWithCapacity:0];
		_productArr = [NSMutableArray arrayWithCapacity:0];
		_chooseArr = [NSMutableArray arrayWithCapacity:0];

		_breedArr = [BreedModel BaseModel:responseObject[@"category_list"]];
		_autoArr = [NSMutableArray arrayWithObjects:@"人气", @"最新", @"价格", nil];
		_productArr = [ProductModel BaseModel:responseObject[@"goods_list"]];
		_chooseArr = [ChooseModel BaseModel:responseObject[@"attr_list"]];

		dispatch_async(dispatch_get_main_queue(), ^{
			[_segCollection reloadData];
			[_collection reloadData];
			[self classifyAction:_rightButton];
		});

	} Failed:^(NSError *error) {

	}];
}



//- (void)pushShopping:(UIButton *)button {
//	NSLog(@"购物车");
//}



#pragma mark - seg
- (void)classifyAction:(UIButton *)button {

	// 改变样式
	if (button.tag == 200000) {
		_isLeftFold = !_isLeftFold;
		if (_isLeftFold) {
			_segCollection.hidden = NO;
//			_leftButton.backgroundColor = [UIColor whiteColor];
			[_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

//			_rightButton.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
			[_rightButton setTitleColor:[UIColor colorWithHexString:@"9f9fa0"] forState:UIControlStateNormal];

//			_middleButton.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
			[_middleButton setTitleColor:[UIColor colorWithHexString:@"9f9fa0"] forState:UIControlStateNormal];
			_isRightFold = 0;
			_ismiddleFold = 0;
		} else {
			_segCollection.hidden = YES;
//			_leftButton.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
			[_leftButton setTitleColor:[UIColor colorWithHexString:@"9f9fa0"] forState:UIControlStateNormal];
		}
	} else if (button.tag == 200001) {
		_ismiddleFold = !_ismiddleFold;
		if (_ismiddleFold) {
			_segCollection.hidden = NO;
//			_middleButton.backgroundColor = [UIColor whiteColor];
			[_middleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

//			_rightButton.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
			[_rightButton setTitleColor:[UIColor colorWithHexString:@"9f9fa0"] forState:UIControlStateNormal];

//			_leftButton.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
			[_leftButton setTitleColor:[UIColor colorWithHexString:@"9f9fa0"] forState:UIControlStateNormal];
			_isRightFold = 0;
			_isLeftFold = 0;
		} else {
			_segCollection.hidden = YES;
//			_middleButton.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
			[_middleButton setTitleColor:[UIColor colorWithHexString:@"9f9fa0"] forState:UIControlStateNormal];
		}
	} else {
		_isRightFold = !_isRightFold;
		if (_isRightFold) {
			_segCollection.hidden = NO;
//			_rightButton.backgroundColor = [UIColor whiteColor];
			[_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

//			_middleButton.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
			[_middleButton setTitleColor:[UIColor colorWithHexString:@"9f9fa0"] forState:UIControlStateNormal];

//			_leftButton.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
			[_leftButton setTitleColor:[UIColor colorWithHexString:@"9f9fa0"] forState:UIControlStateNormal];
			_ismiddleFold = 0;
			_isLeftFold = 0;
		} else {
			_segCollection.hidden = YES;
//			_rightButton.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
			[_rightButton setTitleColor:[UIColor colorWithHexString:@"9f9fa0"] forState:UIControlStateNormal];
		}
	}

	// 改变尺寸
	if (button.tag == 200000) {
		_segCollection.frame = CGRectMake(0, 64 + UNITHEIGHT * 43.5, WIDTH, UNITHEIGHT * 240);
		_chooseInt = 1;

	} else if (button.tag == 200001) {
		_segCollection.frame = CGRectMake(0, 64 + UNITHEIGHT * 43.5, WIDTH, UNITHEIGHT * 80);
		_chooseInt = 2;

	} else {
		_segCollection.frame = CGRectMake(0, 64 + UNITHEIGHT * 43.5, WIDTH, UNITHEIGHT * 400);
		_chooseInt = 3;

	}



	for (NSInteger i = 0; i < 100; i++) {
		UILabel *label = (UILabel *)[self.view viewWithTag:300000 + i];
		label.backgroundColor = [UIColor whiteColor];
	}

	for (NSInteger i = 0; i < 100; i++) {
		UILabel *label = (UILabel *)[self.view viewWithTag:310000 + i];
		label.backgroundColor = [UIColor whiteColor];
	}
	for (NSInteger i = 0; i < 100; i++) {
		UILabel *label = (UILabel *)[self.view viewWithTag:320000 + i];
		label.backgroundColor = [UIColor whiteColor];
	}

	for (NSInteger i = 0; i < 100; i++) {
		UILabel *label = (UILabel *)[self.view viewWithTag:330000 + i];
		label.backgroundColor = [UIColor whiteColor];
	}

	for (NSInteger i = 0; i < 100; i++) {
		UILabel *label = (UILabel *)[self.view viewWithTag:340000 + i];
		label.backgroundColor = [UIColor whiteColor];
	}



	dispatch_async(dispatch_get_main_queue(), ^{
		[_segCollection reloadData];
	});
}



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
	return NO;
}



#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.tabBarController.tabBar.hidden = YES;
	self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	self.tabBarController.tabBar.hidden = NO;
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
