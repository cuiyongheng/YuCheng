//
//  SearchReturnVC.m
//  YuCheng
//
//  Created by apple on 16/7/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchReturnVC.h"
#import "NewCollectionCell.h"
#import "ProductModel.h"
#import "ProductInfoVC.h"

@interface SearchReturnVC ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collection;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray *collectionArr;

@end

@implementation SearchReturnVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.title = @"搜索结果";

	[self createView];

	[self createData];

	[self createRefresh];
}



#pragma mark - refresh
- (void)createRefresh {
	// 下拉刷新
	MJRefreshBackFooter *footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefersh)];
	self.collection.mj_footer = footer;
}

- (void)footerRefersh {
	_page += 1;

	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/goodsList.php?act=search" params:@{@"search_content" : _keywords, @"page" : [NSString stringWithFormat:@"%ld", _page], @"is_ajax" : @1} Success:^(id responseObject) {

		NSMutableArray *tempArr = [ProductModel BaseModel:responseObject[@"goods_list"]];
		[_collectionArr addObjectsFromArray:tempArr];

		dispatch_async(dispatch_get_main_queue(), ^{
			[_collection reloadData];
			[_collection.mj_footer endRefreshing];
		});

	} Failed:^(NSError *error) {
		
	}];

}


#pragma mark - createView
- (void)createView {
	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	flowLayout.itemSize = CGSizeMake((WIDTH - UNITHEIGHT * 30.0f) / 2, UNITHEIGHT * 238.1);
	flowLayout.minimumInteritemSpacing = UNITHEIGHT * 10;
	flowLayout.minimumLineSpacing = UNITHEIGHT * 10;
	flowLayout.sectionInset = UIEdgeInsetsMake(0, UNITHEIGHT * 10, 0, UNITHEIGHT * 10);

	self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 20) collectionViewLayout:flowLayout];
	self.collection.backgroundColor = [UIColor whiteColor];
	_collection.delegate = self;
	_collection.dataSource = self;
	[self.view addSubview:_collection];

	[_collection registerClass:[NewCollectionCell class] forCellWithReuseIdentifier:@"searchCell"];

}



#pragma mark - createData
- (void)createData {
	_page = 1;

	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/goodsList.php?act=search" params:@{@"search_content" : _keywords, @"is_ajax" : @1} Success:^(id responseObject) {


		_collectionArr = [ProductModel BaseModel:responseObject[@"goods_list"]];

		dispatch_async(dispatch_get_main_queue(), ^{
			[_collection reloadData];
		});

	} Failed:^(NSError *error) {

	}];
}



#pragma mark - tableViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return _collectionArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	NewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"searchCell" forIndexPath:indexPath];
	cell.layer.masksToBounds = YES;
	cell.layer.cornerRadius = UNITHEIGHT * 2;
	cell.model = _collectionArr[indexPath.item];

	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	ProductInfoVC *productVC = [[ProductInfoVC alloc] init];
	productVC.stats = normalStats;
	productVC.goodsID = [_collectionArr[indexPath.item] goods_id];
	[self.navigationController pushViewController:productVC animated:YES];

}



#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.tabBarController.tabBar.hidden = YES;

}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];

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
