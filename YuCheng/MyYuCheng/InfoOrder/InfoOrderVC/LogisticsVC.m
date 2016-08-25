//
//  LogisticsVC.m
//  YuCheng
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LogisticsVC.h"
#import "LogisticsCell.h"

@interface LogisticsVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UILabel *orderNumberLabel;

@property (nonatomic, strong) UILabel *logisticsNumberLabel;

@property (nonatomic, strong) NSMutableArray *modelArr;

@end

@implementation LogisticsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.title = @"物流详情";

	[self createView];

	[self createData];
}



#pragma mark - createData
- (void)createData {
	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userOrderShippingInfo.php" params:@{@"order_id" : _order_id} Success:^(id responseObject) {

		if (responseObject[@"kuaidi_list"] == [NSNull null]) {

		} else {
			_modelArr = [NSMutableArray  arrayWithArray:responseObject[@"kuaidi_list"]];
		}

		dispatch_async(dispatch_get_main_queue(), ^{
			[_tableView reloadData];
			_orderNumberLabel.text = [NSString stringWithFormat:@"订单编号：%@", responseObject[@"order_info"][@"order_sn"]];
			_logisticsNumberLabel.text = [NSString stringWithFormat:@"快递单号：%@", responseObject[@"order_info"][@"invoice_no"]];
		});

	} Failed:^(NSError *error) {

	}];
}



#pragma mark - createView
- (void)createView {
	[self createHeadView];

	[self createTableView];

}

- (void)createHeadView {
	self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 70)];
	_headView.backgroundColor = [UIColor whiteColor];

	UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(UNITHEIGHT * 20, 0, WIDTH - UNITHEIGHT * 40, 1)];
	topView.backgroundColor = [UIColor colorWithRed:172 / 225.0 green:172 / 225.0 blue:172 / 225.0 alpha:1];
	[_headView addSubview:topView];

	self.orderNumberLabel = [[UILabel alloc] init];
//	_orderNumberLabel.text = @"订单编号：000000000";
	_orderNumberLabel.font = font(14);
	[_headView addSubview:_orderNumberLabel];

	[_orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(topView);
		make.height.mas_equalTo(UNITHEIGHT * 20);
		make.top.mas_equalTo(topView).with.offset(UNITHEIGHT * 10);
	}];

	self.logisticsNumberLabel = [[UILabel alloc] init];
//	_logisticsNumberLabel.text = @"快递单号：00000000";
	_logisticsNumberLabel.font = font(14);
	[_headView addSubview:_logisticsNumberLabel];

	[_logisticsNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.left.mas_equalTo(_orderNumberLabel);
		make.top.mas_equalTo(_orderNumberLabel.mas_bottom).with.offset(UNITHEIGHT * 10);
	}];

	UIView *bottomView = [[UIView alloc] init];
	bottomView.backgroundColor = [UIColor colorWithRed:172 / 225.0 green:172 / 225.0 blue:172 / 225.0 alpha:1];
	[_headView addSubview:bottomView];

	[bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.height.mas_equalTo(topView);
		make.top.mas_equalTo(_logisticsNumberLabel.mas_bottom).with.offset(UNITHEIGHT * 10);
	}];
}

- (void)createTableView {
	self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
	_tableView.backgroundColor = [UIColor whiteColor];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.rowHeight = UNITHEIGHT * 60;
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	_tableView.showsVerticalScrollIndicator = NO;
	[self.view addSubview:_tableView];
	_tableView.tableHeaderView = _headView;

	[_tableView registerClass:[LogisticsCell class] forCellReuseIdentifier:@"logisticsCell"];

}



#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _modelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	LogisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"logisticsCell"];
	cell.backView.backgroundColor = [UIColor whiteColor];
	
	if (indexPath.row == 0) {
		cell.roundView.backgroundColor = [UIColor redColor];
		cell.upView.hidden = YES;
		cell.infoLabel.textColor = [UIColor redColor];
		cell.timeLabel.textColor = [UIColor redColor];
	} else {
		cell.hotView.hidden = YES;
	}

	NSDictionary *dic = _modelArr[indexPath.row];
	cell.timeLabel.text = [NSString stringWithFormat:@"%@", dic[@"time"]];
	cell.infoLabel.text = [NSString stringWithFormat:@"%@", dic[@"context"]];
	[cell.infoLabel sizeToFit];

	return cell;
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
