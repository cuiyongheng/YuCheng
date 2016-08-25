//
//  InfoOrderOtherVC.m
//  YuCheng
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "InfoOrderOtherVC.h"
#import "OrderlogisticsHeadView.h"
#import "LogisticsCell.h"

@interface InfoOrderOtherVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) OrderlogisticsHeadView *headView;

@property (nonatomic, strong) JustStartTimeView *timeView;

@property (nonatomic, strong) NSMutableArray *logisticsArr;

@end

@implementation InfoOrderOtherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.title = @"订单详情";

	[self createView];

	[self createData];
}



#pragma mark - createData
- (void)createData {
	_logisticsArr = [NSMutableArray arrayWithCapacity:0];
	__weak __typeof(&*self)weakSelf = self;
	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/backOrder.php?act=detail" params:@{@"back_order_id" : _back_order_id} Success:^(id responseObject) {

		InfoOrderGoodsModel *model = [InfoOrderGoodsModel mj_objectWithKeyValues:responseObject[@"back_order"]];
		if (responseObject[@"kuaidi_list"] == [NSNull null]) {
		} else {
			[_logisticsArr addObjectsFromArray:responseObject[@"kuaidi_list"]];
		}

		dispatch_async(dispatch_get_main_queue(), ^{
			_headView.model = model;
			[_tableView reloadData];
		});

	} Failed:^(NSError *error) {
		
	}];

}


#pragma mark - createView
- (void)createView {
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, UNITHEIGHT * 160 + 64, WIDTH, HEIGHT - UNITHEIGHT * 240 - 64) style:UITableViewStylePlain];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	_tableView.showsVerticalScrollIndicator = NO;
	_tableView.rowHeight = UNITHEIGHT * 60;
	[self.view addSubview:_tableView];

	[_tableView registerClass:[LogisticsCell class] forCellReuseIdentifier:@"logisticsCell"];

	// head
	self.headView = [[OrderlogisticsHeadView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, UNITHEIGHT * 160)];
	_headView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:_headView];

	// foot
	UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
	cancleButton.backgroundColor = [UIColor whiteColor];
	[cancleButton setTitle:@"取消退款" forState:UIControlStateNormal];
	cancleButton.layer.borderColor = [UIColor blackColor].CGColor;
	cancleButton.layer.borderWidth = 1;
	[cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[cancleButton addTarget:self action:@selector(cancleRefundButton:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:cancleButton];

	[cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(UNITHEIGHT * 45);
		make.left.mas_equalTo(self.view).with.offset(UNITHEIGHT * 20);
		make.right.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 20);
		make.bottom.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 15);
	}];

//	self.timeView = [[JustStartTimeView alloc] init];
//	[_timeView countDownViewWithEndString:@"2016-8-28"];
//	[self.view addSubview:_timeView];
//
//	[_timeView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.mas_equalTo(cancleButton);
//		make.bottom.mas_equalTo(cancleButton.mas_top).with.offset(-UNITHEIGHT * 10);
//		make.height.mas_equalTo(UNITHEIGHT * 20);
//		make.width.mas_equalTo(UNITHEIGHT * 100);
//	}];
//
//	UILabel *refundLabel = [[UILabel alloc] init];
//	refundLabel.text = @"等待退款";
//	refundLabel.font = font(14);
//	[self.view addSubview:refundLabel];
//
//	[refundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.mas_equalTo(cancleButton);
//		make.bottom.mas_equalTo(_timeView.mas_top);
//		make.height.mas_equalTo(UNITHEIGHT * 20);
//	}];

}



#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _logisticsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	LogisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"logisticsCell"];

	if (indexPath.row == 0) {
		cell.roundView.backgroundColor = [UIColor redColor];
		cell.upView.hidden = YES;
		cell.infoLabel.textColor = [UIColor redColor];
		cell.timeLabel.textColor = [UIColor redColor];
	} else {
		cell.hotView.hidden = YES;
		cell.roundView.backgroundColor = [UIColor blackColor];
		cell.upView.hidden = NO;
		cell.infoLabel.textColor = [UIColor blackColor];
		cell.timeLabel.textColor = [UIColor blackColor];
	}

	NSDictionary *dic = _logisticsArr[indexPath.row];
	cell.timeLabel.text = [NSString stringWithFormat:@"%@", dic[@"time"]];
	cell.infoLabel.text = [NSString stringWithFormat:@"%@", dic[@"context"]];
	[cell.infoLabel sizeToFit];

	return cell;
}



#pragma mark - cancleButton
- (void)cancleRefundButton:(UIButton *)button {
	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/backOrder.php?act=cancel" params:@{@"back_order_id" : _back_order_id} Success:^(id responseObject) {

		if ([responseObject[@"status"] isEqual:@1]) {
			[RegosterAlert showAlert:@"取消退款成功" err:nil];
		} else {
			[RegosterAlert showAlert:@"取消退款失败" err:responseObject[@"info"]];
		}

	} Failed:^(NSError *error) {

	}];
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
