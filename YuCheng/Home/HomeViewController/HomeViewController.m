//
//  HomeViewController.m
//  YuCheng
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HomeViewController.h"
#import "CYHRollView.h"
#import "HomeHeadView.h"
#import "HomeTableCell.h"

#import "NewProductVC.h"
#import "RecommendVC.h"
#import "LimitRushVC.h"
#import "SellOutVC.h"
#import "ShopStoreVC.h"
#import "ProductInfoVC.h"
#import "HomeModel.h"
#import "SearchVC.h"

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate, HomeHeadViewDelegate,HomeTableCellDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UITableView *homeTableView;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) UIView *hiddenView;// 蒙版

@property (nonatomic) CGFloat halfHeight;

@property (nonatomic, strong) HomeHeadView *headerView;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSMutableArray *adsArr;

@property (nonatomic, strong) NSMutableArray *bestArr;
@property (nonatomic, strong) NSMutableArray *bestIDArr;

@property (nonatomic, strong) NSMutableArray *shopArr;

@end

@implementation HomeViewController

{
	BOOL isAnimation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"玉城";
	self.view.backgroundColor = [UIColor blackColor];

    [self createView];

	[self setNavigation];

	[self createRefresh];

	[self timerWheel];

	[self createData];

	// 添加监听
//	[_homeTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - navigation
- (void)setNavigation {
	// 导航栏渐变
	[self.navigationController.navigationBar cnSetBackgroundColor:[UIColor clearColor]];
	[self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
//	[self.leftItemButton setBackgroundImage:[UIImage imageNamed:@"yc-09"] forState:UIControlStateNormal];
//	self.leftItemButton.frame = CGRectMake(0, 0, UNITHEIGHT * 22, UNITHEIGHT * 22);
	self.navigationItem.leftBarButtonItem = nil;
	_halfHeight = HEIGHT / 2;


	// 右侧
	self.rightItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.rightItemButton.frame = CGRectMake(0, 0, UNITWIDTH * 22, UNITHEIGHT * 22);
	[self.rightItemButton setBackgroundImage:[UIImage imageNamed:@"yc-10"] forState:UIControlStateNormal];
	[self.rightItemButton addTarget:self action:@selector(rightItemButton:) forControlEvents:UIControlEventTouchUpInside];
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightItemButton];




}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//	if ([keyPath isEqualToString:@"contentOffset"])
//	{
//		CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
//		if (offset.y > -20) {
//			self.navigationController.navigationBar.hidden = YES;
//
//			CABasicAnimation *anima = [CABasicAnimation animation];
//			//1.1告诉系统要执行什么样的动画
//			anima.keyPath=@"position";
//			//设置通过动画，将layer从哪儿移动到哪儿
//			anima.fromValue=[NSValue valueWithCGPoint:CGPointMake(WIDTH + ((WIDTH - UNITHEIGHT * 50) / 2), self.searchBar.frame.origin.y + 20)];
//			anima.toValue=[NSValue valueWithCGPoint:CGPointMake((WIDTH / 2) + UNITHEIGHT * 25, self.searchBar.frame.origin.y + 20)];
//			anima.duration = 1;
//
//			//1.2设置动画执行完毕之后不删除动画d
//			anima.removedOnCompletion=NO;
//			//1.3设置保存动画的最新状态
//			anima.fillMode=kCAFillModeForwards;
//			anima.delegate=self;
//			//打印
//			//    NSString *str=NSStringFromCGPoint(self.myLayer.position);
//			//	     NSLog(@"执行前：%@",str);
//
//			//2.添加核心动画到layer
//			[self.searchBar.layer addAnimation:anima forKey:nil];
//
//		} else {
//			self.navigationController.navigationBar.hidden = NO;
//			[self.searchBar resignFirstResponder];
//		}
//	}
//}



#pragma mark - scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if (scrollView == _homeTableView) {

		//	UIColor *color = [UIColor blackColor];
		CGFloat offsetY = scrollView.contentOffset.y;
		//	NSLog(@"%f", offsetY);
		//	if (offsetY >= - _halfHeight - 64) {
		//		CGFloat alpha = 1 - (_halfHeight + 64 + offsetY)/_halfHeight;
		//		[self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:-alpha]];
		//	}

		if (offsetY > -64) {
			//		self.navigationController.navigationBar.hidden = YES;

			if (isAnimation) {

				CABasicAnimation *anima = [CABasicAnimation animation];
				//1.1告诉系统要执行什么样的动画
				anima.keyPath = @"position";
				//设置通过动画，将layer从哪儿移动到哪儿
				anima.fromValue = [NSValue valueWithCGPoint:CGPointMake(WIDTH + ((WIDTH - UNITHEIGHT * 50) / 2), self.searchBar.frame.origin.y + UNITHEIGHT * 10)];
				anima.toValue = [NSValue valueWithCGPoint:CGPointMake((WIDTH / 2) + UNITHEIGHT * 20, self.searchBar.frame.origin.y + UNITHEIGHT * 11)];
				anima.duration = 0.2;

				//1.2设置动画执行完毕之后不删除动画d
				anima.removedOnCompletion = NO;
				//1.3设置保存动画的最新状态
				anima.fillMode = kCAFillModeForwards;
				anima.delegate = self;
				//打印
				//    NSString *str=NSStringFromCGPoint(self.myLayer.position);
				//	     NSLog(@"执行前：%@",str);

				//2.添加核心动画到layer
				[self.searchBar.layer addAnimation:anima forKey:nil];
				isAnimation = 0;
			}

		} else {
			self.navigationController.navigationBar.hidden = NO;
			isAnimation = 1;

			//		[self performSelector:@selector(TransitionSearchBar) withObject:nil afterDelay:1];
			
		}
		
		[self navigationChange:scrollView];
	} 
}

- (void)navigationChange:(UIScrollView *)scrollView {
	UIColor *color = [UIColor blackColor];
	CGFloat offsetY = scrollView.contentOffset.y;
	if (offsetY >= - _halfHeight - 64) {
		CGFloat alpha = 1 - (_halfHeight + 64 + offsetY) / _halfHeight;
		[self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:-alpha]];

//		_headerView.alpha = 1 + alpha;
	} else {
		[self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:0]];
	}
}



- (void)timerWheel {
	self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
//	[[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)timerAction{
    // 滚动
	self.headerView.page.currentPage = (self.headerView.headScroll.contentOffset.x / WIDTH) - 1;
    [self.headerView.headScroll setContentOffset:CGPointMake(self.headerView.headScroll.contentOffset.x + WIDTH, 0) animated:YES];

    if (self.headerView.headScroll.contentOffset.x == WIDTH * (_adsArr.count + 1)) {
		self.headerView.page.currentPage = 0;
        self.headerView.headScroll.contentOffset = CGPointMake(WIDTH, 0);
	}
}


//- (void)TransitionSearchBar {
//	// 动画效果
//	CATransition *animation = [CATransition animation];
//	animation.duration = 5.0f;
//	[CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
//	//set the position
//	// 改编动画样式
//	animation.type = kCATransitionFromLeft;
//	// animation.type = @"";
//	animation.subtype = kCATransitionFromLeft;
//	[self.searchBar.layer addAnimation:animation forKey:@"animation"];
//	self.searchBar.transform = CGAffineTransformMakeTranslation(-(WIDTH - UNITHEIGHT * 50), 0);
//
//}



#pragma mark - createRefresh
- (void)createRefresh {
	// 下拉刷新
//	MJRefreshGifHeader *header = [MJRefreshGifHeader  headerWithRefreshingTarget:self refreshingAction:@selector(createData)];
//	self.homeTableView.mj_header = header;

}

#pragma mark - createData
- (void)createData {
	[self.homeTableView.mj_header endRefreshing];

	__weak __typeof(&*self)weakSelf = self;
	_adsArr = [NSMutableArray arrayWithCapacity:0];
	_bestArr = [NSMutableArray arrayWithCapacity:0];
	_bestIDArr = [NSMutableArray arrayWithCapacity:0];
	_shopArr = [NSMutableArray arrayWithCapacity:0];

	[NetWorkingTool GetNetWorking:@"http://www.jadechina.cn/mapi/index.php" Params:nil Success:^(id responseObject) {

		for (NSDictionary *dic in [responseObject[@"wap_index_ads"] allValues]) {
			[_adsArr addObject:dic[@"image"]];
		}
		for (NSDictionary *dic in responseObject[@"is_best"]) {
			[_bestArr addObject:dic[@"goods_thumb"]];
			[_bestIDArr addObject:dic[@"goods_id"]];
		}
		_shopArr = [HomeModel BaseModel:responseObject[@"cat_recommend_new"]];

		dispatch_async(dispatch_get_main_queue(), ^{

			_headerView.adsArr = _adsArr;
			_headerView.bestArr = _bestArr;
			[_homeTableView reloadData];
		});

	} Failed:^(NSError *error) {

	}];
}

#pragma mark - createView
- (void)createView {
	self.homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, WIDTH, HEIGHT + 64) style:UITableViewStylePlain];
	_homeTableView.delegate = self;
	_homeTableView.dataSource = self;
	_homeTableView.backgroundColor = [UIColor blackColor];
	_homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	_homeTableView.showsVerticalScrollIndicator = NO;
	_homeTableView.rowHeight = UNITHEIGHT * 471.45 - UNITHEIGHT * 36.54;
	[self.view addSubview:_homeTableView];

	[_homeTableView registerClass:[HomeTableCell class] forCellReuseIdentifier:@"homeCell"];

	// header
	self.headerView = [[HomeHeadView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 534)];
	_headerView.backgroundColor = [UIColor whiteColor];
	_headerView.delegate = self;
	_homeTableView.tableHeaderView = _headerView;

	// 状态栏
//	UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
//	statusBarView.backgroundColor=[UIColor blackColor];
//	[self.view addSubview:statusBarView];

//	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];

//	UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	leftButton.frame = CGRectMake(UNITHEIGHT * 16, UNITHEIGHT * 31, UNITHEIGHT * 22, UNITHEIGHT * 22);
//	[leftButton setBackgroundImage:[UIImage imageNamed:@"yc-09"] forState:UIControlStateNormal];
////	[leftButton addTarget:self action:@selector(leftItemAction:) forControlEvents:UIControlEventTouchUpInside];
//	[statusBarView addSubview:leftButton];



	// searchBar
	self.searchBar = [[UISearchBar alloc] init];
	self.searchBar.barStyle = UIBarStyleDefault;
	self.searchBar.placeholder = @"搜索：商品 分类 品牌";
	self.searchBar.delegate = self;
	self.searchBar.barTintColor = [UIColor blackColor];
//	self.searchBar.backgroundColor = [UIColor blackColor];
	self.searchBar.tintColor = [UIColor whiteColor];
	self.searchBar.searchBarStyle = UISearchBarStyleDefault;
//	[statusBarView addSubview:_searchBar];


	
//	[_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.top.bottom.mas_equalTo(leftButton);
//		make.left.mas_equalTo(leftButton).with.offset(UNITHEIGHT * 20);
//		make.width.mas_equalTo(WIDTH - UNITHEIGHT * 70);
//
//	}];

	// Set Search Button Title to Done 2
//	for (UIView *searchBarSubview in [self.searchBar subviews]) {
//		 if ([searchBarSubview conformsToProtocol:@protocol(UITextInputTraits)]) {
//		 // Before iOS 7.0 5
//		 @try {
//			 [(UITextField *)searchBarSubview setReturnKeyType:UIReturnKeyDone];
//			 [(UITextField *)searchBarSubview setKeyboardAppearance:UIKeyboardAppearanceAlert];
//		 }
//			 @catch (NSException * e) {
//				// ignore exception
//			 }
//		 } else {
//				  // iOS 7.014
//			 for(UIView *subSubView in [searchBarSubview subviews]) {
//				 if([subSubView conformsToProtocol:@protocol(UITextInputTraits)]) {
//					 @try {
//						 [(UITextField *)subSubView setReturnKeyType:UIReturnKeyDone];
//						 [(UITextField *)searchBarSubview setKeyboardAppearance:UIKeyboardAppearanceAlert];
//					 }
//					 @catch (NSException * e) {
//							  // ignore exception22
//					 }
//				 }
//			 }
//		 }
//	 }


	// 蒙版
//	self.hiddenView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64)];
//	_hiddenView.backgroundColor = [UIColor blackColor];
//	_hiddenView.alpha = 0.6;
//	_hiddenView.hidden = YES;
//	[self.view addSubview:_hiddenView];
//
//	// 点击蒙版手势
//	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
//	[_hiddenView addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
	_hiddenView.hidden = YES;
	[_searchBar resignFirstResponder];
}


#pragma mark - searchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
	// searchBar开始编辑
	// 出现蒙版
	_hiddenView.hidden = NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
	// 结束编辑回调
	NSLog(@"%@", searchText);
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	// 点击搜索按钮回调
	[searchBar resignFirstResponder];
	[self doSearch:searchBar];
}

- (void)doSearch:(UISearchBar *)searchBar{
	NSLog(@"搜索");
}



#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _shopArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	HomeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
	cell.delegate = self;
	cell.scroll.tag = 18000 + indexPath.row;
//	cell.comeButton.tag = 10000 + indexPath.row;
//	cell.rightImageView.tag = 18000 + indexPath.row;
//	cell.middleImageView.tag = 17000 + indexPath.row;
//	cell.leftImageView.tag = 16000 + indexPath.row;
	cell.model = _shopArr[indexPath.row];

	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//	UIImageView *imageView = [[UIImageView alloc] init];
//	HomeModel *model = _shopArr[indexPath.row];

//	[imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, model.goods_list.firstObject[@"goods_thumb"]]]];
//	UIImage *image = imageView.image;
//	CGFloat picHeight = WIDTH * image.size.height / image.size.width;

//	if (picHeight > 0) {
//		return UNITHEIGHT * 194 + picHeight;
//	} else {
//		return UNITHEIGHT * 500;
//	}
	return UNITHEIGHT * 44 + UNITHEIGHT * 330;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
//	ShopStoreVC *storeVC = [[ShopStoreVC alloc] init];
//	storeVC.supplier_id = [_shopArr[indexPath.row] supplier_id];
//	[self.navigationController pushViewController:storeVC animated:YES];
}



#pragma mark - headerDelegate
- (void)tapNewViewController {
	NewProductVC *NewVC = [[NewProductVC alloc] init];
	NewVC.isNewProduct = 1;
	[self.navigationController pushViewController:NewVC animated:YES];
}

- (void)tapLimitRushViewController {
	LimitRushVC *limitVC = [[LimitRushVC alloc] init];
	[self.navigationController pushViewController:limitVC animated:YES];
}

- (void)tapRecommendViewController {
	RecommendVC *recommendVC = [[RecommendVC alloc] init];
	[self.navigationController pushViewController:recommendVC animated:YES];
}

- (void)tapSellOutViewController {
	SellOutVC *selloutVC = [[SellOutVC alloc] init];
	[self.navigationController pushViewController:selloutVC animated:YES];
}

- (void)tapImageView:(NSInteger)tapIndex {
	ProductInfoVC *infoVC = [[ProductInfoVC alloc] init];
	infoVC.goodsID = _bestIDArr[tapIndex - 10000];
	[self.navigationController pushViewController:infoVC animated:YES];
}

//- (void)comeinStore:(NSInteger)buttonTag {
//	personalStoreVC *storeVC = [[personalStoreVC alloc] init];
//	[self.navigationController pushViewController:storeVC animated:YES];
//}

- (void)rightButton:(UIButton *)button {
	NSLog(@"搜索");
}



#pragma mark - cellDelegate
- (void)tapClassifyImageView:(NSInteger)imageNum scrollTag:(NSInteger)scrollTag {
	HomeModel *model = _shopArr[scrollTag - 18000];
	ProductInfoVC *infoVC = [[ProductInfoVC alloc] init];
	infoVC.goodsID = model.goods[imageNum][@"goods_id"];
	[self.navigationController pushViewController:infoVC animated:YES];
}

//- (void)rightGoods:(NSInteger)tapTag {
//	ProductInfoVC *infoVC = [[ProductInfoVC alloc] init];
//	infoVC.goodsID = [_shopArr[tapTag - 18000] goods_list][2][@"goods_id"];
//	[self.navigationController pushViewController:infoVC animated:YES];
//}
//
//- (void)middleGoods:(NSInteger)tapTag {
//	ProductInfoVC *infoVC = [[ProductInfoVC alloc] init];
//	infoVC.goodsID = [_shopArr[tapTag - 17000] goods_list][1][@"goods_id"];
//	[self.navigationController pushViewController:infoVC animated:YES];
//}
//
//- (void)leftGoods:(NSInteger)tapTag {
//	ProductInfoVC *infoVC = [[ProductInfoVC alloc] init];
//	infoVC.goodsID = [_shopArr[tapTag - 16000] goods_list].firstObject[@"goods_id"];
//	[self.navigationController pushViewController:infoVC animated:YES];
//}



#pragma mark - rightItemButton
- (void)rightItemButton:(UIButton *)button {
	SearchVC *searchVC = [[SearchVC alloc] init];
	[self.navigationController pushViewController:searchVC animated:YES];
}


#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.navigationController.navigationBar.translucent = YES;
	[self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
	[self.navigationController.navigationBar cnSetBackgroundColor:[UIColor clearColor]];
	self.automaticallyAdjustsScrollViewInsets = YES;
	self.tabBarController.tabBar.hidden = NO;

	[_timer setFireDate:[NSDate date]];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	_headerView.headScroll.contentSize = CGSizeMake(0, 0);
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	self.navigationController.navigationBar.translucent = NO;
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
	[_timer setFireDate:[NSDate distantFuture]];
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
