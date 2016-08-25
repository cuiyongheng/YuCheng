//
//  MyEvaluateVC.m
//  YuCheng
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyEvaluateVC.h"
#import "MyEvaluateCell.h"
#import "MyEvaluateFinishCell.h"
#import "EvaluateVC.h"
#import "InfoOrderVC.h"
#import "MyEvaluateModel.h"

@interface MyEvaluateVC ()<UITableViewDataSource, UITableViewDelegate, MyEvaluateCellDelegate, MyEvaluateFinishCellDelegate>

@property (nonatomic, strong) UISegmentedControl *segment;

@property (nonatomic, strong) UIScrollView *backScroll;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITableView *twoTableView;

@property (nonatomic, strong) UIView *segLineView;

@property (nonatomic, strong) NSMutableArray *evaluateArr;

@property (nonatomic, strong) NSMutableArray *unEvaluateArr;

@end

@implementation MyEvaluateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.title = @"我的评价";

	[self createView];

	[self createData];
}



#pragma mark - createData
- (void)createData {
	_evaluateArr = [NSMutableArray arrayWithCapacity:0];
	_unEvaluateArr = [NSMutableArray arrayWithCapacity:0];
	[NetWorkingTool GetNetWorking:@"http://www.jadechina.cn/mapi/userComment.php?act=list" Params:nil Success:^(id responseObject) {

		if (responseObject[@"item_list"] != [NSNull null]) {
			NSMutableArray *arr = [MyEvaluateModel BaseModel:responseObject[@"item_list"]];
			for (MyEvaluateModel *model in arr) {
				if ([model.comment_state isEqualToString:@"0"]) {
					// 待评价
					[_unEvaluateArr addObject:model];
					//				NSLog(@"%@", model.order_id);
				} else {
					// 已评价
					[_evaluateArr addObject:model];
					//				NSLog(@"%@", model.order_id);
				}
			}

			dispatch_async(dispatch_get_main_queue(), ^{
				[_tableView reloadData];
				[_twoTableView reloadData];
			});
		} else {

		}

	} Failed:^(NSError *error) {

	}];
}



#pragma mark - createView
- (void)createView {
	// seg
	self.segment = [[UISegmentedControl alloc] initWithItems:@[@"待评价", @"已评价"]];
	_segment.frame = CGRectMake(0, 64, WIDTH, UNITHEIGHT * 43.5);
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



	self.backScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, UNITHEIGHT * 43.5 + 64, WIDTH, HEIGHT - UNITHEIGHT * 43.5 - 64)];
	_backScroll.contentSize = CGSizeMake(WIDTH * 2, 0);
	_backScroll.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
	_backScroll.pagingEnabled = YES;
	_backScroll.delegate = self;
	_backScroll.showsHorizontalScrollIndicator = NO;
	[self.view addSubview:_backScroll];



	self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - UNITHEIGHT * 43.5 - 64) style:UITableViewStylePlain];
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
	_tableView.rowHeight = UNITHEIGHT * 270;
	[_backScroll addSubview:_tableView];

	self.twoTableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT - UNITHEIGHT * 43.5 - 64) style:UITableViewStylePlain];
	_twoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	_twoTableView.delegate = self;
	_twoTableView.dataSource = self;
	_twoTableView.rowHeight = UNITHEIGHT * 270;
	_twoTableView.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
	[_backScroll addSubview:_twoTableView];

	[_tableView registerClass:[MyEvaluateCell class] forCellReuseIdentifier:@"evaluteCell"];

	[_twoTableView registerClass:[MyEvaluateFinishCell class] forCellReuseIdentifier:@"twoEvaluteCell"];

	self.segLineView = [[UIView alloc] initWithFrame:CGRectMake(0, UNITHEIGHT * 43.5 + 64, UNITHEIGHT * 187.5, 4)];
	_segLineView.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
	[self.view addSubview:_segLineView];
}



#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (tableView == _tableView) {
		return _unEvaluateArr.count;
	} else {
		return _evaluateArr.count;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableView == _tableView) {
		MyEvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"evaluteCell"];
		cell.delegate = self;
		cell.model = _unEvaluateArr[indexPath.row];
		cell.pingjiaButton.tag = 9000000 + indexPath.row;
		cell.infoButton.tag = 9100000 + indexPath.row;
		cell.infoButton.hidden = YES;

		return cell;
	} else {
		MyEvaluateFinishCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoEvaluteCell"];
		cell.delegate = self;
		cell.model = _evaluateArr[indexPath.row];
		cell.infoButton.tag = 9200000 + indexPath.row;

		return cell;
	}
}



#pragma mark - cellDelegate
- (void)takeEvaluate:(NSInteger)viewTag {
	EvaluateVC *evaluateVC = [[EvaluateVC alloc] init];
	evaluateVC.goodsID = [_unEvaluateArr[viewTag - 9000000] goods_id];
	evaluateVC.rec_id = [_unEvaluateArr[viewTag - 9000000] rec_id];
	evaluateVC.isFinishEvaluate = 0;
	[self.navigationController pushViewController:evaluateVC animated:YES];
}

- (void)pushInfoOrede:(NSInteger)buttonTag {
//	InfoOrderVC *orderVC = [[InfoOrderVC alloc] init];
//	[self.navigationController pushViewController:orderVC animated:YES];
	if (buttonTag >= 9100000 && buttonTag < 9199999) {
//		NSLog(@"%@", [_unEvaluateArr[buttonTag - 9100000] order_id]);
//		orderVC.order_id = [_unEvaluateArr[buttonTag - 9100000] order_id];
	} else {
//		NSLog(@"%@", [_evaluateArr[buttonTag - 9200000] rec_id]);

		EvaluateVC *evaluateVC = [[EvaluateVC alloc] init];
		evaluateVC.goodsID = [_evaluateArr[buttonTag - 9200000] goods_id];
		evaluateVC.rec_id = [_evaluateArr[buttonTag - 9200000] rec_id];
		evaluateVC.isFinishEvaluate = 1;
		[self.navigationController pushViewController:evaluateVC animated:YES];



//		for (MyEvaluateModel *model in _evaluateArr) {
//			NSLog(@"%@", model.rec_id);
//		}

//		orderVC.order_id = [_evaluateArr[buttonTag - 9200000] order_id];
	}
}


#pragma mark - segmentAction
- (void)segmentAction:(UISegmentedControl *)seg {
	if (seg.selectedSegmentIndex == 0) {
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

		[_backScroll setContentOffset:CGPointMake(0, 0) animated:YES];
	} else if (seg.selectedSegmentIndex == 1) {
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
		[_backScroll setContentOffset:CGPointMake(WIDTH, 0) animated:YES];
	}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	if (scrollView == _backScroll) {
		if (scrollView.contentOffset.x == 0) {
			_segment.selectedSegmentIndex = 0;
			[self segmentAction:_segment];
		} else if (scrollView.contentOffset.x == WIDTH) {
			_segment.selectedSegmentIndex = 1;
			[self segmentAction:_segment];
		}
	}
}



#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.tabBarController.tabBar.hidden = YES;
	[self createData];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
//	self.tabBarController.tabBar.hidden = NO;
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
