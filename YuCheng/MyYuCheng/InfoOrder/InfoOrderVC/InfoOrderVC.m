//
//  InfoOrderVC.m
//  YuCheng
//
//  Created by apple on 16/6/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "InfoOrderVC.h"
#import "InfoOrderView.h"
#import "RefundVC.h"
#import "InfoOrderModel.h"
#import "infoProductModel.h"
#import "MyEvaluateVC.h"
#import "InfoOrderCell.h"
#import "InfoOrderAddCell.h"
#import "LogisticsVC.h"
#import "RefundLogisticsVC.h"

@interface InfoOrderVC ()<UITableViewDataSource, UITableViewDelegate, InfoOrderViewDelegate, InfoOrderCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

//@property (nonatomic, strong) InfoOrderView *headView;

@property (nonatomic, strong) InfoOrderModel *model;

@property (nonatomic, strong) infoProductModel *goodsModel;

@property (nonatomic, strong) JustStartTimeView *timeView;

@property (nonatomic, strong) NSMutableArray *goodsArr;

@end

@implementation InfoOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.title = @"订单详情";

	[self createData];

	[self createView];

}



#pragma mark - createData
- (void)createData {
	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userOrderDetail.php" params:@{@"order_id" : _order_id} Success:^(id responseObject) {

		NSLog(@"%@", responseObject);
		_model = [InfoOrderModel mj_objectWithKeyValues:responseObject[@"order"]];
		_goodsArr = [infoProductModel BaseModel:responseObject[@"goods_list"]];

		dispatch_async(dispatch_get_main_queue(), ^{
//			_headView.model = _model;
//			_headView.goodsModel = _goodsModel;
			[_tableView reloadData];

			NSString *str = [self timetransform:_model.shipping_end_remain_time];
			[_timeView countDownViewWithEndData:[NSDate dateWithTimeIntervalSinceNow:[str integerValue]]];
		});

	} Failed:^(NSError *error) {

	}];
}

#pragma mark - createView
- (void)createView {
//	self.headView = [[InfoOrderView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, UNITHEIGHT * 200)];
//	_headView.backgroundColor = [UIColor whiteColor];
//	_headView.delegate = self;
//	[self.view addSubview:_headView];

	self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - UNITHEIGHT * 150) style:UITableViewStylePlain];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.bounces = NO;
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	_tableView.showsVerticalScrollIndicator = NO;
	[self.view addSubview:_tableView];

	[_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"infoOrderCell"];

	[_tableView registerClass:[InfoOrderCell class] forCellReuseIdentifier:@"goodsCell"];

	[_tableView registerClass:[InfoOrderAddCell class] forCellReuseIdentifier:@"addCell"];

	[self startButtonToCreateView];
}

#pragma mark - startButton
- (void)startButtonToCreateView {
	// button
	if ([_startButton isEqualToString:@"3"]) {
		// 已完成
		UIButton *pingjiaButton = [UIButton buttonWithType:UIButtonTypeCustom];
		pingjiaButton.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
		[pingjiaButton setTitle:@"评价订单" forState:UIControlStateNormal];
		[pingjiaButton addTarget:self action:@selector(pingjiaButton:) forControlEvents:UIControlEventTouchUpInside];
		[pingjiaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[self.view addSubview:pingjiaButton];

		[pingjiaButton mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.mas_equalTo(self.view);
			make.bottom.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 15);
			make.height.mas_equalTo(UNITHEIGHT * 45);
			make.width.mas_equalTo(UNITHEIGHT * 315);
		}];

		_tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT - UNITHEIGHT * 80);
		//		_headView.startLabel.text = @"已完成";
		//		_headView.refundButton.hidden = YES;
	} else if ([_startButton isEqualToString:@"2"] || [_startButton isEqualToString:@"0"]) {
		// 待发货
		UIButton *tixingButton = [UIButton buttonWithType:UIButtonTypeCustom];
		tixingButton.backgroundColor = [UIColor whiteColor];
		//		[tixingButton setTitle:@"提醒发货" forState:UIControlStateNormal];
		[tixingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[self.view addSubview:tixingButton];

		[tixingButton mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.mas_equalTo(self.view);
			make.bottom.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 15);
			make.height.mas_equalTo(UNITHEIGHT * 45);
			make.width.mas_equalTo(UNITHEIGHT * 315);
		}];
		if ([_startButton isEqualToString:@"2"]) {
			//			_headView.startLabel.text = @"待发货";
//			[tixingButton setTitle:@"提醒发货" forState:UIControlStateNormal];
		} else {
			//			_headView.startLabel.text = @"取消订单";
			//			_headView.refundButton.hidden = YES;
			[tixingButton setTitle:@"已取消" forState:UIControlStateNormal];
			tixingButton.userInteractionEnabled = NO;
			tixingButton.backgroundColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1];
			[tixingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		}

		_tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT - UNITHEIGHT * 80);
	}
	//	else if (_startButton == 2) {
	//		// 审核中
	//		UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
	//		cancelButton.backgroundColor = [UIColor whiteColor];
	//		[cancelButton setTitle:@"取消退款" forState:UIControlStateNormal];
	//		[cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	//		cancelButton.layer.borderWidth = 1;
	//		cancelButton.layer.borderColor = [UIColor blackColor].CGColor;
	//		[self.view addSubview:cancelButton];
	//
	//		[cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
	//			make.centerX.mas_equalTo(self.view);
	//			make.bottom.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 15);
	//			make.height.mas_equalTo(UNITHEIGHT * 45);
	//			make.width.mas_equalTo(UNITHEIGHT * 315);
	//		}];
	//
	//		JustStartTimeView *timeView = [[JustStartTimeView alloc] init];
	//		[timeView countDownViewWithEndString:@"2016-8-28"];
	//		timeView.dayLabel.font = font(14);
	//		timeView.hourLabel.font = font(14);
	//		timeView.minuteLabel.font = font(14);
	//		timeView.secondLabel.font = font(14);
	//		[self.view addSubview:timeView];
	//
	//		[timeView mas_makeConstraints:^(MASConstraintMaker *make) {
	//			make.bottom.mas_equalTo(cancelButton.mas_top).with.offset(-UNITHEIGHT * 30);
	//			make.left.mas_equalTo(cancelButton);
	//			make.height.mas_equalTo(UNITHEIGHT * 20);
	//			make.width.mas_equalTo(UNITHEIGHT * 130);
	//		}];
	//
	//		UILabel *tureLabel = [[UILabel alloc] init];
	//		tureLabel.text = @"退款中";
	//		tureLabel.font = font(14);
	//		[self.view addSubview:tureLabel];
	//
	//		[tureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
	//			make.bottom.mas_equalTo(timeView.mas_top);
	//			make.left.mas_equalTo(cancelButton);
	//			make.height.mas_equalTo(UNITHEIGHT * 20);
	//
	//		}];
	//
	//		_headView.startLabel.text = @"审核中";
	//	}
	else if ([_startButton isEqualToString:@"5"]) {
		// 退款中
		UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
		cancelButton.backgroundColor = [UIColor whiteColor];
		[cancelButton setTitle:@"取消退款" forState:UIControlStateNormal];
		[cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[cancelButton addTarget:self action:@selector(cancelMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
		cancelButton.layer.borderWidth = 1;
		cancelButton.layer.borderColor = [UIColor blackColor].CGColor;
		[self.view addSubview:cancelButton];

		[cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.mas_equalTo(self.view);
			make.bottom.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 15);
			make.height.mas_equalTo(UNITHEIGHT * 45);
			make.width.mas_equalTo(UNITHEIGHT * 315);
		}];

		JustStartTimeView *timeView = [[JustStartTimeView alloc] init];
		[timeView countDownViewWithEndString:@"2016-8-28"];
		timeView.dayLabel.font = font(14);
		timeView.hourLabel.font = font(14);
		timeView.minuteLabel.font = font(14);
		timeView.secondLabel.font = font(14);
		[self.view addSubview:timeView];

		[timeView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.bottom.mas_equalTo(cancelButton.mas_top).with.offset(-UNITHEIGHT * 30);
			make.left.mas_equalTo(cancelButton);
			make.height.mas_equalTo(UNITHEIGHT * 20);
			make.width.mas_equalTo(UNITHEIGHT * 130);
		}];

		UILabel *tureLabel = [[UILabel alloc] init];
		tureLabel.text = @"退款中";
		tureLabel.font = font(14);
		[self.view addSubview:tureLabel];

		[tureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
			make.bottom.mas_equalTo(timeView.mas_top);
			make.left.mas_equalTo(cancelButton);
			make.height.mas_equalTo(UNITHEIGHT * 20);

		}];

		//		_headView.startLabel.text = @"退款中";
		//		_headView.refundButton.hidden = YES;
	} else if ([_startButton isEqualToString:@"1"]) {
		// 待付款
		UIButton *fukuanButton = [UIButton buttonWithType:UIButtonTypeCustom];
		fukuanButton.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
		[fukuanButton setTitle:@"付款" forState:UIControlStateNormal];
		[fukuanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[fukuanButton addTarget:self action:@selector(fukuanButton:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:fukuanButton];

		[fukuanButton mas_makeConstraints:^(MASConstraintMaker *make) {
			make.right.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 30);
			make.bottom.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 15);
			make.height.mas_equalTo(UNITHEIGHT * 45);
			make.width.mas_equalTo(UNITHEIGHT * 150);
		}];

		UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
		cancelButton.backgroundColor = [UIColor blackColor];
		[cancelButton setTitle:@"取消订单" forState:UIControlStateNormal];
		[cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[cancelButton addTarget:self action:@selector(cancelOrderButton:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:cancelButton];

		[cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.mas_equalTo(self.view).with.offset(UNITHEIGHT * 30);
			make.bottom.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 15);
			make.height.mas_equalTo(UNITHEIGHT * 45);
			make.width.mas_equalTo(UNITHEIGHT * 150);
		}];

		_tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT - UNITHEIGHT * 80);
		//		_headView.startLabel.text = @"待付款";
		//		_headView.refundButton.hidden = YES;
	} else if ([_startButton isEqualToString:@"4"]) {
		// 已发货
		UIButton *tureButton = [UIButton buttonWithType:UIButtonTypeCustom];
		tureButton.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
		[tureButton setTitle:@"确认收货" forState:UIControlStateNormal];
		[tureButton addTarget:self action:@selector(tureSendButton:) forControlEvents:UIControlEventTouchUpInside];
		[tureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[self.view addSubview:tureButton];

		[tureButton mas_makeConstraints:^(MASConstraintMaker *make) {
			make.right.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 30);
			make.bottom.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 15);
			make.height.mas_equalTo(UNITHEIGHT * 45);
			make.width.mas_equalTo(UNITHEIGHT * 150);
		}];

		UIButton *yanchangButton = [UIButton buttonWithType:UIButtonTypeCustom];
		yanchangButton.backgroundColor = [UIColor blackColor];
		[yanchangButton setTitle:@"延长收货" forState:UIControlStateNormal];
		[yanchangButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[yanchangButton addTarget:self action:@selector(yanchangButton:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:yanchangButton];

		[yanchangButton mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.mas_equalTo(self.view).with.offset(UNITHEIGHT * 30);
			make.bottom.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 15);
			make.height.mas_equalTo(UNITHEIGHT * 45);
			make.width.mas_equalTo(UNITHEIGHT * 150);
		}];

		self.timeView = [[JustStartTimeView alloc] init];
		//		[_timeView countDownViewWithEndString:@"2016-8-28"];
		_timeView.dayLabel.font = font(14);
		_timeView.hourLabel.font = font(14);
		_timeView.minuteLabel.font = font(14);
		_timeView.secondLabel.font = font(14);
		[self.view addSubview:_timeView];

		[_timeView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.bottom.mas_equalTo(yanchangButton.mas_top).with.offset(-UNITHEIGHT * 30);
			make.left.mas_equalTo(yanchangButton);
			make.height.mas_equalTo(UNITHEIGHT * 20);
			make.width.mas_equalTo(UNITHEIGHT * 130);
		}];

		UILabel *tureLabel = [[UILabel alloc] init];
		tureLabel.text = @"自动确认";
		tureLabel.font = font(14);
		[self.view addSubview:tureLabel];

		[tureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
			make.bottom.mas_equalTo(_timeView.mas_top);
			make.left.mas_equalTo(yanchangButton);
			make.height.mas_equalTo(UNITHEIGHT * 20);
			
		}];
		
		UIButton *LogisticsButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[LogisticsButton setTitle:@"查看物流" forState:UIControlStateNormal];
		[LogisticsButton setTitleColor:[UIColor colorWithHexString:@"#792b34"] forState:UIControlStateNormal];
		[LogisticsButton addTarget:self action:@selector(logisticsButton:) forControlEvents:UIControlEventTouchUpInside];
		LogisticsButton.titleLabel.font = font(14);
		[self.view addSubview:LogisticsButton];

		[LogisticsButton mas_makeConstraints:^(MASConstraintMaker *make) {
			make.right.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 20);
			make.height.mas_equalTo(UNITHEIGHT * 20);
			make.top.mas_equalTo(tureLabel);
			make.width.mas_equalTo(UNITHEIGHT * 80);
		}];

		UIImageView *logisticsImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yc6.24-94"]];
		[self.view addSubview:logisticsImageView];

		[logisticsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.right.mas_equalTo(LogisticsButton.mas_left).with.offset(-UNITHEIGHT * 10);
			make.centerY.mas_equalTo(LogisticsButton);
			make.height.width.mas_equalTo(UNITHEIGHT * 15);
		}];
		
		//		_headView.startLabel.text = @"已发货";
	}
}



#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if ([_startButton isEqualToString:@"5"]) {
		return 5 + _goodsArr.count;
	} else if ([_startButton isEqualToString:@"4"]) {
		return 7 + _goodsArr.count;
	} else if ([_startButton isEqualToString:@"2"]) {
		return 4 + _goodsArr.count;
	} else if ([_startButton isEqualToString:@"1"]) {
		return 3 + _goodsArr.count;
	} else if ([_startButton isEqualToString:@"3"]) {
		return 6 + _goodsArr.count;
	} else {
		return 3 + _goodsArr.count;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	if (indexPath.row < _goodsArr.count) {
		// 商品
		InfoOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodsCell"];

		cell.refundButton.tag = 700000 + indexPath.row;
		cell.goodsModel = _goodsArr[indexPath.row];
		cell.nameLabel.text = [NSString stringWithFormat:@"%@", _model.shop_name];
		cell.delegate = self;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;

		if ([_startButton isEqualToString:@"3"]) {
			// 已完成
			cell.startLabel.text = @"已完成";
			cell.refundButton.hidden = YES;
		} else if ([_startButton isEqualToString:@"2"] || [_startButton isEqualToString:@"0"]) {
			// 待发货
			if ([_startButton isEqualToString:@"2"]) {
				cell.startLabel.text = @"待发货";
			} else {
				cell.startLabel.text = @"取消订单";
				cell.refundButton.hidden = YES;
			}
		}
		//	else if (_startButton == 2) {
		//		// 审核中
		//		UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
		//		cancelButton.backgroundColor = [UIColor whiteColor];
		//		[cancelButton setTitle:@"取消退款" forState:UIControlStateNormal];
		//		[cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		//		cancelButton.layer.borderWidth = 1;
		//		cancelButton.layer.borderColor = [UIColor blackColor].CGColor;
		//		[self.view addSubview:cancelButton];
		//
		//		[cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
		//			make.centerX.mas_equalTo(self.view);
		//			make.bottom.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 15);
		//			make.height.mas_equalTo(UNITHEIGHT * 45);
		//			make.width.mas_equalTo(UNITHEIGHT * 315);
		//		}];
		//
		//		JustStartTimeView *timeView = [[JustStartTimeView alloc] init];
		//		[timeView countDownViewWithEndString:@"2016-8-28"];
		//		timeView.dayLabel.font = font(14);
		//		timeView.hourLabel.font = font(14);
		//		timeView.minuteLabel.font = font(14);
		//		timeView.secondLabel.font = font(14);
		//		[self.view addSubview:timeView];
		//
		//		[timeView mas_makeConstraints:^(MASConstraintMaker *make) {
		//			make.bottom.mas_equalTo(cancelButton.mas_top).with.offset(-UNITHEIGHT * 30);
		//			make.left.mas_equalTo(cancelButton);
		//			make.height.mas_equalTo(UNITHEIGHT * 20);
		//			make.width.mas_equalTo(UNITHEIGHT * 130);
		//		}];
		//
		//		UILabel *tureLabel = [[UILabel alloc] init];
		//		tureLabel.text = @"退款中";
		//		tureLabel.font = font(14);
		//		[self.view addSubview:tureLabel];
		//
		//		[tureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		//			make.bottom.mas_equalTo(timeView.mas_top);
		//			make.left.mas_equalTo(cancelButton);
		//			make.height.mas_equalTo(UNITHEIGHT * 20);
		//
		//		}];
		//
		//		_headView.startLabel.text = @"审核中";
		//	}
		else if ([_startButton isEqualToString:@"5"]) {
			// 退款中
			cell.startLabel.text = @"退款中";
			cell.refundButton.hidden = YES;
		} else if ([_startButton isEqualToString:@"1"]) {
			// 待付款
			cell.startLabel.text = @"待付款";
			cell.refundButton.hidden = YES;
		} else if ([_startButton isEqualToString:@"4"]) {
			// 已发货
			cell.startLabel.text = @"已发货";
		}

		if ([_model.pay_id isEqualToString:@"6"]) {
			// 货到付款
			if ([_model.pay_status isEqualToString:@"2"]) {
				// 已付款

			} else {
				// 未付款
				cell.refundButton.hidden = YES;
			}
		}

		return cell;
	} else if (indexPath.row == _goodsArr.count) {
		// 地址
		InfoOrderAddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addCell"];
		cell.model = _model;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;

		return cell;
	} else {
		// 时间
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoOrderCell"];

		cell.textLabel.font = font(14);
		cell.selectionStyle = UITableViewCellSelectionStyleNone;

		if (indexPath.row == _goodsArr.count + 1) {
			cell.textLabel.text = [NSString stringWithFormat:@"订单编号：%@", _model.order_sn];;
		} else if (indexPath.row == 1 + _goodsArr.count + 1) {
			cell.textLabel.text = [NSString stringWithFormat:@"创建时间：%@", [self timetransform:_model.add_time]];
		} else if (indexPath.row == 2 + _goodsArr.count + 1) {
			cell.textLabel.text = [NSString stringWithFormat:@"付款时间：%@", [self timetransform:_model.pay_time]];
		} else if (indexPath.row == 3 + _goodsArr.count + 1) {
			cell.textLabel.text = [NSString stringWithFormat:@"发货时间：%@", [self timetransform:_model.shipping_time]];
		} else if (indexPath.row == 4 + _goodsArr.count + 1) {
			cell.textLabel.text = [NSString stringWithFormat:@"收货时间：%@", [self timetransform:_model.shipping_time_end]];
		} else {
			cell.textLabel.text = [NSString stringWithFormat:@"物流订单：%@" , _model.invoice_no];
		}
		
		return cell;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row < _goodsArr.count) {
		// 商品

		return UNITHEIGHT * 120;
	} else if (indexPath.row == _goodsArr.count) {
		// 地址

		return UNITHEIGHT * 65;
	} else {
		// 时间
		return UNITHEIGHT * 44;
	}

}


#pragma mark - 时间戳
- (NSString *)timetransform:(NSString *)timestamp {
	if (timestamp.length == 0) {
		return @"";
	}
	if ([timestamp isEqualToString:@"0"]) {
		return @"";
	}
	NSString *str = timestamp;//时间戳
	NSTimeInterval time = [str doubleValue] + 28800;//因为时差问题要加8小时 == 28800 sec
	NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
	//实例化一个NSDateFormatter对象
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	//设定时间格式,这里可以设置成自己需要的格式
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
	return currentDateStr;
}



#pragma mark - 付款
- (void)fukuanButton:(UIButton *)button {
	NSLog(@"");

	if ([_model.pay_id isEqualToString:@"1"]) {
		// 支付宝
//		[self alipay];

	} else if ([_model.pay_id isEqualToString:@"7"]) {
		// 微信支付

		if ([_model.parent_order_id isEqual:@0]) {
			// 单个商品
			[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/apppay.php" params:@{@"order_id" : _model.order_id} Success:^(id responseObject) {

				NSLog(@"%@", responseObject);

				[WXPay WXPay:responseObject Success:^{
					// 支付成功

				}];

			} Failed:^(NSError *error) {
				
			}];

		} else {
			// 多个商品
			[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/apppay.php" params:@{@"parent_order_id" : _model.parent_order_id} Success:^(id responseObject) {

				NSLog(@"%@", responseObject);

				[WXPay WXPay:responseObject Success:^{
					// 支付成功

				}];

			} Failed:^(NSError *error) {
				
			}];


		}

	} else if ([_model.pay_id isEqualToString:@"6"]) {
		// 货到付款
		NSLog(@"真特么烦， 身上的味道不是难闻， 是根本不想闻， s");
	}

}

#pragma mark - 收到支付成功的消息后作相应的处理
- (void)getOrderPayResult:(NSNotification *)notification
{
	if ([notification.object isEqualToString:@"success"])
	{
		NSLog(@"支付成功！");

		if ([_model.parent_order_id isEqual:@0]) {
			// 一个订单
			[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/payResult.php" params:@{@"order_id" : _model.order_id} Success:^(id responseObject) {

				if ([responseObject[@"retcode"] isEqualToString:@"0"]) {
					[self showAlert:@"支付失败" err:responseObject[@"retmsg"]];
				} else {
					[self showAlert:@"支付成功" err:responseObject[@"retmsg"]];

				}

			} Failed:^(NSError *error) {

			}];
		} else {
			// 多个订单
			[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/payResult.php" params:@{@"parent_order_id" : _model.parent_order_id} Success:^(id responseObject) {

				if ([responseObject[@"retcode"] isEqualToString:@"0"]) {
					[self showAlert:@"支付失败" err:responseObject[@"retmsg"]];
				} else {
					[self showAlert:@"支付成功" err:responseObject[@"retmsg"]];

				}

			} Failed:^(NSError *error) {

			}];
		}
	}
	else
	{
		if ([_model.parent_order_id isEqual:@0]) {
			// 一个订单
			[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/payResult.php" params:@{@"order_id" : _model.order_id} Success:^(id responseObject) {

				if ([responseObject[@"retcode"] isEqualToString:@"0"]) {
					[self showAlert:@"支付失败" err:responseObject[@"retmsg"]];
				} else {
					[self showAlert:@"支付成功" err:responseObject[@"retmsg"]];

				}

			} Failed:^(NSError *error) {

			}];
		} else {
			// 多个订单
			[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/payResult.php" params:@{@"parent_order_id" : _model.parent_order_id} Success:^(id responseObject) {

				if ([responseObject[@"retcode"] isEqualToString:@"0"]) {
					[self showAlert:@"支付失败" err:responseObject[@"retmsg"]];
				} else {
					[self showAlert:@"支付成功" err:responseObject[@"retmsg"]];

				}

			} Failed:^(NSError *error) {
				
			}];
		}
		
		NSLog(@"支付失败！");
	}
}
- (void)showAlert:(NSString *)title err:(NSString *)err {
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:err preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction *tureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		[self.navigationController popToRootViewControllerAnimated:YES];
	}];
	[alert addAction:tureAction];

	[self presentViewController:alert animated:YES completion:^{

	}];
}



#pragma mark - alipay
//- (void)alipay {
//	/**
//	 *  商户的唯一的parnter和seller。商户签约成功后，支付宝会为每
//	 *  个商户分配一个唯一的 parnter(appID) 和 seller(支付宝账号)。
//	 *  privateKey生成的私钥，可放在本地，建议放在服务器端
//	 */
//	NSString *partner = @"";
//	NSString *seller = @"";
//	// partner和seller获取失败
//	if ([partner length] == 0 || [seller length] == 0)
//	{
//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"缺少partner或者seller。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//		[alert show];
//		return;
//	}
//	// 应用注册scheme,在Info.plist定义URL types URL scheme
//	NSString *appScheme = @"test";
//	// 将商品信息拼接成字符串
//	NSString *orderSpec = [self createOrderInfoWithPartner:partner Seller:seller];
//	// 进行签名并将签名成功后的字符串格式化为订单字符串
//	NSString *signedString = [self doRsa:orderSpec];
//	// 调用支付宝SDK发送数据
//	[self sendValueToAliPayWithOrderString:signedString FromScheme:appScheme];
//
//}

//#warning 1.生成预支付订单信息
//- (NSString *)createOrderInfoWithPartner:(NSString *)partner
//								  Seller:(NSString *)seller
//{
//	/**
//	 *由于demo的局限性，采用了将私钥放在本地签名的方法，商户可以根据自身情况选择签名方法(为安全起
//	 *见,在条件允许的前提下，推荐从自己的服务器获取完整的订单信息)
//	 */
//	// 将商品信息赋予Order的成员变量
//	Order *order = [[Order alloc] init];
//	order.partner = partner;
//	order.seller = seller;
//	order.tradeNO = @"123432121222"; //订单ID（由商家自行制定）
//	order.productName = @"商品标题"; //商品标题
//	order.productDescription = @"商品描述"; //商品描述
//	order.amount = @"0.01"; //商品价格
//	order.notifyURL =  @""; //回调URL
//	// 这以下是固定形式每个app都是这么写
//	order.service = @"mobile.securitypay.pay";
//	order.paymentType = @"1";
//	order.inputCharset = @"utf-8";
//	order.itBPay = @"30m";
//	order.showUrl = @"m.alipay.com";
//	return [order description];
//}
//
//#warning 2.将订单信息用私钥进行签名
//// 获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//// 此demo是在app内部做的签名
//// 订单签名应该用私钥，但是把私钥放到app里其实本身就不安全，因为你的app是分发到用户手里的，私钥应该放在自己的手里，分发出去的应该是公钥。所以私钥最好是放在自己的服务器上，订单加密这个工作放在服务器端来做，服务器将包含签名的订单信息返回给app，app再通过SDK发送给支付宝，这样会更安全些；而且服务器也能掌握所有的订单状况
//- (NSString *)doRsa:(NSString *)orderInfo
//{
//	id<DataSigner> signer;
//	signer = CreateRSADataSigner(PartnerPrivateKey);
//	NSString *signedString = [signer signString:orderInfo];
//	// 将签名成功字符串格式化为订单字符串,请严格按照该格式
//	NSString *orderString = nil;
//	if (signedString != nil) {
//		orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderInfo, signedString, @"RSA"];
//		NSLog(@"orderString ====   %@\nsignerString  ========== %@", orderString, signedString);
//	}
//	return orderString;
//}
//
//#warning 3.调用支付宝SDK发送请求数据
//- (void)sendValueToAliPayWithOrderString:(NSString *)orderString FromScheme:(NSString *)appScheme
//{
//	[[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//		// 用SBJSON 或者 JSONKit 将回调信息(字典)转成字符串
//		SBJSON *sbJson = [[SBJSON alloc] init];
//		NSString *resultDicToString = [sbJson stringWithObject:resultDic error:nil];
//		[self paymentResult:resultDicToString];
//		NSLog(@"回调结果reslut = %@",resultDic);
//		//            NSLog(@"%d%@", [[resultDic objectForKey:@"resultStatus"] intValue], [resultDic objectForKey:@"memo"]);
//	}];
//
//}
//
//#warning 4.对支付回调的结果进行验证(这一步加上是确保数据的安全,不加不影响支付)
//// 就是在生产订单时，需要使用私钥生成签名值；在处理返回的支付结果时，需要使用公钥验证返回结果是否被篡改了。
//// resultDic 返回结果所对应的值可以到支付宝开发平台上去查
//// 在处理结果之前应该先对支付结果进行签名验证，防止支付数据被篡改。
//// 返回的支付结果中的result字段里是带有订单信息和签名信息的，所以签名验证就是需要这个字段的值。
//// 验证的步骤：首先把订单信息和签名值分别提取出来
//// 订单信息就是sign_type的连字符&之前的所有字符串
//// 签名值是sign后面双引号内的内容，注意签名的结尾也是=
//
//
//// 此demo我是用SBJSON 或者 JSONKit 将回调信息(字典)转成字符串
//// 也可以不使用SBJSON或者JSONKit处理回调信息,直接在回调结果中截取需要的字符串也可以,直接调用可以直接使用Util目录下的DataVerifier来作签名验证"- (BOOL)verifyString:(NSString *)string withSign:(NSString *)signString"第一个参数就是订单信息，第二个参数就是签名值。
//- (void)paymentResult:(NSString *)resultDicToString
//{
//	//结果处理
//	AlixPayResult *result = [[AlixPayResult alloc] initWithString:resultDicToString];
//	if (result)
//	{
//		/**
//		 * 状态码
//		 * 9000 订单支付成功
//		 * 8000 正在处理中
//		 * 4000 订单支付失败
//		 * 6001 用户中途取消
//		 * 6002 网络连接出错
//		 */
//		if (result.statusCode == 9000)
//		{
//			/**
//			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
//			 */
//			// 交易成功
//			NSString* key = AlipayPublicKey;
//			id<DataVerifier> verifier;
//			verifier = CreateRSADataVerifier(key);
//			// 参数1：订单信息
//			// 参数2：签名值
//			/**< resultString.订单信息以及验证签名信息*/
//			/*如果你不想做签名验证，那这个字段可以忽略了*/
//			if ([verifier verifyString:result.resultString withSign:result.signString])
//			{
//				// 验证签名成功，交易结果无篡改
//				NSLog(@"支付成功!");
//			} else {
//				NSLog(@"此单被篡改无效!!");
//			}
//		}
//		else
//		{
//			// 支付失败
//			NSLog(@"%d%@", result.statusCode, result.statusMessage);
//		}
//	}
//	else
//	{
//		// 支付失败
//		NSLog(@"支付失败!");
//	}
//
//}



#pragma mark - 取消退款
- (void)cancelMoneyButton:(UIButton *)button {

}

#pragma mark - 取消订单
- (void)cancelOrderButton:(UIButton *)button {
	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userOrderOpera.php?act=cancel" params:@{@"order_id" : _order_id} Success:^(id responseObject) {

		if ([responseObject[@"status"] isEqual:@1]) {
			[RegosterAlert showAlert:@"取消订单成功" err:responseObject[@"info"]];
		} else {
			[RegosterAlert showAlert:@"取消订单失败" err:responseObject[@"info"]];
		}

	} Failed:^(NSError *error) {

	}];
}

#pragma mark - 确认收货
- (void)tureSendButton:(UIButton *)button {
	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userOrderOpera.php?act=receive_confirm" params:@{@"order_id" : _order_id} Success:^(id responseObject) {

		if ([responseObject[@"status"] isEqual:@1]) {
			[RegosterAlert showAlert:@"确认收货成功" err:responseObject[@"info"]];
		} else {
			[RegosterAlert showAlert:@"确认收货失败" err:responseObject[@"info"]];
		}

	} Failed:^(NSError *error) {

	}];
}

#pragma mark - 延长收货
- (void)yanchangButton:(UIButton *)button {
	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userOrderOpera.php?act=extend_receive" params:@{@"order_id" : _order_id} Success:^(id responseObject) {

		if ([responseObject[@"status"] isEqual:@1]) {
			[RegosterAlert showAlert:@"延长收货成功" err:responseObject[@"info"]];
		} else {
			[RegosterAlert showAlert:@"延长收货失败" err:responseObject[@"info"]];
		}

	} Failed:^(NSError *error) {

	}];
}

#pragma mark - 评价订单
- (void)pingjiaButton:(UIButton *)button {
	MyEvaluateVC *evaluateVC = [[MyEvaluateVC alloc] init];
	[self.navigationController pushViewController:evaluateVC animated:YES];
}

#pragma mark - 退款
//- (void)refundButton:(UIButton *)button {
//	NSLog(@"%ld", button.tag);
//	RefundVC *refundVC = [[RefundVC alloc] init];
//	[self.navigationController pushViewController:refundVC animated:YES];
//}

- (void)refundButton:(NSInteger)buttonTag {


	RefundVC *refundVC = [[RefundVC alloc] init];
	refundVC.order_id = [_goodsArr[buttonTag - 700000] order_id];
	refundVC.goods_id = [_goodsArr[buttonTag - 700000] goods_id];
	refundVC.product_id = [_goodsArr[buttonTag - 700000] product_id];
	[self.navigationController pushViewController:refundVC animated:YES];



//		RefundLogisticsVC *refundVC = [[RefundLogisticsVC alloc] init];
//		refundVC.back_order_id = [_goodsArr[buttonTag - 700000] product_id];
//		[self.navigationController pushViewController:refundVC animated:YES];

}

#pragma mark - 物流
- (void)logisticsButton:(UIButton *)button {
	LogisticsVC *logisticsVC = [[LogisticsVC alloc] init];
	logisticsVC.order_id = _order_id;
	[self.navigationController pushViewController:logisticsVC animated:YES];
}



#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {

	// 监听通知
	if([WXApi isWXAppInstalled]) // 判断 用户是否安装微信
	{
		// 监听一个通知
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"ORDER_PAY_NOTIFICATION" object:nil];
	}
	[super viewWillAppear:animated];

}

// 移除通知
- (void)dealloc
{
	[[NSNotificationCenter defaultCenter]removeObserver:self];
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
