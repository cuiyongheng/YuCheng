//
//  SellOutVC.m
//  YuCheng
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SellOutVC.h"
#import "NewCollectionCell.h"
#import "ProductInfoVC.h"
#import "ProductModel.h"

@interface SellOutVC ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collection;

@property (nonatomic, strong) NSMutableArray *ProductArr;

@property (nonatomic, assign) NSInteger pageData;

@end

@implementation SellOutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.title = @"达人推荐";

	[self createView];

	[self createData];

	[self createRefresh];

	self.navigationItem.rightBarButtonItem = nil;

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
	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/goodsList.php?act=bought" params:@{@"page" : [NSString stringWithFormat:@"%ld", (long)_pageData]} Success:^(id responseObject) {
		NSMutableArray *tempArr = [ProductModel BaseModel:responseObject[@"goods_list"]];
		[_ProductArr addObjectsFromArray:tempArr];

		dispatch_async(dispatch_get_main_queue(), ^{
			[_collection reloadData];
			[self.collection.mj_footer endRefreshing];
		});
	} Failed:^(NSError *error) {

	}];
}



#pragma mark - createData 
- (void)createData {
	_pageData = 1;
	_ProductArr = [NSMutableArray arrayWithCapacity:0];
	[NetWorkingTool GetNetWorking:@"http://www.jadechina.cn/mapi/goodsList.php?act=bought" Params:nil Success:^(id responseObject) {
		_ProductArr = [ProductModel BaseModel:responseObject[@"goods_list"]];

		dispatch_async(dispatch_get_main_queue(), ^{
			[_collection reloadData];
		});
	} Failed:^(NSError *error) {

	}];
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

}



#pragma mark - collectionDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return _ProductArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	NewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newCell" forIndexPath:indexPath];
	cell.selloutLabel.hidden = NO;
	cell.model = _ProductArr[indexPath.row];
	cell.layer.masksToBounds = YES;
	cell.layer.cornerRadius = UNITHEIGHT * 2;
	
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	ProductInfoVC *productVC = [[ProductInfoVC alloc] init];
	productVC.stats = sellOut;
	productVC.goodsID = [_ProductArr[indexPath.row] goods_id];
	[self.navigationController pushViewController:productVC animated:YES];
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
