//
//  RecommendVC.m
//  YuCheng
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RecommendVC.h"
//#import "RecommendCell.h"
//#import "RecommendOtherCell.h"
#import "RecommendNewCell.h"
//#import "personalStoreVC.h"
#import "ShopStoreVC.h"
#import "RecommendModel.h"

@interface RecommendVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *page;

@property (nonatomic, strong) NSMutableArray *recommendArr;

@property (nonatomic, assign) NSInteger pageData;

@end

@implementation RecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.title = @"品牌商家";

	[self createView];

	[self createData];

	[self createRefresh];

	self.navigationItem.rightBarButtonItem = nil;

	[self.navigationController.navigationBar cnSetBackgroundColor:[UIColor whiteColor]];
}

#pragma mark - createRefresh
- (void)createRefresh {
	// 下拉刷新
	MJRefreshGifHeader *header = [MJRefreshGifHeader  headerWithRefreshingTarget:self refreshingAction:@selector(headerRefersh)];
	self.tableView.mj_header = header;

	MJRefreshBackFooter *footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefersh)];
	self.tableView.mj_footer = footer;
}

- (void)headerRefersh {
	[self.tableView.mj_header endRefreshing];
}

- (void)footerRefersh {
	_pageData += 1;

	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/supplierList.php" params:@{@"page" : [NSString stringWithFormat:@"%ld", (long)_pageData]} Success:^(id responseObject) {

		NSArray *arr = [RecommendModel BaseModel:responseObject[@"supplier_list"]];

		for (RecommendModel *model in arr) {
			if (model.goods_list) {
				[_recommendArr addObject:model];
			}
		}

		dispatch_async(dispatch_get_main_queue(), ^{
			if (_recommendArr.count > 0) {
				[_tableView reloadData];
			}
			[self.tableView.mj_footer endRefreshing];
		});

	} Failed:^(NSError *error) {

	}];
}

#pragma mark - createData
- (void)createData {
	_pageData = 1;
	self.recommendArr = [NSMutableArray arrayWithCapacity:0];
	[NetWorkingTool GetNetWorking:@"http://www.jadechina.cn/mapi/supplierList.php" Params:nil Success:^(id responseObject) {
		NSArray *arr = [RecommendModel BaseModel:responseObject[@"supplier_list"]];

		for (RecommendModel *model in arr) {
			if (model.goods_list) {
				[_recommendArr addObject:model];
			}
		}

		dispatch_async(dispatch_get_main_queue(), ^{
			if (_recommendArr.count > 0) {
				[_tableView reloadData];
			}
		});
	} Failed:^(NSError *error) {

	}];
}

#pragma mark - createView
- (void)createView {

	self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.rowHeight = UNITHEIGHT * 463.5;
	_tableView.showsVerticalScrollIndicator = NO;
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview:_tableView];

	[_tableView registerClass:[RecommendNewCell class] forCellReuseIdentifier:@"recommendCell"];

//	[_tableView registerClass:[RecommendOtherCell class] forCellReuseIdentifier:@"recommendOtherCell"];



	// headerView
//	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 183)];
//	headerView.backgroundColor = [UIColor clearColor];
//	_tableView.tableHeaderView = headerView;
//
//	// scroll
//	self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 183)];
//	_scrollView.showsHorizontalScrollIndicator = NO;
//	_scrollView.contentSize = CGSizeMake(WIDTH * 5, 0);
//	_scrollView.delegate = self;
//	_scrollView.pagingEnabled = YES;
//	[headerView addSubview:_scrollView];
//
//	for (NSInteger i = 15; i < 20; i++) {
//		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * (i - 15), 0, WIDTH, UNITWIDTH * 183)];
//		imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"玉城LOGO-%ld.jpg", (long)i]];
//		[_scrollView addSubview:imageView];
//	}
//	// page
//	self.page = [[UIPageControl alloc] init];
//	[headerView addSubview:_page];
//	_page.numberOfPages = 5;
//	_page.currentPageIndicatorTintColor = [UIColor whiteColor];
//	_page.pageIndicatorTintColor = [UIColor colorWithHexString:@"#817a75"];
//	_page.backgroundColor = [UIColor clearColor];
//	[_page addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
//
//	[_page mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.centerX.mas_equalTo(_scrollView);
//		make.bottom.mas_equalTo(_scrollView).with.offset(-UNITHEIGHT * 10);
//		make.height.mas_equalTo(UNITHEIGHT * 10);
//	}];


}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _recommendArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//	if (indexPath.row % 2 == 0) {

	RecommendNewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recommendCell"];
//		cell.selectionStyle = UITableViewCellSelectionStyleNone;

//		cell.describeLabel.text = @"各种推荐信息描述1万字\n各种推荐信息描述1万字\n各种推荐信息描述1万字\n各种推荐信息描述1万字\n各种推荐信息描述1万字\n各种推荐信息描述1万字\n各种推荐信息描述1万字";
//		[cell.describeLabel sizeToFit];

	cell.model = _recommendArr[indexPath.row];

	return cell;
//	} else {
//		RecommendOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recommendOtherCell"];
//		cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//		cell.describeLabel.text = @"各种推荐信息描述1万字\n各种推荐信息描述1万字\n各种推荐信息描述1万字\n各种推荐信息描述1万字\n各种推荐信息描述1万字\n各种推荐信息描述1万字\n各种推荐信息描述1万字";
//		[cell.describeLabel sizeToFit];
//
//		return cell;
//	}
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//	UIImageView *imageView = [[UIImageView alloc] init];
//	RecommendModel *model = _recommendArr[indexPath.row];
//	[imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, model.goods_list.firstObject[@"original_img"]]]];
//	UIImage *image = imageView.image;
//	CGFloat picHeight = WIDTH * image.size.height / image.size.width;
//
//	if (picHeight > 0) {
//		return UNITHEIGHT * 217 + picHeight;
//	} else {
//		return UNITHEIGHT * 463.5;
//	}
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	ShopStoreVC *personalVC = [[ShopStoreVC alloc] init];
	personalVC.supplier_id = [_recommendArr[indexPath.row] supplier_id];
	[self.navigationController pushViewController:personalVC animated:YES];
}



#pragma mark - scrollDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	if (scrollView == _scrollView) {
		_page.currentPage = scrollView.contentOffset.x / WIDTH;
	}
}

- (void)pageAction:(UIPageControl *)page {
	[self.scrollView setContentOffset:CGPointMake(page.currentPage * WIDTH, 0) animated:YES];
}



#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.tabBarController.tabBar.hidden = YES;
	self.navigationController.navigationBar.hidden = NO;
	[self.navigationController.navigationBar cnSetBackgroundColor:[UIColor clearColor]];
	[self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor]}];
//	self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	self.navigationController.navigationBar.hidden = NO;
	self.tabBarController.tabBar.hidden = YES;
//	self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
	[self.navigationController.navigationBar cnSetBackgroundColor:[UIColor clearColor]];

	dispatch_async(dispatch_get_main_queue(), ^{
		[_tableView reloadData];
	});
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
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
