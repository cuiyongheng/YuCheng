//
//  MyTicketVC.m
//  YuCheng
//
//  Created by apple on 16/6/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyTicketVC.h"
#import "MyTicketCell.h"
#import "TicketCell.h"
#import "TicketModel.h"

@interface MyTicketVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segment;

@property (nonatomic, strong) UIScrollView *backScroll;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITableView *twoTableView;

@property (nonatomic, strong) UITableView *threeTabelView;

@property (nonatomic, strong) UIView *segLineView;

@property (nonatomic, strong) NSMutableArray *useArr;
@property (nonatomic, strong) NSMutableArray *unuseArr;
@property (nonatomic, strong) NSMutableArray *expiredArr;

@end

@implementation MyTicketVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.title = @"我的卡券";

	[self createView];

	[self createData];
}



#pragma mark - createData
- (void)createData {
	_useArr = [NSMutableArray arrayWithCapacity:0];
	_unuseArr = [NSMutableArray arrayWithCapacity:0];
	_expiredArr = [NSMutableArray arrayWithCapacity:0];

	if (_isMyYuCheng) {
		[NetWorkingTool GetNetWorking:@"http://www.jadechina.cn/mapi/userBonus.php" Params:nil Success:^(id responseObject) {
			_useArr = [TicketModel BaseModel:responseObject[@"bonus_used_list"]];
			_unuseArr = [TicketModel BaseModel:responseObject[@"bonus_unuse_list"]];
			_expiredArr = [TicketModel BaseModel:responseObject[@"bonus_expired_list"]];

			dispatch_async(dispatch_get_main_queue(), ^{
				[_tableView reloadData];
				[_twoTableView reloadData];
				[_threeTabelView reloadData];
			});
		} Failed:^(NSError *error) {
			
		}];
	} else {
		_useArr = [TicketModel BaseModel:_modelArr];
		dispatch_async(dispatch_get_main_queue(), ^{
			[_tableView reloadData];
		});
	}
}

#pragma mark - createView
- (void)createView {
	if (_isMyYuCheng) {
		// 个人中心进入
		// seg
		self.segment = [[UISegmentedControl alloc] initWithItems:@[@"未使用", @"已使用", @"已过期"]];
		_segment.frame = CGRectMake(0, 64, WIDTH, UNITHEIGHT * 43.5);
		_segment.tintColor = [UIColor whiteColor];
		_segment.backgroundColor = [UIColor whiteColor];
		_segment.tintColor = [UIColor whiteColor];
		[_segment addTarget:self action:@selector(myTicketSeg:) forControlEvents:UIControlEventValueChanged];
		[self.view addSubview:_segment];

		UIFont *font = [UIFont boldSystemFontOfSize:12.0f];
		NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
		[_segment setTitleTextAttributes:attributes forState:UIControlStateNormal];
		NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil];
		[_segment setTitleTextAttributes:dic forState:UIControlStateNormal];
		[_segment setTitleTextAttributes:dic forState:UIControlStateSelected];

		self.segLineView = [[UIView alloc] initWithFrame:CGRectMake(0, UNITHEIGHT * 40 + 64, WIDTH / 3, 4)];
		_segLineView.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
		[self.view addSubview:_segLineView];



		self.backScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, UNITHEIGHT * 43.5 + 64, WIDTH, HEIGHT - UNITHEIGHT * 43.5 - 64)];
		_backScroll.contentSize = CGSizeMake(WIDTH * 3, 0);
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
		_tableView.rowHeight = UNITHEIGHT * 136;
		[_backScroll addSubview:_tableView];

		self.twoTableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT - UNITHEIGHT * 43.5 - 64) style:UITableViewStylePlain];
		_twoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		_twoTableView.delegate = self;
		_twoTableView.dataSource = self;
		_twoTableView.rowHeight = UNITHEIGHT * 150;
		_twoTableView.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
		[_backScroll addSubview:_twoTableView];

		self.threeTabelView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH * 2, 0, WIDTH, HEIGHT - UNITHEIGHT * 43.5 - 64) style:UITableViewStylePlain];
		_threeTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
		_threeTabelView.delegate = self;
		_threeTabelView.dataSource = self;
		_threeTabelView.rowHeight = UNITHEIGHT * 136;
		_threeTabelView.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
		[_backScroll addSubview:_threeTabelView];

		[_tableView registerClass:[TicketCell class] forCellReuseIdentifier:@"oneTicketCell"];

		[_twoTableView registerClass:[TicketCell class] forCellReuseIdentifier:@"twoTicketCell"];

		[_threeTabelView registerClass:[TicketCell class] forCellReuseIdentifier:@"threeTicketCell"];
	} else {
		// 结算进入
		self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - UNITHEIGHT * 43.5 - 64) style:UITableViewStylePlain];
		_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		_tableView.delegate = self;
		_tableView.dataSource = self;
		_tableView.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
		_tableView.rowHeight = UNITHEIGHT * 136;
		[self.view addSubview:_tableView];

		[_tableView registerClass:[TicketCell class] forCellReuseIdentifier:@"oneTicketCell"];
	}
}



#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (tableView == _tableView) {
		return _useArr.count;
	} else if (tableView == _twoTableView) {
		return _unuseArr.count;
	} else {
		return _expiredArr.count;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableView == _tableView) {
		TicketCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneTicketCell"];
		cell.model = _useArr[indexPath.row];

		return cell;
	} else if (tableView == _twoTableView) {
		TicketCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoTicketCell"];
		cell.backImageView.image = [UIImage imageNamed:@"卡券_07"];
		cell.startImageView.hidden = NO;
		cell.startImageView.image = [UIImage imageNamed:@"user"];
		cell.model = _unuseArr[indexPath.row];

		return cell;
	} else {
		TicketCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threeTicketCell"];
		cell.backImageView.image = [UIImage imageNamed:@"卡券_07"];
		cell.startImageView.hidden = NO;
		cell.model = _expiredArr[indexPath.row];

		return cell;
	}
}



#pragma mark - segmentAction
- (void)myTicketSeg:(UISegmentedControl *)seg {
	if (seg.selectedSegmentIndex == 0) {
		[_backScroll setContentOffset:CGPointMake(0, 0) animated:YES];
	} else if (seg.selectedSegmentIndex == 1) {
		[_backScroll setContentOffset:CGPointMake(WIDTH, 0) animated:YES];
	} else {
		[_backScroll setContentOffset:CGPointMake(WIDTH * 2, 0) animated:YES];
	}

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
		_segLineView.transform = CGAffineTransformMakeTranslation(WIDTH / 3, 0);

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
		_segLineView.transform = CGAffineTransformMakeTranslation((WIDTH / 3) * 2, 0);
	}

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	if (scrollView == _backScroll) {
		if (scrollView.contentOffset.x == 0) {
			_segment.selectedSegmentIndex = 0;
			[self myTicketSeg:_segment];
		} else if (scrollView.contentOffset.x == WIDTH) {
			_segment.selectedSegmentIndex = 1;
			[self myTicketSeg:_segment];
		} else if (scrollView.contentOffset.x == WIDTH * 2) {
			_segment.selectedSegmentIndex = 2;
			[self myTicketSeg:_segment];
		}
	}
}



#pragma mark - tableViewSelect
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (_isMyYuCheng) {
		// 个人中心进入
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
	} else {
		// 结算进入

		[self.delegate takeTicketID:[NSString stringWithFormat:@"%@", [_useArr[indexPath.row] bonus_id]] ticketName:[NSString stringWithFormat:@"满%@减%@", [_useArr[indexPath.row] min_goods_amount], [_useArr[indexPath.row] type_money]] NSIndex:_NSIndexRow];

		[self.navigationController popViewControllerAnimated:YES];
	}
}


#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
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
