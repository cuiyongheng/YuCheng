//
//  ClearingVC.m
//  YuCheng
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ClearingVC.h"
#import "clearHeadView.h"
#import "ClearFootView.h"
#import "ClearCell.h"
#import "MyAddressVC.h"
#import "MyTicketVC.h"
#import "SureClearingVC.h"
#import "ClearModel.h"

@interface ClearingVC ()<UITableViewDataSource, UITableViewDelegate, ClearFootViewDelegate, MyTicketVCDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *modelGoodsArr;

@property (nonatomic, strong) clearHeadView *headView;

@property (nonatomic, strong) ClearFootView *footView;

@property (nonatomic, strong) NSMutableArray *ticketArr;

@end

@implementation ClearingVC

{
	NSString *freeTicketStr;
	NSString *freeTicketID;// 优惠券ID
	NSInteger freeIndexRow;
	NSMutableDictionary *freeTicketDic;


//	NSString *shippingID;// 物流ID
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.title = @"确认订单";

	[self createView];

	[self createData];
}



#pragma mark - createData
- (void)createData {
	if (_clearArr.count > 0) {

//		NSString *paramsStr;
//		for (NSInteger i = 0; i < _clearArr.count; i++) {
//			if (i == 0) {
//				paramsStr = [NSString stringWithFormat:@"%@", _clearArr[i]];
//			} else {
//				paramsStr = [NSString stringWithFormat:@"%@,%@", paramsStr, _clearArr[i]];
//			}
//		}

		freeTicketDic = [NSMutableDictionary dictionaryWithCapacity:0];
		_modelGoodsArr = [NSMutableArray arrayWithCapacity:0];

		[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/orderConfirm.php" params:@{@"sel_cartgoods" : _clearArr} Success:^(id responseObject) {

			for (NSDictionary *shopDic in [responseObject[@"goods_list"] allValues]) {
				ClearModel *model = [ClearModel mj_objectWithKeyValues:shopDic];
				[_modelGoodsArr addObject:model];
			}

			for (NSInteger i = 0; i < _modelGoodsArr.count; i++) {
				[freeTicketDic setObject:@"" forKey:[NSString stringWithFormat:@"%ld", i]];
			}


			NSLog(@"%@", responseObject);
			_ticketArr = [NSMutableArray arrayWithArray:responseObject[@"bonus_list"]];

			dispatch_async(dispatch_get_main_queue(), ^{
				[_tableView reloadData];
				_headView.userDic = responseObject[@"consignee"];
				_footView.moneyLabel.text = responseObject[@"total"][@"formated_goods_price"];
//				shippingID = responseObject[@"order"][@"shipping_id"];
				[_tableView reloadData];
			});
		} Failed:^(NSError *error) {
			
		}];
	}
}



#pragma mark - createView
- (void)createView {
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + UNITHEIGHT * 69, WIDTH, HEIGHT - UNITHEIGHT * 75 - 64 - UNITHEIGHT * 69) style:UITableViewStylePlain];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.bounces = NO;
	_tableView.rowHeight = UNITHEIGHT * 100;
	_tableView.backgroundColor = [UIColor colorWithHexString:@"e5e6e6"];
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	_tableView.showsVerticalScrollIndicator = NO;
	[self.view addSubview:_tableView];

	[_tableView registerClass:[ClearCell class] forCellReuseIdentifier:@"ClearCell"];

	// head
	self.headView = [[clearHeadView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, UNITHEIGHT * 69)];
	[self.view addSubview:_headView];

	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
	[_headView addGestureRecognizer:tap];

	// foot
	self.footView = [[ClearFootView alloc] initWithFrame:CGRectMake(0, HEIGHT - UNITHEIGHT * 75, WIDTH, UNITHEIGHT * 75)];
	_footView.delegate = self;
	_footView.backgroundColor = [UIColor colorWithHexString:@"e5e6e6"];
	[self.view addSubview:_footView];

//	UITapGestureRecognizer *footTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(footTapAction:)];
//	[footView addGestureRecognizer:footTap];

}



#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	return [[_modelGoodsArr[section] goodlist] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	ClearCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClearCell"];

	cell.delegateView.tag = 50000 + indexPath.row;
	cell.delegateButton.tag = 55000 + indexPath.row;


	ClearModel *model = _modelGoodsArr[indexPath.section];
	cell.nameLabel.text = model.goodlist[indexPath.row][@"goods_name"];
	cell.moneyLabel.text = [NSString stringWithFormat:@"¥%@", model.goodlist[indexPath.row][@"goods_price"]];
	cell.orderLabel.text = model.goodlist[indexPath.row][@"goods_sn"];
	[cell.picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, model.goodlist[indexPath.row][@"goods_thumb"]]] placeholderImage:[UIImage imageNamed:@""]];
	cell.beforeMoneyLabel.text = [NSString stringWithFormat:@"¥%@", model.goodlist[indexPath.row][@"deposit"]];
	cell.nameLabel.numberOfLines = 0;
	[cell.nameLabel sizeToFit];
	
	return cell;
}

#pragma mark - headView footView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return _modelGoodsArr.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return UNITHEIGHT * 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 50)];
	headView.backgroundColor = [UIColor whiteColor];

	UIImageView *headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ICON-27"]];
	[headView addSubview:headImageView];

	[headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(headView).with.offset(UNITHEIGHT * 30);
		make.centerY.mas_equalTo(headView);
		make.height.width.mas_equalTo(UNITHEIGHT * 30);
	}];

	UILabel *nameLabel = [[UILabel alloc] init];
	nameLabel.text = @"店名";
	nameLabel.font = font(14);
	nameLabel.textAlignment = NSTextAlignmentCenter;
	[headView addSubview:nameLabel];

	[nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(headView);
		make.centerX.mas_equalTo(headView);
	}];

	nameLabel.text = [_modelGoodsArr[section] goodlist].firstObject[@"seller"];

	return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return  UNITHEIGHT * 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 40)];
	footView.backgroundColor = [UIColor whiteColor];

	UIView * squareView = [[UIView alloc] init];
	squareView.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
	[footView addSubview:squareView];

	[squareView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(footView).with.offset(UNITHEIGHT * 25.5);
		make.height.mas_equalTo(UNITHEIGHT * 30);
		make.width.mas_equalTo(UNITHEIGHT * 5);
		make.bottom.mas_equalTo(footView).with.offset(-UNITHEIGHT * 20);
	}];

	UILabel * freeLabel = [[UILabel alloc] init];
	freeLabel.text = @"优惠券";
	freeLabel.font = font(14);
	[footView addSubview:freeLabel];

	[freeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(squareView).with.offset(UNITHEIGHT * 10);
		make.centerY.mas_equalTo(squareView);
	}];

	UIImageView * arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightArrow"]];
	[footView addSubview:arrowImageView];

	[arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(footView).with.offset(-UNITHEIGHT * 25.5);
		make.centerY.mas_equalTo(squareView);
		make.height.mas_equalTo(UNITHEIGHT * 30);
		make.width.mas_equalTo(UNITHEIGHT * 5);
	}];

	UILabel * freeMoneyLabel = [[UILabel alloc] init];
//	freeMoneyLabel.text = @"满1000减100";
	freeMoneyLabel.font = font(14);
	freeMoneyLabel.textAlignment = NSTextAlignmentRight;
	freeMoneyLabel.tag = 2200000;
	[footView addSubview:freeMoneyLabel];

	[freeMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(arrowImageView.mas_left).with.offset(-UNITHEIGHT * 5);
		make.centerY.mas_equalTo(squareView);
	}];

	UIView *bottomView = [[UIView alloc] init];
	bottomView.backgroundColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1];
	[footView addSubview:bottomView];

	[bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.left.mas_equalTo(footView);
		make.height.mas_equalTo(UNITHEIGHT * 15);
		make.bottom.mas_equalTo(footView);
	}];

	UIView *topView = [[UIView alloc] init];
	topView.backgroundColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1];
	[footView addSubview:topView];

	[topView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.left.mas_equalTo(footView);
		make.height.mas_equalTo(UNITHEIGHT * 5);
		make.top.mas_equalTo(footView);
	}];

	UITapGestureRecognizer *footTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(footTapAction:)];
	footView.tag = 2000000 + section;
	[footView addGestureRecognizer:footTap];

	if (freeTicketStr) {
		if (freeIndexRow == section) {
			freeMoneyLabel.text = freeTicketStr;
		}
	}

	return footView;
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
//	firstAction.backgroundColor = [UIColor clearColor];
//
//	UIView *view = (UIView *)[self.view viewWithTag:50000 + indexPath.row];
//	view.hidden = NO;
//	UIButton *button = (UIButton *)[self.view viewWithTag:55000 + indexPath.row];
//
//	[UIView beginAnimations:@"animation" context:nil];
//	[UIView setAnimationDuration:0.5f];
//	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//	[UIView setAnimationRepeatAutoreverses:NO];
//	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:button cache:NO];
//	[UIView commitAnimations];
//
//	return @[firstAction];
//}

#pragma mark - tapAction
- (void)tapAction:(UITapGestureRecognizer *)tap {
	MyAddressVC *addressVC = [[MyAddressVC alloc] init];
	addressVC.isMyYuCheng = 0;
	[self.navigationController pushViewController:addressVC animated:YES];
}

- (void)footTapAction:(UITapGestureRecognizer *)tap {
	NSLog(@"%ld", tap.view.tag);

	ClearModel *model = _modelGoodsArr[tap.view.tag - 2000000];
	NSMutableArray *tempTicketArr = [NSMutableArray arrayWithCapacity:0];
	for (NSMutableDictionary *dic in _ticketArr) {
		if ([dic[@"supplier_id"] isEqual:model.goodlist.firstObject[@"supplier_id"]]) {
			[tempTicketArr addObject:dic];
		}
	}

	if (tempTicketArr.count > 0) {
		MyTicketVC *ticketVC = [[MyTicketVC alloc] init];
		ticketVC.isMyYuCheng = 0;
		ticketVC.delegate = self;
		ticketVC.NSIndexRow = tap.view.tag - 2000000;
		ticketVC.modelArr = tempTicketArr;
		
		[self.navigationController pushViewController:ticketVC animated:YES];
	} else {
		[RegosterAlert showAlert:@"你没有优惠券" err:nil];
	}
}

- (void)takeTicketID:(NSString *)ticketID ticketName:(NSString *)ticketName NSIndex:(NSInteger)NSIndexRow {
//	UILabel *freeLabel = (UILabel *)[self.view viewWithTag:NSIndexRow + 2200000];
//	freeLabel.text = ticketName;

	freeTicketStr = ticketName;
	freeTicketID = ticketID;
	freeIndexRow = NSIndexRow;

}



#pragma mark - tureClearing
- (void)tureClearing {

//	NSDictionary *paramsDic = @{@"payment" : _payID, [NSString stringWithFormat:@"pay_ship[%@]", [_modelGoodsArr[0] goodlist].firstObject[@"supplier_id"]] : [_modelGoodsArr[0] shipping_id], [NSString stringWithFormat:@"bonus_%@", [_modelGoodsArr[0] goodlist].firstObject[@"supplier_id"]] : freeTicketID};
//
//	NSLog(@"%@", paramsDic);

	if (freeTicketID.length > 0) {
		[freeTicketDic setObject:freeTicketID forKey:[NSString stringWithFormat:@"%ld", freeIndexRow]];
	} else {

	}

	NSLog(@"%@", freeTicketDic);

	NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithCapacity:0];
	[paramsDic setObject:_payID forKey:@"payment"];

	for (NSInteger i = 0; i < _modelGoodsArr.count; i++) {
		[paramsDic setObject:[_modelGoodsArr[i] shipping_id] forKey:[NSString stringWithFormat:@"pay_ship[%@]", [_modelGoodsArr[i] goodlist].firstObject[@"supplier_id"]]];

		[paramsDic setObject:freeTicketDic[[NSString stringWithFormat:@"%ld", i]] forKey:[NSString stringWithFormat:@"bonus_%@", [_modelGoodsArr[i] goodlist].firstObject[@"supplier_id"]]];

	}

	NSLog(@"%@", paramsDic);

	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/orderGenerate.php" params:paramsDic Success:^(id responseObject) {

		NSLog(@"%@", responseObject);
		if ([responseObject[@"status"] isEqual:@1]) {

			SureClearingVC *sureClearVC = [[SureClearingVC alloc] init];
			sureClearVC.modelDic = responseObject[@"order"];
			[self.navigationController pushViewController:sureClearVC animated:YES];
		} else {
			[RegosterAlert showAlert:@"提交失败" err:responseObject[@"info"]];
		}
		
	} Failed:^(NSError *error) {

	}];
}


#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self createData];
	self.navigationController.navigationBar.translucent = YES;
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
