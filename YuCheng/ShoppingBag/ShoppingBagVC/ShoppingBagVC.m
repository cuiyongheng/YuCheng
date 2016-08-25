//
//  ShoppingBagVC.m
//  YuCheng
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShoppingBagVC.h"
#import "ShoppingCell.h"
#import "ShoppingFootView.h"
#import "ClearingVC.h"
#import "ShoppingReviseCell.h"
#import "ProductModel.h"
#import "ShopCountModel.h"

@interface ShoppingBagVC ()<UITableViewDataSource, UITableViewDelegate, ShoppingFootViewDelegate>

@property (nonatomic, strong) UITableView *shoppingTableView;

@property (nonatomic, strong) ShoppingFootView *footView;

@property (nonatomic, strong) UIView *editView;

@property (nonatomic, strong) UIButton *itemButton;

@property (nonatomic, assign) BOOL isEdit;

@property (nonatomic, strong) NSMutableArray *shopArr;
@property (nonatomic, strong) NSMutableArray *goodsArr;

@property (nonatomic, strong) NSMutableDictionary *chooseDic;
@property (nonatomic, strong) NSMutableArray *chooseArr;

@property (nonatomic, strong) NSMutableDictionary *totalDic;// 市场价总和
@property (nonatomic, strong) NSMutableDictionary *depositDic;// 订金总和

@property (nonatomic, strong) NSMutableArray *payMethodArr;// 支付

@end

@implementation ShoppingBagVC

{
	NSString *payMethodStr;
	NSString *payMethodID;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"购物车";

	[self createView];

//	[self createData];

	[self rightNavigation];

	_isEdit = 0;

}



#pragma mark - rightNavigation
- (void)rightNavigation {
	self.itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_itemButton setTitle:@"编辑" forState:UIControlStateNormal];
	_itemButton.titleLabel.font = font(14);
	[_itemButton setTitleColor:[UIColor colorWithHexString:@"#595757"] forState:UIControlStateNormal];
	[_itemButton addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
	_itemButton.frame = CGRectMake(0, 0, UNITHEIGHT * 40, UNITHEIGHT * 40);
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_itemButton];

}


#pragma mark - createData
- (void)createData {
	_goodsArr = [NSMutableArray arrayWithCapacity:0];
	_shopArr = [NSMutableArray arrayWithCapacity:0];
	_chooseDic = [NSMutableDictionary dictionaryWithCapacity:0];
	_chooseArr = [NSMutableArray arrayWithCapacity:0];
	_totalDic = [NSMutableDictionary dictionaryWithCapacity:0];
	_depositDic = [NSMutableDictionary dictionaryWithCapacity:0];

	[NetWorkingTool GetNetWorking:@"http://www.jadechina.cn/mapi/shoppingCart.php?act=list" Params:nil Success:^(id responseObject) {

		if ([responseObject[@"cart_goods"] count] != 0) {
			for (NSDictionary *dic in [responseObject[@"cart_goods"] allValues]) {
//				_goodsArr = [ProductModel BaseModel:dic[@"goods_list"]];
				ShopCountModel *shopModel = [ShopCountModel mj_objectWithKeyValues:dic];
				[_shopArr addObject:shopModel];
			}
		}

		// 支付方式
		_payMethodArr = [NSMutableArray arrayWithArray:responseObject[@"payment_list"]];



		for (NSInteger i = 0; i < _shopArr.count; i++) {
			for (NSInteger j = 0; j < [[_shopArr[i] goods_list] count]; j++) {
				NSIndexPath *path = [NSIndexPath indexPathForRow:j inSection:i];
				[_chooseDic setObject:@0 forKey:path];
			}
		}

		dispatch_async(dispatch_get_main_queue(), ^{
			[_shoppingTableView reloadData];
		});

	} Failed:^(NSError *error) {

	}];

}

#pragma mark - createView
- (void)createView {
	self.shoppingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - UNITHEIGHT * 135.8) style:UITableViewStylePlain];
	_shoppingTableView.delegate = self;
	_shoppingTableView.dataSource = self;
	[self.view addSubview:_shoppingTableView];
	_shoppingTableView.bounces = NO;
	_shoppingTableView.rowHeight = UNITHEIGHT * 144;
	_shoppingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	_shoppingTableView.showsVerticalScrollIndicator = NO;

	[_shoppingTableView registerClass:[ShoppingReviseCell class] forCellReuseIdentifier:@"shoppingCell"];

	// foot
	self.footView = [[ShoppingFootView alloc] init];
	_footView.backgroundColor = [UIColor whiteColor];
	_footView.delegate = self;
	[self.view addSubview:_footView];

	[_footView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(self.view);
		make.bottom.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 44);
		make.height.mas_equalTo(UNITHEIGHT * 115.8);
	}];

	// 编辑
	self.editView = [[UIView alloc] init];
	_editView.hidden = YES;
	_editView.backgroundColor = [UIColor colorWithHexString:@"792b34"];
	[self.view addSubview:_editView];

	[_editView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 44);
		make.height.mas_equalTo(UNITHEIGHT * 135.8);
		make.left.right.mas_equalTo(self.view);
	}];

	UIImageView *allImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"whiteRound"]];
	[_editView addSubview:allImageView];

	[allImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_editView.mas_left).with.offset(WIDTH / 3);
		make.top.mas_equalTo(UNITHEIGHT * 30);
		make.height.width.mas_equalTo(UNITHEIGHT * 30);
	}];

	UILabel *allLabel = [[UILabel alloc] init];
	allLabel.text = @"全选";
	allLabel.textAlignment = NSTextAlignmentCenter;
	allLabel.textColor = [UIColor whiteColor];
	[_editView addSubview:allLabel];

	[allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(allImageView.mas_bottom).with.offset(UNITHEIGHT * 25);
		make.centerX.mas_equalTo(allImageView);
	}];

	UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[allButton addTarget:self action:@selector(allButton:) forControlEvents:UIControlEventTouchUpInside];
	[_editView addSubview:allButton];

	[allButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.mas_equalTo(allImageView);
		make.bottom.mas_equalTo(allLabel);
	}];



	UIImageView *deleteImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lajixiang"]];
	[_editView addSubview:deleteImageView];

	[deleteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_editView.mas_left).with.offset(WIDTH / 3 * 2);
		make.top.mas_equalTo(UNITHEIGHT * 30);
		make.height.width.mas_equalTo(UNITHEIGHT * 30);
	}];

	UILabel *deleteLabel = [[UILabel alloc] init];
	deleteLabel.text = @"删除";
	deleteLabel.textAlignment = NSTextAlignmentCenter;
	deleteLabel.textColor = [UIColor whiteColor];
	[_editView addSubview:deleteLabel];

	[deleteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(deleteImageView.mas_bottom).with.offset(UNITHEIGHT * 25);
		make.centerX.mas_equalTo(deleteImageView);
	}];

	UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[deleteButton addTarget:self action:@selector(deleteButton:) forControlEvents:UIControlEventTouchUpInside];
	[_editView addSubview:deleteButton];

	[deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.mas_equalTo(deleteImageView);
		make.bottom.mas_equalTo(deleteLabel);
	}];

}



#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[_shopArr[section] goods_list] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	// 定义cell标识  每个cell对应一个自己的标识
	NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
	// 通过不同标识创建cell实例
	ShoppingReviseCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	// 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
	if (!cell) {
		cell = [[ShoppingReviseCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	}



	ProductModel *model = [ProductModel mj_objectWithKeyValues:[_shopArr[indexPath.section] goods_list][indexPath.row]];
	cell.model = model;
	cell.backView.tag = 80000 + indexPath.row;
	cell.delegateView.tag = 30000 + indexPath.row;
	cell.delegateButton.tag = 35000 + indexPath.row;
	cell.tag = 500000 + indexPath.row + indexPath.section * 10000;

	if (indexPath.row == 0) {

		static BOOL isFirst;
		while (!isFirst) {
			[UIView animateWithDuration:0.3 animations:^{
				// 所需动画部分
				cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
			} completion:^(BOOL finished) {
				[UIView animateWithDuration:0.7 animations:^{
					cell.frame = CGRectMake(-UNITWIDTH * 70, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);

					[UIView beginAnimations:@"animation" context:nil];
					[UIView setAnimationDuration:1.4f];
					[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
					[UIView setAnimationRepeatAutoreverses:NO];
					[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cell.delegateButton cache:NO];
					[UIView commitAnimations];
				}];
			}];
			cell.delegateView.hidden = NO;
			isFirst = 1;
		}
	}

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	// 取消编辑状态动画
	static BOOL isFirst = 1;
	if (isFirst) {
		ShoppingCell *cell = (ShoppingCell *)[self.view viewWithTag:500000];
		[UIView animateWithDuration:0.3 animations:^{
			// 所需动画部分
			cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
		}];
		isFirst = 0;
	}

	if ([_chooseDic[indexPath] isEqual:@1]) {
		[_chooseDic setObject:@0 forKey:indexPath];
	} else {
		[_chooseDic setObject:@1 forKey:indexPath];
	}

	for (NSIndexPath *path in _chooseDic) {
		if ([_chooseDic[path] isEqual:@1]) {
			[_chooseArr addObject:path];
		}
	}

	for (NSIndexPath *path in _chooseArr) {
		if ([_chooseDic[path] isEqual:@1]) {
			ShoppingReviseCell *button = (ShoppingReviseCell *)[self.view viewWithTag:500000 + path.row + path.section * 10000];
			[button.chooseButton setBackgroundImage:[UIImage imageNamed:@"redBinggou"] forState:UIControlStateNormal];
			[_totalDic setObject:button.moneyLabel.text forKey:path];
//			NSString *str = [button.dingjinLabel.text substringFromIndex:3];
//			[_depositDic setObject:str forKey:path];
		} else {
			ShoppingReviseCell *button = (ShoppingReviseCell *)[self.view viewWithTag:500000 + path.row + path.section * 10000];
			[button.chooseButton setBackgroundImage:[UIImage imageNamed:@"redRound"] forState:UIControlStateNormal];
			[_totalDic setObject:@0 forKey:path];
			[_depositDic setObject:@0 forKey:path];
		}
	}

//	for (NSInteger i = 0; i < _shopArr.count; i++) {
//		for (NSInteger j = 0; j < [[_shopArr[i] goods_list] count]; j++) {
//			NSIndexPath *path = [NSIndexPath indexPathForRow:j inSection:i];
//			ShoppingReviseCell *button = (ShoppingReviseCell *)[self.view viewWithTag:500000 + path.row + path.section * 10000];
//			if ([_chooseDic[path] isEqual:@1]) {
//				[_totalArr addObject:button.moneyLabel.text];
//				[_depositArr addObject:button.dingjinLabel.text];
//			} else {
//				[_totalArr removeObject:button.moneyLabel.text];
//				[_depositArr removeObject:button.dingjinLabel.text];
//			}
//		}
//	}

	// 统计
	CGFloat total = 0;
	CGFloat deposit = 0;
	for (NSString *str in _totalDic.allValues) {
		float floatString = [str floatValue];
		total += floatString;
	}
	for (NSString *str in _depositDic.allValues) {
		float floatString = [str floatValue];
		deposit += floatString;
	}
	_footView.allMoneyLabel.text = [NSString stringWithFormat:@"%.2f", total];
//	_footView.dingjinMoneyLabel.text = [NSString stringWithFormat:@"%.2f", deposit];
}



#pragma mark - tableViewHeader
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return _shopArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return UNITHEIGHT * 50.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 50.0f)];
	headView.backgroundColor = [UIColor whiteColor];

	UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 5)];
	topView.backgroundColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:232 / 255.0 alpha:1];
	[headView addSubview:topView];

	UIImageView *headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ICON-27"]];
	[headView addSubview:headImageView];

	[headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(headView);
		make.left.mas_equalTo(headView).with.offset(UNITHEIGHT * 30);
		make.width.height.mas_equalTo(UNITHEIGHT * 30);
	}];

	UILabel *nameLabel = [[UILabel alloc] init];
	nameLabel.text = @"店名";
	nameLabel.font = font(16);
	nameLabel.textAlignment = NSTextAlignmentCenter;
	[headView addSubview:nameLabel];

	[nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(headImageView.mas_right).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(headImageView);
		make.centerY.mas_equalTo(headView);
		make.right.mas_equalTo(headView).with.offset(-UNITHEIGHT * 50);
	}];

	nameLabel.text = [NSString stringWithFormat:@"%@" , [_shopArr[section] supplier_name]];
	return headView;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//	return UNITHEIGHT * 135.8;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//	ShoppingFootView *footView = [[ShoppingFootView alloc] init];
//	footView.delegate = self;
//
//	return footView;
//}

#pragma mark - footDelegate
- (void)payMethod {
	// 支付选择
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"支付方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];

	UIAlertAction *cancleAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

	}];

	UIAlertAction *WXAlert = [UIAlertAction actionWithTitle:_payMethodArr[0][@"pay_name"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		payMethodID = _payMethodArr[0][@"pay_id"];
		_footView.payLabel.text = _payMethodArr[0][@"pay_name"];
	}];

//	UIAlertAction *ZFBAlert = [UIAlertAction actionWithTitle:@"支付宝支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//		payMethodID = @"1";
//		_footView.payLabel.text = @"支付宝支付";
//	}];

	UIAlertAction *arriveAction = [UIAlertAction actionWithTitle:_payMethodArr[1][@"pay_name"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		payMethodID = _payMethodArr[1][@"pay_id"];
		_footView.payLabel.text = _payMethodArr[1][@"pay_name"];
	}];

	[alert addAction:cancleAlert];
	[alert addAction:WXAlert];
	[alert addAction:arriveAction];
//	[alert addAction:ZFBAlert];

	[self presentViewController:alert animated:YES completion:^{

	}];
}

- (void)clearingShopping {
	NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];

	for (NSInteger i = 0; i < _shopArr.count; i++) {
		for (NSInteger j = 0; j < [[_shopArr[i] goods_list] count]; j++) {
			NSIndexPath *path = [NSIndexPath indexPathForRow:j inSection:i];
			if ([_chooseDic[path] isEqual:@1]) {
				NSLog(@"%@", [_shopArr[i] goods_list][j]);
				[arr addObject:[_shopArr[i] goods_list][j][@"rec_id"]];
			}
		}
	}

	if (arr.count > 0) {
		if (payMethodID.length > 0) {
			// 有支付方式
			ClearingVC *clearVC = [[ClearingVC alloc] init];
			clearVC.clearArr = arr;
			clearVC.payID = payMethodID;
			[self.navigationController pushViewController:clearVC animated:YES];
		} else {
			[RegosterAlert showAlert:@"请选择支付方式" err:nil];
		}
	} else {
		[RegosterAlert showAlert:@"请添加商品" err:nil];
	}

}

- (void)allChoose:(BOOL)isAllChoose {
	if (isAllChoose) {
		// 全选
		for (NSInteger i = 0; i < _shopArr.count; i++) {
			for (NSInteger j = 0; j < [[_shopArr[i] goods_list] count]; j++) {
				NSIndexPath *path = [NSIndexPath indexPathForRow:j inSection:i];
				[_chooseDic setObject:@1 forKey:path];
			}
		}

		for (NSIndexPath *path in _chooseDic) {
			if ([_chooseDic[path] isEqual:@1]) {
				ShoppingReviseCell *button = (ShoppingReviseCell *)[self.view viewWithTag:500000 + path.row + path.section * 10000];
				[button.chooseButton setBackgroundImage:[UIImage imageNamed:@"redBinggou"] forState:UIControlStateNormal];
				[_totalDic setObject:button.moneyLabel.text forKey:path];
				//			NSString *str = [button.dingjinLabel.text substringFromIndex:3];
				//			[_depositDic setObject:str forKey:path];
			} else {
				ShoppingReviseCell *button = (ShoppingReviseCell *)[self.view viewWithTag:500000 + path.row + path.section * 10000];
				[button.chooseButton setBackgroundImage:[UIImage imageNamed:@"redRound"] forState:UIControlStateNormal];
				[_totalDic setObject:@0 forKey:path];
				[_depositDic setObject:@0 forKey:path];
			}
		}

		dispatch_async(dispatch_get_main_queue(), ^{
			// 统计
			CGFloat total = 0;
			CGFloat deposit = 0;
			for (NSString *str in _totalDic.allValues) {
				float floatString = [str floatValue];
				total += floatString;
			}
			for (NSString *str in _depositDic.allValues) {
				float floatString = [str floatValue];
				deposit += floatString;
			}
			_footView.allMoneyLabel.text = [NSString stringWithFormat:@"%.2f", total];
			[_shoppingTableView reloadData];
		});
	} else {
		// 全不选
		for (NSInteger i = 0; i < _shopArr.count; i++) {
			for (NSInteger j = 0; j < [[_shopArr[i] goods_list] count]; j++) {
				NSIndexPath *path = [NSIndexPath indexPathForRow:j inSection:i];
				[_chooseDic setObject:@0 forKey:path];
			}
		}

		for (NSIndexPath *path in _chooseDic) {
			if ([_chooseDic[path] isEqual:@1]) {
				ShoppingReviseCell *button = (ShoppingReviseCell *)[self.view viewWithTag:500000 + path.row + path.section * 10000];
				[button.chooseButton setBackgroundImage:[UIImage imageNamed:@"redBinggou"] forState:UIControlStateNormal];
				[_totalDic setObject:button.moneyLabel.text forKey:path];
				//			NSString *str = [button.dingjinLabel.text substringFromIndex:3];
				//			[_depositDic setObject:str forKey:path];
			} else {
				ShoppingReviseCell *button = (ShoppingReviseCell *)[self.view viewWithTag:500000 + path.row + path.section * 10000];
				[button.chooseButton setBackgroundImage:[UIImage imageNamed:@"redRound"] forState:UIControlStateNormal];
				[_totalDic setObject:@0 forKey:path];
				[_depositDic setObject:@0 forKey:path];
			}
		}

		_footView.allMoneyLabel.text = [NSString stringWithFormat:@"0.00"];
		[_shoppingTableView reloadData];


	}
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//	ShoppingReviseCell *button = (ShoppingReviseCell *)[self.view viewWithTag:500000 + indexPath.row + indexPath.section * 10000];
//	[button.chooseButton setBackgroundImage:[UIImage imageNamed:@"redRound"] forState:UIControlStateNormal];
//
//	for (NSIndexPath *path in _chooseArr) {
//		ShoppingReviseCell *button = (ShoppingReviseCell *)[self.view viewWithTag:500000 + path.row + path.section * 10000];
//		[button.chooseButton setBackgroundImage:[UIImage imageNamed:@"redBinggou"] forState:UIControlStateNormal];
//	}

	for (NSInteger i = 0; i < _shopArr.count; i++) {
		for (NSInteger j = 0; j < [[_shopArr[i] goods_list] count]; j++) {
			NSIndexPath *path = [NSIndexPath indexPathForRow:j inSection:i];
			ShoppingReviseCell *button = (ShoppingReviseCell *)[self.view viewWithTag:500000 + path.row + path.section * 10000];
			if ([_chooseDic[path] isEqual:@1]) {
				[button.chooseButton setBackgroundImage:[UIImage imageNamed:@"redBinggou"] forState:UIControlStateNormal];
//				if (button.moneyLabel.text && button.dingjinLabel.text) {
//					[_totalDic setObject:button.moneyLabel.text forKey:path];
//					NSString *str = [button.dingjinLabel.text substringFromIndex:3];
//					[_depositDic setObject:str forKey:path];
//				}
			} else {
				[button.chooseButton setBackgroundImage:[UIImage imageNamed:@"redRound"] forState:UIControlStateNormal];
				[_totalDic setObject:@0 forKey:path];
				[_depositDic setObject:@0 forKey:path];
			}
		}
	}

	// 统计
//	CGFloat total;
//	CGFloat deposit;
//	for (NSString *str in _totalDic.allValues) {
//		float floatString = [str floatValue];
//		total += floatString;
//	}
//	for (NSString *str in _depositDic.allValues) {
//		float floatString = [str floatValue];
//		deposit += floatString;
//	}
//	_footView.allMoneyLabel.text = [NSString stringWithFormat:@"%.2f", total];
//	_footView.dingjinMoneyLabel.text = [NSString stringWithFormat:@"%.2f", deposit];
}



#pragma mark - tableViewEditing
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
	// 添加RowAction
	__weak __typeof(&*self)weakSelf = self;

	UITableViewRowAction *firstAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"         " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
		// 要实现的功能, 都写在block里
		NSLog(@"删除");

		NSString *str = @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
		"<root>"
		"<command_type>***</command_type>"
		"<id>***</id>"
		"<action>***</action>"
		"<value>***</value>"
		"</root>";



		[NetWorkingTool OtherPostNetWorking:@"http://www.jadechina.cn/mapi/shoppingCart.php?act=delete" params:@{@"ids" : [_shopArr[indexPath.section] goods_list][indexPath.row][@"rec_id"], @"test" : str} Success:^(id responseObject) {

			dispatch_async(dispatch_get_main_queue(), ^{
				[self createData];
			});

		} Failed:^(NSError *error) {
			
		}];
	}];
	firstAction.backgroundColor = [UIColor whiteColor];

	UIView *view = (UIView *)[self.view viewWithTag:30000 + indexPath.row];
	view.hidden = NO;
	UIButton *button = (UIButton *)[self.view viewWithTag:35000 + indexPath.row];



	[UIView beginAnimations:@"animation" context:nil];
	[UIView setAnimationDuration:0.5f];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationRepeatAutoreverses:NO];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:button cache:NO];
	[UIView commitAnimations];

	return @[firstAction];
}



- (void)rightButton:(UIButton *)button {
//	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"编辑" message:@"是否删除所有" preferredStyle:UIAlertControllerStyleAlert];
//
//	UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//	}];
//
//	UIAlertAction *alertCancle = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//
//	}];
//
//	[alert addAction:alertAction];
//	[alert addAction:alertCancle];
//
//	[self presentViewController:alert animated:YES completion:nil];



//	for (NSInteger i = 0; i < self.titleArr.count; i++) {

//		UIView *deleteView = (UIView *)[self.view viewWithTag:80000 + i];
//
//		if (_isEdit) {
//			// 动画效果
//			CATransition *animation = [CATransition animation];
//			animation.duration = 0.3f;
//			animation.timingFunction = UIViewAnimationCurveEaseInOut;
//			// 改编动画样式
//			animation.type = kCATransitionFade;
//			// animation.type = @"";
////			animation.subtype = kCATransitionFromRight;
//			[deleteView.layer addAnimation:animation forKey:@"animation"];
//
//			deleteView.transform = CGAffineTransformMakeTranslation(0, 0);
//		} else {
//			// 动画效果
//			CATransition *animation = [CATransition animation];
//			animation.duration = 0.3f;
//			animation.timingFunction = UIViewAnimationCurveEaseInOut;
//			// 改编动画样式
//			animation.type = kCATransitionFade;
//			// animation.type = @"";
////			animation.subtype = kCATransitionFromLeft;
//			[deleteView.layer addAnimation:animation forKey:@"animation"];
//
//			deleteView.transform = CGAffineTransformMakeTranslation(UNITHEIGHT * 50, 0);
//		}
//	}

	// 下面编辑
	if (_isEdit) {
		_editView.hidden = YES;
		[_itemButton setTitle:@"编辑" forState:UIControlStateNormal];
	} else {
		_editView.hidden = NO;
		[_itemButton setTitle:@"完成" forState:UIControlStateNormal];
	}

	_isEdit = !_isEdit;

	for (NSInteger i = 0; i < _shopArr.count; i++) {
		for (NSInteger j = 0; j < [[_shopArr[i] goods_list] count]; j++) {
			NSIndexPath *path = [NSIndexPath indexPathForRow:j inSection:i];
			[_chooseDic setObject:@0 forKey:path];
		}
	}
	dispatch_async(dispatch_get_main_queue(), ^{
		[_shoppingTableView reloadData];
	});

}

#pragma mark - editAction
- (void)allButton:(UIButton *)button {
	for (NSInteger i = 0; i < _shopArr.count; i++) {
		for (NSInteger j = 0; j < [[_shopArr[i] goods_list] count]; j++) {
			NSIndexPath *path = [NSIndexPath indexPathForRow:j inSection:i];
			[_chooseDic setObject:@1 forKey:path];
		}
	}
	dispatch_async(dispatch_get_main_queue(), ^{
		[_shoppingTableView reloadData];
	});
}

- (void)deleteButton:(UIButton *)button {
	NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
	NSString *paramsStr;
	for (NSIndexPath *path in _chooseDic) {
		if ([_chooseDic[path] isEqual:@1]) {
			[arr addObject:[_shopArr[path.section] goods_list][path.row][@"rec_id"]];
		}
	}
	for (NSString *str in arr) {
		if (!paramsStr) {
			paramsStr = [NSString stringWithFormat:@"%@", str];
		} else {
			paramsStr = [NSString stringWithFormat:@"%@,%@", paramsStr, str];
		}
	}


	NSString *str = @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
	"<root>"
	"<command_type>***</command_type>"
	"<id>***</id>"
	"<action>***</action>"
	"<value>***</value>"
	"</root>";

	if (paramsStr.length) {
		[NetWorkingTool OtherPostNetWorking:@"http://www.jadechina.cn/mapi/shoppingCart.php?act=delete" params:@{@"ids" : paramsStr, @"test" : str} Success:^(id responseObject) {

			dispatch_async(dispatch_get_main_queue(), ^{
				[self createData];
			});

		} Failed:^(NSError *error) {
			
		}];
	}
}



#pragma mark - gestureRecognizer
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
	return NO;
}



#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.navigationItem.leftBarButtonItem = nil;
	[self.navigationController.navigationBar setShadowImage:[UIImage new]];//用于去除导航栏的底线，也就是周围的边线
	[self.navigationController.navigationBar cnSetBackgroundColor:[UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:232 / 255.0 alpha:1]];
	self.tabBarController.tabBar.hidden = NO;

	if (!_isTabPush) {
		UIButton *leftItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
		leftItemButton.frame = CGRectMake(0, 0, UNITHEIGHT * 25, UNITHEIGHT * 25);
		[leftItemButton setBackgroundImage:[UIImage imageNamed:@"yc-22"] forState:UIControlStateNormal];
		[leftItemButton addTarget:self action:@selector(leftItemAction:) forControlEvents:UIControlEventTouchUpInside];

		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftItemButton];
	}
}

- (void)leftItemAction:(UIButton *)button {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	[self.navigationController.navigationBar cnSetBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	self.navigationController.navigationBar.translucent = YES;
	[self createData];
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
