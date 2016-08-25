//
//  MyOrderViewController.m
//  YuCheng
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyOrderViewController.h"
#import "OrderCell.h"
#import "MyOrderFootView.h"
#import "OrderTwoCell.h"
#import "OrderThreeCell.h"
#import "OrderFourCell.h"
#import "ClearingVC.h"
#import "InfoOrderVC.h"
#import "WaitPayModel.h"
#import "InfoOrderOtherVC.h"
#import "OrderRefundVC.h"
#import "RefundLogisticsVC.h"
#import "InfoOrderOtherVC.h"
#import "OrderRefundVC.h"
#import "InfoOrderStartVC.h"

@interface MyOrderViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, OrderCellDelegate>

@property (nonatomic, strong) UISegmentedControl *segment;

@property (nonatomic, strong) UITableViewController *tableViewController;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITableView *twoTableView;

@property (nonatomic, strong) UITableView *threeTableView;

@property (nonatomic, strong) UITableView *fourTabbleView;

@property (nonatomic, strong) MyOrderFootView *footView;

@property (nonatomic, strong) UIScrollView *scrollView;// 滚动

@property (nonatomic, strong) UIView *segLineView;

@property (nonatomic, strong) NSMutableArray *waitPayArr;// 待付款

@property (nonatomic, strong) NSMutableArray *waitsendArr;// 待发货

@property (nonatomic, strong) NSMutableArray *refundArr;// 退款中

@property (nonatomic, strong) NSMutableArray *allArr;// 全部订单

@property (nonatomic, assign) NSInteger page;

@end

@implementation MyOrderViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.title = @"我的订单";

	[self createData];

	[self createView];

	[self createRefresh];
}



#pragma mark - createData
- (void)createData {
	_page = 1;
	_waitPayArr = [NSMutableArray arrayWithCapacity:0];
	_waitsendArr = [NSMutableArray arrayWithCapacity:0];
	_refundArr = [NSMutableArray arrayWithCapacity:0];
	_allArr = [NSMutableArray arrayWithCapacity:0];

	// 待付款
	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userOrderList.php" params:@{@"type" : @1} Success:^(id responseObject) {
		if ([responseObject[@"orders"] count] > 0) {
			NSMutableArray *moneyArr = [NSMutableArray arrayWithCapacity:0];
			for (NSDictionary *dic in [responseObject[@"orders"] allValues]) {
				WaitPayModel *model = [WaitPayModel mj_objectWithKeyValues:dic];
				[_waitPayArr addObject:model];
				[moneyArr addObject:model.total_fee];
			}

			CGFloat total;
			for (NSString *str in moneyArr) {
				total += [str floatValue];
			}

			_footView.moneyLabel.text = [NSString stringWithFormat:@"%.2f", total];
		}
		dispatch_async(dispatch_get_main_queue(), ^{
			if (_waitPayArr.count > 0) {
				[_tableView reloadData];
			}
		});
	} Failed:^(NSError *error) {

	}];



	// 待发货
	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userOrderList.php" params:@{@"type" : @2} Success:^(id responseObject) {

		if ([responseObject[@"orders"] count] > 0) {
			for (NSDictionary *dic in [responseObject[@"orders"] allValues]) {
				WaitPayModel *model = [WaitPayModel mj_objectWithKeyValues:dic];
				[_waitsendArr addObject:model];
			}
		}
		
		dispatch_async(dispatch_get_main_queue(), ^{
			if (_waitsendArr.count > 0) {
				[_twoTableView reloadData];
			}
		});
	} Failed:^(NSError *error) {
		
	}];



	// 退款中
	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userOrderList.php" params:@{@"type" : @3} Success:^(id responseObject) {

		if ([responseObject[@"back_goods_list"] count] > 0) {
			for (NSDictionary *dic in responseObject[@"back_goods_list"]) {
				WaitPayModel *model = [WaitPayModel mj_objectWithKeyValues:dic];
				[_refundArr addObject:model];
			}
		}
		dispatch_async(dispatch_get_main_queue(), ^{
			if (_refundArr.count > 0) {
				[_threeTableView reloadData];
			}
		});
	} Failed:^(NSError *error) {

	}];



	// 全部
	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userOrderList.php" params:@{@"type" : @0} Success:^(id responseObject) {

		if ([responseObject[@"orders"] count] > 0) {
			for (NSDictionary *dic in [responseObject[@"orders"] allValues]) {
				WaitPayModel *model = [WaitPayModel mj_objectWithKeyValues:dic];
				[_allArr addObject:model];
			}

			dispatch_async(dispatch_get_main_queue(), ^{
				if (_allArr.count > 0) {
					[_fourTabbleView reloadData];
				}
			});
		}
	} Failed:^(NSError *error) {

	}];

}



#pragma mark - createRefresh
- (void)createRefresh {

	MJRefreshBackFooter *footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefersh)];
	self.fourTabbleView.mj_footer = footer;
}

- (void)footerRefersh {
	_page += 1;
	// 全部
	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userOrderList.php" params:@{@"type" : @0, @"page" : [NSString stringWithFormat:@"%ld" ,_page]} Success:^(id responseObject) {

		if ([responseObject[@"orders"] count] > 0) {
			for (NSDictionary *dic in [responseObject[@"orders"] allValues]) {
				WaitPayModel *model = [WaitPayModel mj_objectWithKeyValues:dic];
				[_allArr addObject:model];
			}

			dispatch_async(dispatch_get_main_queue(), ^{
				if (_allArr.count > 0) {
					[_fourTabbleView reloadData];
					[_fourTabbleView.mj_footer endRefreshing];
				}
			});
		}
	} Failed:^(NSError *error) {

	}];
}



#pragma mark - createView
- (void)createView {
	// seg
	self.segment = [[UISegmentedControl alloc] initWithItems:@[@"待付款", @"待发货", @"退款商品", @"所有订单"]];
	_segment.frame = CGRectMake(0, 64, WIDTH, UNITHEIGHT * 40);
	_segment.tintColor = [UIColor whiteColor];
	_segment.backgroundColor = [UIColor whiteColor];
	_segment.tintColor = [UIColor whiteColor];
	[_segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:_segment];

	UIFont *font = [UIFont boldSystemFontOfSize:12.0f];
	NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
	[_segment setTitleTextAttributes:attributes forState:UIControlStateNormal];
	NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil];
	[_segment setTitleTextAttributes:dic forState:UIControlStateNormal];
	[_segment setTitleTextAttributes:dic forState:UIControlStateSelected];



	// foot
	self.footView = [[MyOrderFootView alloc] init];
	[self.view addSubview:_footView];

	[_footView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.and.right.mas_equalTo(self.view);
		make.height.mas_equalTo(UNITHEIGHT * 65);
		make.bottom.mas_equalTo(self.view);
	}];



	// scroll
	self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
	_scrollView.backgroundColor = [UIColor whiteColor];
	_scrollView.contentSize = CGSizeMake(WIDTH * 4, 0);
	_scrollView.pagingEnabled = YES;
	_scrollView.delegate = self;
	_scrollView.showsHorizontalScrollIndicator = NO;
	[self.view addSubview:_scrollView];



	// tableView
	self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(UNITHEIGHT * 15, UNITHEIGHT * 40, WIDTH - UNITHEIGHT * 10, UNITHEIGHT * 500) style:UITableViewStylePlain];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.rowHeight = UNITHEIGHT * 134;
	_tableView.showsVerticalScrollIndicator = NO;
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[_scrollView addSubview:_tableView];

	[_tableView registerClass:[OrderCell class] forCellReuseIdentifier:@"MyOredeCell"];

	// twoTableView
	self.twoTableView = [[UITableView alloc] initWithFrame:CGRectMake(UNITHEIGHT * 15 + WIDTH, UNITHEIGHT * 40, WIDTH - UNITHEIGHT * 10, HEIGHT - 64 - UNITHEIGHT * 40) style:UITableViewStylePlain];
	_twoTableView.delegate = self;
	_twoTableView.dataSource = self;
	_twoTableView.rowHeight = UNITHEIGHT * 134;
	_twoTableView.showsVerticalScrollIndicator = NO;
	_twoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[_scrollView addSubview:_twoTableView];

	[_twoTableView registerClass:[OrderTwoCell class] forCellReuseIdentifier:@"twoCell"];

	// threeTableView
	self.threeTableView = [[UITableView alloc] initWithFrame:CGRectMake(UNITHEIGHT * 15 + WIDTH * 2, UNITHEIGHT * 40, WIDTH - UNITHEIGHT * 10, HEIGHT - 64 - UNITHEIGHT * 40) style:UITableViewStylePlain];
	_threeTableView.delegate = self;
	_threeTableView.dataSource = self;
	_threeTableView.rowHeight = UNITHEIGHT * 134;
	_threeTableView.showsVerticalScrollIndicator = NO;
	_threeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[_scrollView addSubview:_threeTableView];

	[_threeTableView registerClass:[OrderThreeCell class] forCellReuseIdentifier:@"threeCell"];

	// fourTableView
	self.fourTabbleView = [[UITableView alloc] initWithFrame:CGRectMake(UNITHEIGHT * 15 + WIDTH * 3, UNITHEIGHT * 40, WIDTH - UNITHEIGHT * 10, HEIGHT - 64 - UNITHEIGHT * 40) style:UITableViewStylePlain];
	_fourTabbleView.delegate = self;
	_fourTabbleView.dataSource = self;
	_fourTabbleView.rowHeight = UNITHEIGHT * 134;
	_fourTabbleView.showsVerticalScrollIndicator = NO;
	_fourTabbleView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[_scrollView addSubview:_fourTabbleView];

	[_fourTabbleView registerClass:[OrderFourCell class] forCellReuseIdentifier:@"fourCell"];



	self.segLineView = [[UIView alloc] initWithFrame:CGRectMake(0, UNITHEIGHT * 40 + 64, WIDTH / 4, 4)];
	_segLineView.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
	[self.view addSubview:_segLineView];

	// tableViewController
//	self.tableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
//
	[_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
	switch (_orderStats) {
		case waitPay:
			_segment.selectedSegmentIndex = 0;
//			_tableView.frame = CGRectMake(UNITHEIGHT * 15, UNITHEIGHT * 40, WIDTH - UNITHEIGHT * 10, UNITHEIGHT * 500);
			[self segmentAction:_segment];
			[_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
			break;
		case waitsend:
			_segment.selectedSegmentIndex = 1;
//			_twoTableView.frame = CGRectMake(UNITHEIGHT * 15 + WIDTH, UNITHEIGHT * 40, WIDTH - UNITHEIGHT * 10, HEIGHT - 64 - UNITHEIGHT * 40);
			[self segmentAction:_segment];
			[_scrollView setContentOffset:CGPointMake(WIDTH, 0) animated:YES];
			break;
		case refund:
			_segment.selectedSegmentIndex = 2;
//			_threeTableView.frame = CGRectMake(UNITHEIGHT * 15 + WIDTH * 2, UNITHEIGHT * 40, WIDTH - UNITHEIGHT * 10, HEIGHT - 64 - UNITHEIGHT * 40);
			[self segmentAction:_segment];
			[_scrollView setContentOffset:CGPointMake(WIDTH * 2, 0) animated:YES];
			break;
		case MyOrder:
			_segment.selectedSegmentIndex = 3;
//			_fourTabbleView.frame = CGRectMake(UNITHEIGHT * 15 + WIDTH * 3, UNITHEIGHT * 40, WIDTH - UNITHEIGHT * 10, HEIGHT - 64 - UNITHEIGHT * 40);
			[self segmentAction:_segment];
			[_scrollView setContentOffset:CGPointMake(WIDTH * 3, 0) animated:YES];
			break;
		default:
			break;
	}

//
//	[self addChildViewController:_tableViewController];
//	[self.view addSubview:_tableViewController.view];
//
//	// 手势
//	UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe:)];
//	leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
//	UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe:)];
//	rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
//
//	[self.view addGestureRecognizer:leftSwipe];
//	[self.view addGestureRecognizer:rightSwipe];

	[self.view bringSubviewToFront:_segment];
	[self.view bringSubviewToFront:_footView];

}



#pragma mark - segmentAction
- (void)segmentAction:(UISegmentedControl *)seg {

	switch (seg.selectedSegmentIndex) {
		case waitPay:
//			_tableViewController.tableView = _tableView;
//			_tableViewController.view.frame = CGRectMake(UNITHEIGHT * 15,  0, WIDTH - UNITHEIGHT * 10, UNITHEIGHT * 500);
			_tableView.frame = CGRectMake(UNITHEIGHT * 15, UNITHEIGHT * 40, WIDTH - UNITHEIGHT * 10, UNITHEIGHT * 500);
			[_scrollView setContentOffset:CGPointMake(0, -64) animated:YES];
			_footView.hidden = NO;
			break;
		case waitsend:
//			_tableViewController.tableView = _twoTableView;
//			_tableViewController.view.frame = CGRectMake(UNITHEIGHT * 15,  0, WIDTH - UNITHEIGHT * 10, HEIGHT - 64 - UNITHEIGHT * 40);
			_twoTableView.frame = CGRectMake(UNITHEIGHT * 15 + WIDTH, UNITHEIGHT * 40, WIDTH - UNITHEIGHT * 10, HEIGHT - 64 - UNITHEIGHT * 40);

			[_scrollView setContentOffset:CGPointMake(WIDTH, -64) animated:YES];

			_footView.hidden = YES;
			break;
		case refund:
//			_tableViewController.tableView = _threeTableView;
//			_tableViewController.view.frame = CGRectMake(UNITHEIGHT * 15,  0, WIDTH - UNITHEIGHT * 10, HEIGHT - 64 - UNITHEIGHT * 40);
			_threeTableView.frame = CGRectMake(UNITHEIGHT * 15 + WIDTH * 2, UNITHEIGHT * 40, WIDTH - UNITHEIGHT * 10, HEIGHT - 64 - UNITHEIGHT * 40);

			[_scrollView setContentOffset:CGPointMake(WIDTH * 2, -64) animated:YES];

			_footView.hidden = YES;
			break;
		case MyOrder:
//			_tableViewController.tableView = _fourTabbleView;
//			_tableViewController.view.frame = CGRectMake(UNITHEIGHT * 15,  0, WIDTH - UNITHEIGHT * 10, HEIGHT - 64 - UNITHEIGHT * 40);
			_fourTabbleView.frame = CGRectMake(UNITHEIGHT * 15 + WIDTH * 3, UNITHEIGHT * 40, WIDTH - UNITHEIGHT * 10, HEIGHT - 64 - UNITHEIGHT * 40);
			[_scrollView setContentOffset:CGPointMake(WIDTH * 3, -64) animated:YES];

			_footView.hidden = YES;
			break;
		default:
			break;
	}
//	[_tableViewController reloadInputViews];



	if (seg.selectedSegmentIndex == 1) {

		// 动画效果
		CATransition *animation = [CATransition animation];
		animation.duration = 0.3f;
		animation.timingFunction = UIViewAnimationCurveEaseInOut;
		// 改编动画样式
		animation.type = kCATransitionFade;
		// animation.type = @"";
//		animation.subtype = kCATransitionFromLeft;
		[_segLineView.layer addAnimation:animation forKey:@"animation"];
		_segLineView.transform = CGAffineTransformMakeTranslation(WIDTH / 4, 0);

	} else if (seg.selectedSegmentIndex == 0) {
		// 动画效果
		CATransition *animation = [CATransition animation];
		animation.duration = 0.3f;
		animation.timingFunction = UIViewAnimationCurveEaseInOut;
		// 改编动画样式
		animation.type = kCATransitionFade;
		// animation.type = @"";
//		animation.subtype = kCATransitionFromRight;
		[_segLineView.layer addAnimation:animation forKey:@"animation"];
		_segLineView.transform = CGAffineTransformMakeTranslation(0, 0);

	} else if (seg.selectedSegmentIndex == 2) {
		// 动画效果
		CATransition *animation = [CATransition animation];
		animation.duration = 0.3f;
		animation.timingFunction = UIViewAnimationCurveEaseInOut;
		// 改编动画样式
		animation.type = kCATransitionFade;
		// animation.type = @"";
//		animation.subtype = kCATransitionFromRight;
		[_segLineView.layer addAnimation:animation forKey:@"animation"];
		_segLineView.transform = CGAffineTransformMakeTranslation(WIDTH / 2, 0);

	} else {
		// 动画效果
		CATransition *animation = [CATransition animation];
		animation.duration = 0.3f;
		animation.timingFunction = UIViewAnimationCurveEaseInOut;
		// 改编动画样式
		animation.type = kCATransitionFade;
		// animation.type = @"";
//		animation.subtype = kCATransitionFromRight;
		[_segLineView.layer addAnimation:animation forKey:@"animation"];
		_segLineView.transform = CGAffineTransformMakeTranslation((WIDTH / 4) * 3, 0);
	}
}

#pragma mark - GestureRecognizer
//- (void)leftSwipe:(UISwipeGestureRecognizer *)swipe {
//	if (_segment.selectedSegmentIndex == 3) {
//
//	} else {
//		_segment.selectedSegmentIndex = _segment.selectedSegmentIndex + 1;
//	}
//	[self segmentAction:_segment];
//}
//
//- (void)rightSwipe:(UISwipeGestureRecognizer *)swipe {
//	if (_segment.selectedSegmentIndex == 0) {
//
//	} else {
//		_segment.selectedSegmentIndex = _segment.selectedSegmentIndex - 1;
//	}
//	[self segmentAction:_segment];
//}

#pragma mark - scrollDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	if (scrollView == _scrollView) {

		if (scrollView.contentOffset.x == 0) {
			_segment.selectedSegmentIndex = 0;
			_footView.hidden = NO;
			_segment.selectedSegmentIndex = 0;
			[self segmentAction:_segment];
		} else if (scrollView.contentOffset.x / WIDTH == 1) {
			_segment.selectedSegmentIndex = 1;
			_footView.hidden = YES;
			_segment.selectedSegmentIndex = 1;
			[self segmentAction:_segment];
		} else if (scrollView.contentOffset.x / WIDTH == 2) {
			_segment.selectedSegmentIndex = 2;
			_footView.hidden = YES;
			_segment.selectedSegmentIndex = 2;
			[self segmentAction:_segment];
		} else if (scrollView.contentOffset.x / WIDTH == 3) {
			_segment.selectedSegmentIndex = 3;
			_footView.hidden = YES;
			_segment.selectedSegmentIndex = 3;
			[self segmentAction:_segment];
		}
	}
//	[self segmentAction:_segment];
}


#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (tableView == _tableView) {
		return [[_waitPayArr[section] goods_list] count];
	} else if (tableView == _twoTableView) {
		return [[_waitsendArr[section] goods_list] count];
	} else if (tableView == _threeTableView) {
		return 1;
	} else {
		return [[_allArr[section] goods_list] count];
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableView == _tableView) {

		OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyOredeCell"];
//		cell.baseCell.delegateView.tag = 40000 + indexPath.row;
//		cell.baseCell.delegateButton.tag = 45000 + indexPath.row;
//		cell.payButton.tag = 40000 + indexPath.row;
//		cell.delegate = self;

		cell.baseCell.titleLabel.text = [_waitPayArr[indexPath.section] goods_list][indexPath.row][@"goods_name"];
		cell.baseCell.moneyLabel.text = [_waitPayArr[indexPath.section] goods_list][indexPath.row][@"goods_price"];
		[cell.baseCell.picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, [_waitPayArr[indexPath.section] goods_list][indexPath.row][@"goods_thumb"]]] placeholderImage:[UIImage imageNamed:@""]];

		return cell;
	} else if (tableView == _twoTableView) {
		OrderTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell"];
		cell.baseCell.titleLabel.text = [_waitsendArr[indexPath.section] goods_list][indexPath.row][@"goods_name"];
		cell.baseCell.moneyLabel.text = [_waitsendArr[indexPath.section] goods_list][indexPath.row][@"goods_price"];
		[cell.baseCell.picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, [_waitsendArr[indexPath.section] goods_list][indexPath.row][@"goods_thumb"]]] placeholderImage:[UIImage imageNamed:@""]];

		return cell;
	} else if (tableView == _threeTableView) {
		OrderThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threeCell"];

		cell.baseCell.titleLabel.text = [_refundArr[indexPath.section] goods_name];
		cell.baseCell.moneyLabel.text = [_refundArr[indexPath.section] back_goods_price];
		[cell.baseCell.picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, [_refundArr[indexPath.section] goods_thumb]]] placeholderImage:[UIImage imageNamed:@""]];

		return cell;
	} else {
		OrderFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fourCell"];

		cell.baseCell.titleLabel.text = [_allArr[indexPath.section] goods_list][indexPath.row][@"goods_name"];
		cell.baseCell.moneyLabel.text = [_allArr[indexPath.section] goods_list][indexPath.row][@"goods_price"];
		[cell.baseCell.picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, [_allArr[indexPath.section] goods_list][indexPath.row][@"goods_thumb"]]] placeholderImage:[UIImage imageNamed:@""]];

		return cell;
	}
}

#pragma mark - tableViewEditing
//- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
//	// 添加RowAction
//	__weak __typeof(&*self)weakSelf = self;
//
//	UITableViewRowAction *firstAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"         " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//		// 要实现的功能, 都写在block里
//		NSLog(@"删除");
//	}];
//	firstAction.backgroundColor = [UIColor whiteColor];
//
//	UIView *view = (UIView *)[self.view viewWithTag:40000 + indexPath.row];
//	UIButton *button = (UIButton *)[self.view viewWithTag:45000 + indexPath.row];
//	view.hidden = NO;
//
//	[UIView beginAnimations:@"animation" context:nil];
//	[UIView setAnimationDuration:0.5f];
//	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//	[UIView setAnimationRepeatAutoreverses:NO];
//	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:button cache:NO];
//	[UIView commitAnimations];
//
//
//	return @[firstAction];
//}

// 设置那些行可以进行编辑操作
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    // 这个方法默认就是所有行都可以进行编辑
////    return YES;
////    if (indexPath.row % 2 == 0) {
////        return YES;
////    }else{
////        return NO;
////    }
//
//	if (tableView == _tableView) {
//		return YES;
//	} else {
//		return NO;
//	}
//}

#pragma mark - head foot
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if (tableView == _tableView) {
		return _waitPayArr.count;
	} else if (tableView == _twoTableView) {
		return _waitsendArr.count;
	} else if (tableView == _threeTableView) {
		return _refundArr.count;
	}
	else {
		return _allArr.count;
	}
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 50)];

	UIView *backView = [[UIView alloc] init];
	backView.backgroundColor = [UIColor colorWithRed:247 / 255.0 green:247  /255.0 blue:247 / 255.0 alpha:1];
	[headView addSubview:backView];

	UIImageView *shopImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ICON-27"]];
	[headView addSubview:shopImageView];

	UILabel *titleLabel = [[UILabel alloc] init];
	titleLabel.text = @"店名";
	titleLabel.textAlignment = NSTextAlignmentCenter;
	titleLabel.font = font(14);
	[headView addSubview:titleLabel];

	UIButton *serveButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[serveButton setBackgroundImage:[UIImage imageNamed:@"yc6.24-74"] forState:UIControlStateNormal];
	[serveButton addTarget:self action:@selector(serverButton:) forControlEvents:UIControlEventTouchUpInside];
	[headView addSubview:serveButton];

	if (tableView == _tableView) {
		serveButton.tag = 800000 + section;
	} else if (tableView == _twoTableView) {
		serveButton.tag = 810000 + section;
	} else if (tableView == _threeTableView) {
		serveButton.tag = 820000 + section;
	} else if (tableView == _fourTabbleView) {
		serveButton.tag = 830000 + section;
	}

	[backView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(UNITHEIGHT * 10);
		make.top.bottom.mas_equalTo(headView);
		make.right.mas_equalTo(headView).with.offset(-UNITHEIGHT * 30);
	}];

	[shopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(backView).with.offset(UNITHEIGHT * 10);
		make.height.width.mas_equalTo(UNITHEIGHT * 30);
		make.centerY.mas_equalTo(headView);
	}];

	[serveButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(backView).with.offset(-UNITHEIGHT * 10);
		make.height.width.mas_equalTo(UNITHEIGHT * 30);
		make.centerY.mas_equalTo(headView);
	}];

	[titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(shopImageView.mas_right).with.offset(UNITHEIGHT * 10);
		make.centerY.mas_equalTo(headView);
		make.right.mas_equalTo(serveButton.mas_left).with.offset(-UNITHEIGHT * 10);
	}];

	if (tableView == _tableView) {
		titleLabel.text = [_waitPayArr[section] shopname];
	} else if (tableView == _twoTableView) {
		titleLabel.text = [_waitsendArr[section] shopname];
	} else if (tableView == _threeTableView) {
		titleLabel.text = [_refundArr[section] supplier_name];
	} else if (tableView == _fourTabbleView) {
		titleLabel.text = [_allArr[section] shopname];
	}

	return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return UNITHEIGHT * 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	if (tableView == _threeTableView) {
		return UNITHEIGHT * 50;
	}
	return UNITHEIGHT * 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

	if (tableView == _tableView) {
		if ([[_waitPayArr[section] use_order_status] isEqualToString:@"1"]) {

			return [self footWaitpayView:section isAllOrder:0 isFinish:0];
		} else {
			return [self footWaitSendView:section isAllOrder:2];
		}
	} else if (tableView == _twoTableView) {
		if ([[_waitsendArr[section] use_order_status] isEqualToString:@"2"]) {
			return [self footWaitSendView:section isAllOrder:0];
		} else {
			return [self footWaitpayView:section isAllOrder:0 isFinish:1];
		}
	} else if (tableView == _threeTableView) {

		return [self footRefundView:section isAllOrder:0];
	} else {
		if ([[_allArr[section] use_order_status] isEqualToString:@"1"]) {
			return [self footWaitpayView:section isAllOrder:1 isFinish:0];
		} else if ([[_allArr[section] use_order_status] isEqualToString:@"2"]) {
			return [self footWaitSendView:section isAllOrder:1];
		} else if ([[_allArr[section] use_order_status] isEqualToString:@"3"]) {
			return [self footAllView:section isAllOrder:1];
		} else if ([[_allArr[section] use_order_status] isEqualToString:@"4"]) {
			return [self footWaitpayView:section isAllOrder:1 isFinish:1];
		} else if ([[_allArr[section] use_order_status] isEqualToString:@"5"]) {
			return [self footRefundView:section isAllOrder:1];
		} else {
			return [self footWaitSendView:section isAllOrder:1];
		}
	}
}



#pragma mark - footView
// 待付款
- (UIView *)footWaitpayView:(NSInteger)section isAllOrder:(BOOL)isAllOrder isFinish:(BOOL)isFinish  {
	UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 100)];
	footView.backgroundColor = [UIColor whiteColor];

	UILabel *moneyLabel = [[UILabel alloc] init];
//	moneyLabel.text = [_waitPayArr[section] total_fee];
	moneyLabel.font = font(16);
	[footView addSubview:moneyLabel];

	[moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(UNITHEIGHT * 10);
		make.top.mas_equalTo(UNITHEIGHT * 10);
	}];

	UILabel *dingLabel = [[UILabel alloc] init];
//	dingLabel.text = [_waitPayArr[section] order_sn];
	dingLabel.font = font(14);
	[footView addSubview:dingLabel];

	[dingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(moneyLabel);
		make.right.mas_equalTo(footView).with.offset(-UNITHEIGHT * 30);
	}];

	UIView *lineView = [[UIView alloc] init];
	lineView.backgroundColor = [UIColor colorWithHexString:@"#a5a5a5"];
	[footView addSubview:lineView];

	[lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(1);
		make.left.mas_equalTo(UNITHEIGHT * 10);
		make.right.mas_equalTo(footView).with.offset(-UNITHEIGHT * 30);
		make.centerY.mas_equalTo(footView).with.offset(-UNITHEIGHT * 10);
	}];

	UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
	sureButton.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
	[sureButton setTitle:@"完成付款" forState:UIControlStateNormal];
	[sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[sureButton addTarget:self action:@selector(sureButton:) forControlEvents:UIControlEventTouchUpInside];
	sureButton.titleLabel.font = font(14);
	[footView addSubview:sureButton];

	[sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(lineView);
		make.height.mas_equalTo(UNITHEIGHT * 30);
		make.top.mas_equalTo(lineView).with.offset(UNITHEIGHT * 10);
		make.width.mas_equalTo(UNITHEIGHT * 100);

	}];

	UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
	cancelButton.backgroundColor = [UIColor blackColor];
	[cancelButton setTitle:@"取消订单" forState:UIControlStateNormal];
	[cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[cancelButton addTarget:self action:@selector(cancelButton:) forControlEvents:UIControlEventTouchUpInside];
	cancelButton.titleLabel.font = font(14);
	[footView addSubview:cancelButton];

	[cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(sureButton.mas_left).with.offset(-UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 30);
		make.top.mas_equalTo(lineView).with.offset(UNITHEIGHT * 10);
		make.width.mas_equalTo(UNITHEIGHT * 100);
	}];

	if (isAllOrder == 1) {
		// 确认订单 取消订单
		cancelButton.tag = 7000000 + section;
		sureButton.tag = 7800000 + section;
		moneyLabel.text = [_allArr[section] total_fee];
		dingLabel.text = [_allArr[section] order_sn];
		if (isFinish) {
			sureButton.tag = 7200000 + section;
			cancelButton.tag = 7500000 + section;
			[cancelButton setTitle:@"延长收货" forState:UIControlStateNormal];
			[sureButton setTitle:@"确认收货" forState:UIControlStateNormal];
		}
	} else if (isAllOrder == 0){
		if (isFinish) {
			moneyLabel.text = [_waitsendArr[section] total_fee];
			dingLabel.text = [_waitsendArr[section] order_sn];
			sureButton.tag = 7300000 + section;
			cancelButton.tag = 7600000 + section;
			[cancelButton setTitle:@"延长收货" forState:UIControlStateNormal];
			[sureButton setTitle:@"确认收货" forState:UIControlStateNormal];
		} else {
			// 确认订单 取消订单
			cancelButton.tag = 7100000 + section;
			sureButton.tag = 7900000 + section;
			moneyLabel.text = [_waitPayArr[section] total_fee];
			dingLabel.text = [_waitPayArr[section] order_sn];
		}
	}

	return footView;
}

// 待发货
- (UIView *)footWaitSendView:(NSInteger)section isAllOrder:(NSInteger)isAllOrder{
	UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 100)];
	footView.backgroundColor = [UIColor whiteColor];

	UILabel *moneyLabel = [[UILabel alloc] init];
//	moneyLabel.text = [_waitsendArr[section] total_fee];
	moneyLabel.font = font(16);
	[footView addSubview:moneyLabel];

	[moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(UNITHEIGHT * 10);
		make.top.mas_equalTo(UNITHEIGHT * 10);
	}];

	UILabel *dingLabel = [[UILabel alloc] init];
//	dingLabel.text = [_waitsendArr[section] order_sn];
	dingLabel.font = font(14);
	[footView addSubview:dingLabel];

	[dingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(moneyLabel);
		make.right.mas_equalTo(footView).with.offset(-UNITHEIGHT * 30);
	}];

	UIView *lineView = [[UIView alloc] init];
	lineView.backgroundColor = [UIColor colorWithHexString:@"#a5a5a5"];
	[footView addSubview:lineView];

	[lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(1);
		make.left.mas_equalTo(UNITHEIGHT * 10);
		make.right.mas_equalTo(footView).with.offset(-UNITHEIGHT * 30);
		make.centerY.mas_equalTo(footView).with.offset(-UNITHEIGHT * 10);
	}];

	UILabel *twoLabel = [[UILabel alloc] init];
	//		twoLabel.text = @"待发货";
	twoLabel.font = font(14);
	[footView addSubview:twoLabel];

	[twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(lineView).with.offset(UNITHEIGHT * 10);
		make.centerX.mas_equalTo(lineView);
	}];

	if (isAllOrder == 1) {
		moneyLabel.text = [_allArr[section] total_fee];
		dingLabel.text = [_allArr[section] order_sn];
		if ([[_allArr[section] use_order_status] isEqualToString:@"2"]) {
			twoLabel.text = @"待发货";
		}  else {
			twoLabel.text = @"取消订单";
		}
	} else if (isAllOrder == 0){
		moneyLabel.text = [_waitsendArr[section] total_fee];
		dingLabel.text = [_waitsendArr[section] order_sn];

		if ([[_waitsendArr[section] use_order_status] isEqualToString:@"2"]) {
			twoLabel.text = @"待发货";
		}
	} else {
		moneyLabel.text = [_waitPayArr[section] total_fee];
		dingLabel.text = [_waitPayArr[section] order_sn];
		twoLabel.text = @"取消订单";
	}

	return footView;
}

// 退款商品
- (UIView *)footRefundView:(NSInteger)section isAllOrder:(BOOL)isAllOrder {
	UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 50)];
	footView.backgroundColor = [UIColor whiteColor];

	UILabel *moneyLabel = [[UILabel alloc] init];
//	moneyLabel.text = [_refundArr[section] total_fee];
	moneyLabel.font = font(16);
	[footView addSubview:moneyLabel];

	[moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(UNITHEIGHT * 10);
		make.top.mas_equalTo(UNITHEIGHT * 10);
	}];

	UILabel *dingLabel = [[UILabel alloc] init];
//	dingLabel.text = [_refundArr[section] order_sn];
	dingLabel.font = font(14);
	[footView addSubview:dingLabel];

	[dingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(moneyLabel);
		make.right.mas_equalTo(footView).with.offset(-UNITHEIGHT * 30);
	}];

	UIView *lineView = [[UIView alloc] init];
	lineView.backgroundColor = [UIColor colorWithHexString:@"#a5a5a5"];
	[footView addSubview:lineView];

	[lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(1);
		make.left.mas_equalTo(UNITHEIGHT * 10);
		make.right.mas_equalTo(footView).with.offset(-UNITHEIGHT * 30);
		make.bottom.mas_equalTo(footView).with.offset(-UNITHEIGHT * 1);
	}];

//	JustStartTimeView *timeLabel = [[JustStartTimeView alloc] init];
//	[timeLabel countDownViewWithEndString:@"2016-9-11"];
//	[footView addSubview:timeLabel];
//
//	[timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.top.mas_equalTo(lineView).with.offset(UNITHEIGHT * 10);
//		make.centerX.mas_equalTo(lineView);
//		make.width.mas_equalTo(UNITHEIGHT * 100);
//	}];

//	UILabel *explainLabel = [[UILabel alloc] init];
//	explainLabel.text = @"退款中：  ";
//	explainLabel.font = font(14);
//	explainLabel.textAlignment = NSTextAlignmentRight;
//	[footView addSubview:explainLabel];
//
//	[explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.right.mas_equalTo(timeLabel.mas_left);
//		make.centerY.mas_equalTo(timeLabel);
//	}];

	if (isAllOrder) {
//		dingLabel.text = [_allArr[section] order_sn];
//		moneyLabel.text = [_allArr[section] total_fee];
	} else {
		dingLabel.text = [_refundArr[section] order_sn];
		moneyLabel.text = [_refundArr[section] back_goods_price];
	}


	return footView;
}

// 所有订单
- (UIView *)footAllView:(NSInteger)section isAllOrder:(BOOL)isAllOrder {
	UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 100)];
	footView.backgroundColor = [UIColor whiteColor];

	UILabel *moneyLabel = [[UILabel alloc] init];
//	moneyLabel.text = [_allArr[section] total_fee];
	moneyLabel.font = font(16);
	[footView addSubview:moneyLabel];

	[moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(UNITHEIGHT * 10);
		make.top.mas_equalTo(UNITHEIGHT * 10);
	}];

	UILabel *dingLabel = [[UILabel alloc] init];
//	dingLabel.text = [_allArr[section] order_sn];
	dingLabel.font = font(14);
	[footView addSubview:dingLabel];

	[dingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(moneyLabel);
		make.right.mas_equalTo(footView).with.offset(-UNITHEIGHT * 30);
	}];

	UIView *lineView = [[UIView alloc] init];
	lineView.backgroundColor = [UIColor colorWithHexString:@"#a5a5a5"];
	[footView addSubview:lineView];

	[lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(1);
		make.left.mas_equalTo(UNITHEIGHT * 10);
		make.right.mas_equalTo(footView).with.offset(-UNITHEIGHT * 30);
		make.centerY.mas_equalTo(footView).with.offset(-UNITHEIGHT * 10);
	}];

	UILabel *twoLabel = [[UILabel alloc] init];
	twoLabel.text = [NSString stringWithFormat:@"已完成 %@", [_allArr[section] order_time]];
	twoLabel.font = font(14);
	[footView addSubview:twoLabel];

	[twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(lineView).with.offset(UNITHEIGHT * 10);
		make.centerX.mas_equalTo(lineView);
	}];

	dingLabel.text = [_allArr[section] order_sn];
	moneyLabel.text = [_allArr[section] total_fee];
	

	return footView;
}



#pragma mark - footButtonAction
- (void)cancelButton:(UIButton *)button {
	NSLog(@"%ld", button.tag);
	if (button.tag >= 7000000 && button.tag < 7100000) {
		// 取消订单
		[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userOrderOpera.php?act=cancel" params:@{@"order_id" : [_allArr[button.tag - 7000000] order_id]} Success:^(id responseObject) {

			if ([responseObject[@"status"] isEqual:@1]) {
				[RegosterAlert showAlert:@"取消订单成功" err:responseObject[@"info"]];
			} else {
				[RegosterAlert showAlert:@"取消订单失败" err:responseObject[@"info"]];
			}

			dispatch_async(dispatch_get_main_queue(), ^{
				[self createData];
			});
		} Failed:^(NSError *error) {

		}];

	} else if (button.tag >= 7100000 && button.tag < 7200000){
		// 取消订单
		[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userOrderOpera.php?act=cancel" params:@{@"order_id" : [_waitPayArr[button.tag - 7100000] order_id]} Success:^(id responseObject) {

			if ([responseObject[@"status"] isEqual:@1]) {
				[RegosterAlert showAlert:@"取消订单成功" err:responseObject[@"info"]];
			} else {
				[RegosterAlert showAlert:@"取消订单失败" err:responseObject[@"info"]];
			}

			dispatch_async(dispatch_get_main_queue(), ^{
				[self createData];
			});
		} Failed:^(NSError *error) {

		}];
	} else if (button.tag >= 7500000 && button.tag < 7600000) {
		// 延长收货
		[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userOrderOpera.php?act=extend_receive" params:@{@"order_id" : [_allArr[button.tag - 7500000] order_id]} Success:^(id responseObject) {

			if ([responseObject[@"status"] isEqual:@1]) {
				[RegosterAlert showAlert:@"延长收货成功" err:responseObject[@"info"]];
			} else {
				[RegosterAlert showAlert:@"延长收货失败" err:responseObject[@"info"]];
			}

			dispatch_async(dispatch_get_main_queue(), ^{
				[self createData];
			});
		} Failed:^(NSError *error) {

		}];

	} else if (button.tag >= 7600000 && button.tag < 7700000) {
		// 延长收货
		[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userOrderOpera.php?act=extend_receive" params:@{@"order_id" : [_waitsendArr[button.tag - 7600000] order_id]} Success:^(id responseObject) {

			if ([responseObject[@"status"] isEqual:@1]) {
				[RegosterAlert showAlert:@"延长收货成功" err:responseObject[@"info"]];
			} else {
				[RegosterAlert showAlert:@"延长收货失败" err:responseObject[@"info"]];
			}

			dispatch_async(dispatch_get_main_queue(), ^{
				[self createData];
			});
		} Failed:^(NSError *error) {

		}];
	}
}

- (void)sureButton:(UIButton *)button {
	NSLog(@"%ld", button.tag);
	if (button.tag >= 7200000 && button.tag < 7300000) {
		// 确认收货 所有订单

		[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userOrderOpera.php?act=receive_confirm" params:@{@"order_id" : [_allArr[button.tag - 7200000] order_id]} Success:^(id responseObject) {

			if ([responseObject[@"status"] isEqual:@1]) {
				[RegosterAlert showAlert:@"确认收货成功" err:responseObject[@"info"]];
			} else {
				[RegosterAlert showAlert:@"确认收货失败" err:responseObject[@"info"]];
			}
			dispatch_async(dispatch_get_main_queue(), ^{
				[self createData];
			});
		} Failed:^(NSError *error) {

		}];

	} else if (button.tag >= 7300000 && button.tag < 7400000) {
		// 确认收货
		[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userOrderOpera.php?act=receive_confirm" params:@{@"order_id" : [_waitsendArr[button.tag - 7300000] order_id]} Success:^(id responseObject) {

			if ([responseObject[@"status"] isEqual:@1]) {
				[RegosterAlert showAlert:@"确认收货成功" err:responseObject[@"info"]];
			} else {
				[RegosterAlert showAlert:@"确认收货失败" err:responseObject[@"info"]];
			}
			dispatch_async(dispatch_get_main_queue(), ^{
				[self createData];
			});
		} Failed:^(NSError *error) {

		}];
	} else if (button.tag >= 7800000 && button.tag < 7900000) {
		// 确认订单 全部订单
		InfoOrderVC *orderVC = [[InfoOrderVC alloc] init];
		orderVC.order_id = [_allArr[button.tag - 7800000] order_id];
		orderVC.startButton = [_allArr[button.tag - 7800000] use_order_status];
		[self.navigationController pushViewController:orderVC animated:YES];

	} else if (button.tag >= 7900000 && button.tag < 8000000) {
		// 确认订单
		InfoOrderVC *orderVC = [[InfoOrderVC alloc] init];
		orderVC.order_id = [_waitPayArr[button.tag - 7900000] order_id];
		orderVC.startButton = [_waitPayArr[button.tag - 7900000] use_order_status];
		[self.navigationController pushViewController:orderVC animated:YES];
	}
}



#pragma mark - serverButton
- (void)serverButton:(UIButton *)button {

	InfoOrderVC *orderVC = [[InfoOrderVC alloc] init];

	if (button.tag >= 800000 && button.tag < 809999) {
		orderVC.order_id = [_waitPayArr[button.tag - 800000] order_id];
		orderVC.startButton = [_waitPayArr[button.tag - 800000] use_order_status];
		[self.navigationController pushViewController:orderVC animated:YES];
	} else if (button.tag >= 810000 && button.tag < 819999) {
		orderVC.order_id = [_waitsendArr[button.tag - 810000] order_id];
		orderVC.startButton = [_waitsendArr[button.tag - 810000] use_order_status];
		[self.navigationController pushViewController:orderVC animated:YES];
	} else if (button.tag >= 820000 && button.tag < 829999) {
//		orderVC.order_id = [_refundArr[button.tag - 820000] back_id];
//		orderVC.startButton = [_refundArr[button.tag - 82000] status_back];
		NSString *stats = [NSString stringWithFormat:@"%@", [_refundArr[button.tag - 820000] status_back]];
		if ([stats isEqualToString:@"0"]) {
			// 审核通过
			RefundLogisticsVC *refundVC = [[RefundLogisticsVC alloc] init];
			refundVC.back_order_id = [_refundArr[button.tag - 820000] back_id];
			[self.navigationController pushViewController:refundVC animated:YES];

		} else if ([stats isEqualToString:@"1"]) {
			// 收到寄回商品
			InfoOrderStartVC *startVC = [[InfoOrderStartVC alloc] init];
			startVC.back_order_id = [_refundArr[button.tag - 820000] back_id];
			[self.navigationController pushViewController:startVC animated:YES];

		} else if ([stats isEqualToString:@"2"]) {
			// 等待退款 物流
			InfoOrderOtherVC *infoOrderVC = [[InfoOrderOtherVC alloc] init];
			infoOrderVC.back_order_id = [_refundArr[button.tag - 820000] back_id];
			[self.navigationController pushViewController:infoOrderVC animated:YES];

		} else if ([stats isEqualToString:@"3"]) {
			// 同意退款
			OrderRefundVC *refundVC = [[OrderRefundVC alloc] init];
			refundVC.isSuccess = 1;
			refundVC.back_order_id = [_refundArr[button.tag - 820000] back_id];
			[self.navigationController pushViewController:refundVC animated:YES];

		} else if ([stats isEqualToString:@"4"]) {
			// 退款无需退货
			InfoOrderStartVC *startVC = [[InfoOrderStartVC alloc] init];
			startVC.back_order_id = [_refundArr[button.tag - 820000] back_id];
			[self.navigationController pushViewController:startVC animated:YES];

		} else if ([stats isEqualToString:@"5"]) {
			// 审核中
			InfoOrderStartVC *startVC = [[InfoOrderStartVC alloc] init];
			startVC.back_order_id = [_refundArr[button.tag - 820000] back_id];
			[self.navigationController pushViewController:startVC animated:YES];

		} else if ([stats isEqualToString:@"6"]) {
			// 拒绝退款
			OrderRefundVC *refundVC = [[OrderRefundVC alloc] init];
			refundVC.back_order_id = [_refundArr[button.tag - 820000] back_id];
			refundVC.isSuccess = 0;
			[self.navigationController pushViewController:refundVC animated:YES];

		} else if ([stats isEqualToString:@"7"]) {
			// 逾期未退换商品
			InfoOrderStartVC *startVC = [[InfoOrderStartVC alloc] init];
			startVC.back_order_id = [_refundArr[button.tag - 820000] back_id];
			[self.navigationController pushViewController:startVC animated:YES];

		} else if ([stats isEqualToString:@"8"]) {
			// 用户取消
			InfoOrderStartVC *startVC = [[InfoOrderStartVC alloc] init];
			startVC.back_order_id = [_refundArr[button.tag - 820000] back_id];
			[self.navigationController pushViewController:startVC animated:YES];
		}

	} else if (button.tag >= 830000 && button.tag < 839999) {
		orderVC.order_id = [_allArr[button.tag - 830000] order_id];
		orderVC.startButton = [_allArr[button.tag - 830000] use_order_status];
		[self.navigationController pushViewController:orderVC animated:YES];
	}


	// 等待退款
//	InfoOrderOtherVC *orderOtherVC = [[InfoOrderOtherVC alloc] init];
//	[self.navigationController pushViewController:orderOtherVC animated:YES];

	// 同意退款  拒绝退款
//	OrderRefundVC *refundVC = [[OrderRefundVC alloc] init];
//	[self.navigationController pushViewController:refundVC animated:YES];
}





#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
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
