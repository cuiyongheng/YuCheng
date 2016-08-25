//
//  LimitRushVC.m
//  YuCheng
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LimitRushVC.h"
#import "LimitRushCell.h"
#import "ProductInfoVC.h"
#import "LimitModel.h"

@interface LimitRushVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISegmentedControl *segment;

@property (nonatomic, strong) UIView *segLineView;

@property (nonatomic, assign) BOOL isleft;

@property (nonatomic, strong) NSMutableArray *limitArr;

@property (nonatomic, strong) NSMutableArray *startArr;

@property (nonatomic, assign) NSInteger pageData;

@end

@implementation LimitRushVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.title = @"限时抢购";

	[self createView];

	[self createData];

	[self createRefresh];
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
	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/goodsList.php?act=time" params:@{@"page" : [NSString stringWithFormat:@"%ld", (long)_pageData]} Success:^(id responseObject) {
		NSMutableArray *tempOneArr = [LimitModel BaseModel:responseObject[@"goods_willbegin_list"]];
		NSMutableArray *tempTwoArr = [LimitModel BaseModel:responseObject[@"goods_startsell_list"]];

		[self.startArr addObjectsFromArray:tempOneArr];
		[self.limitArr addObjectsFromArray:tempTwoArr];

		dispatch_async(dispatch_get_main_queue(), ^{
			[_tableView reloadData];
			[self.tableView.mj_footer endRefreshing];
		});
	} Failed:^(NSError *error) {

	}];
}



#pragma mark - createData
- (void)createData {
	_pageData = 1;
	_startArr = [NSMutableArray arrayWithCapacity:0];
	_limitArr = [NSMutableArray arrayWithCapacity:0];
	[NetWorkingTool GetNetWorking:@"http://www.jadechina.cn/mapi/goodsList.php?act=time" Params:nil Success:^(id responseObject) {

		self.startArr = [LimitModel BaseModel:responseObject[@"goods_willbegin_list"]];
		self.limitArr = [LimitModel BaseModel:responseObject[@"goods_startsell_list"]];

		dispatch_async(dispatch_get_main_queue(), ^{
			[_tableView reloadData];
		});
	} Failed:^(NSError *error) {

	}];
}

#pragma mark - createView 
- (void)createView {
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,UNITHEIGHT * 43.5, WIDTH, HEIGHT - UNITHEIGHT * 43.5 - 64) style:UITableViewStylePlain];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.rowHeight = UNITHEIGHT * 193;
	_tableView.showsVerticalScrollIndicator = NO;
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview:_tableView];

	[_tableView registerClass:[LimitRushCell class] forCellReuseIdentifier:@"limitCell"];

	// seg
	self.segment = [[UISegmentedControl alloc] initWithItems:@[@"最后疯抢", @"即将开始"]];
	_segment.frame = CGRectMake(0, 0, WIDTH, UNITHEIGHT * 43.5);
	_segment.tintColor = [UIColor whiteColor];
	_segment.backgroundColor = [UIColor whiteColor];
	[_segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
	_segment.selectedSegmentIndex = 0;
	[self.view addSubview:_segment];

	UIFont *font = [UIFont boldSystemFontOfSize:12.0f];
	NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
	[_segment setTitleTextAttributes:attributes forState:UIControlStateNormal];
	NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil];
	[_segment setTitleTextAttributes:dic forState:UIControlStateNormal];
	[_segment setTitleTextAttributes:dic forState:UIControlStateSelected];



	self.segLineView = [[UIView alloc] initWithFrame:CGRectMake(0, UNITHEIGHT * 37.5, UNITHEIGHT * 187.5, 4)];
	_segLineView.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
	[self.view addSubview:_segLineView];



	// 手势
	UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe:)];
	leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
	UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe:)];
	rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;

	[self.view addGestureRecognizer:leftSwipe];
	[self.view addGestureRecognizer:rightSwipe];

}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (_isleft) {
		return _startArr.count;
	} else {
		return _limitArr.count;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	LimitRushCell *cell = [tableView dequeueReusableCellWithIdentifier:@"limitCell"];

	if (_isleft) {
		cell.whiteBackView.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
//		cell.timeLabel.textColor = [UIColor whiteColor];
		cell.statsLabel.textColor = [UIColor whiteColor];
//		cell.statsLabel.text = @"即将开始";
		cell.model = _startArr[indexPath.row];
		cell.otherJustStartView.dayLabel.hidden = NO;
		cell.otherJustStartView.dayLabel.textColor = [UIColor whiteColor];
//		cell.otherJustStartView.dayLabel.font = font(14);
		cell.otherJustStartView.hourLabel.textColor = [UIColor whiteColor];
		cell.otherJustStartView.minuteLabel.textColor = [UIColor whiteColor];
		cell.otherJustStartView.secondLabel.textColor = [UIColor whiteColor];
		[cell.otherJustStartView countDownViewWithEndData:[NSDate dateWithTimeIntervalSinceNow:[_startArr[indexPath.row] remain_second]]];
		cell.otherJustStartView.hidden = NO;
		cell.justStartView.hidden = YES;
	} else {
		cell.whiteBackView.backgroundColor = [UIColor whiteColor];
//		cell.timeLabel.textColor = [UIColor blackColor];
		cell.statsLabel.textColor = [UIColor blackColor];
//		cell.statsLabel.text = @"剩余00天";
		cell.model = _limitArr[indexPath.row];
		cell.justStartView.dayLabel.hidden = NO;
		cell.justStartView.dayLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
//		cell.justStartView.dayLabel.font = font(14);
		cell.justStartView.hourLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
		cell.justStartView.minuteLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
		cell.justStartView.secondLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
		[cell.justStartView countDownViewWithEndData:[NSDate dateWithTimeIntervalSinceNow:[_limitArr[indexPath.row] remain_second]]];
		cell.otherJustStartView.hidden = YES;
		cell.justStartView.hidden = NO;
	}

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	ProductInfoVC *productInfoVC = [[ProductInfoVC alloc] init];
	if (_segment.selectedSegmentIndex == 0) {
		productInfoVC.stats = limitRush;
		productInfoVC.goodsID = [_limitArr[indexPath.row] goods_id];
	} else {
		productInfoVC.stats = justStart;
		productInfoVC.goodsID = [_startArr[indexPath.row] goods_id];
	}
	[self.navigationController pushViewController:productInfoVC animated:YES];
}

#pragma mark - segmentAction
- (void)segmentAction:(UISegmentedControl *)seg {
	if (seg.selectedSegmentIndex == 1) {
		_isleft = 1;

		// 动画效果
		CATransition *animation = [CATransition animation];
		animation.duration = 0.3f;
		animation.timingFunction = UIViewAnimationCurveEaseInOut;
		// 改编动画样式
		animation.type = kCATransitionMoveIn;
		// animation.type = @"";
		animation.subtype = kCATransitionFromLeft;
		[_segLineView.layer addAnimation:animation forKey:@"animation"];
		_segLineView.transform = CGAffineTransformMakeTranslation(WIDTH / 2, 0);

		[_tableView reloadData];
	} else {
		_isleft = 0;
		// 动画效果
		CATransition *animation = [CATransition animation];
		animation.duration = 0.3f;
		animation.timingFunction = UIViewAnimationCurveEaseInOut;
		// 改编动画样式
		animation.type = kCATransitionMoveIn;
		// animation.type = @"";
		animation.subtype = kCATransitionFromRight;
		[_segLineView.layer addAnimation:animation forKey:@"animation"];
		_segLineView.transform = CGAffineTransformMakeTranslation(0, 0);

		[_tableView reloadData];
	}
}



#pragma mark - GestureRecognizer
- (void)leftSwipe:(UISwipeGestureRecognizer *)swipe {
	if (_segment.selectedSegmentIndex == 0) {

		_segment.selectedSegmentIndex = _segment.selectedSegmentIndex + 1;
		[self segmentAction:_segment];

		dispatch_async(dispatch_get_main_queue(), ^{
			[_tableView reloadData];
		});
	}

}

- (void)rightSwipe:(UISwipeGestureRecognizer *)swipe {
	if (_segment.selectedSegmentIndex == 1) {

		_segment.selectedSegmentIndex = _segment.selectedSegmentIndex - 1;
		[self segmentAction:_segment];

		dispatch_async(dispatch_get_main_queue(), ^{
			[_tableView reloadData];
		});
	}
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
	[_tableView reloadData];
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
