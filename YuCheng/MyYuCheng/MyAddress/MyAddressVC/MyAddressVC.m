//
//  MyAddressVC.m
//  YuCheng
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyAddressVC.h"
#import "MyAddressCell.h"
#import "AddAddressVC.h"
#import "AddressModel.h"

@interface MyAddressVC ()<UITableViewDataSource, UITableViewDelegate, MyAddressCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *addressArr;

@property (nonatomic , copy) NSString *defaultAddressStr;

@end

@implementation MyAddressVC

{
	BOOL isEdit;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.title = @"收货地址";

	[self createView];

	[self createData];

	[self setNavigation];
}

#pragma mark - navigation
- (void)setNavigation {
	UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[itemButton setTitle:@"编辑" forState:UIControlStateNormal];
	itemButton.titleLabel.font = font(14);
	[itemButton setTitleColor:[UIColor colorWithHexString:@"#595757"] forState:UIControlStateNormal];
	[itemButton addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
	itemButton.frame = CGRectMake(0, 0, UNITHEIGHT * 40, UNITHEIGHT * 40);
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:itemButton];

	isEdit = 0;
}

#pragma mark - createData
- (void)createData {
	[NetWorkingTool GetNetWorking:@"http://www.jadechina.cn/mapi/userAddress.php?act=list" Params:nil Success:^(id responseObject) {
		
		_addressArr = [AddressModel BaseModel:responseObject[@"consignee_list"]];
		_defaultAddressStr = responseObject[@"address"];

		dispatch_async(dispatch_get_main_queue(), ^{
			[_tableView reloadData];
		});
	} Failed:^(NSError *error) {

	}];
}

#pragma mark - createView
- (void)createView {
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(UNITHEIGHT * 25, 64, WIDTH - UNITHEIGHT * 50, HEIGHT - UNITHEIGHT * 60 - 64) style:UITableViewStylePlain];
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.rowHeight = UNITHEIGHT * 80;
	_tableView.showsVerticalScrollIndicator = NO;
	_tableView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:_tableView];

	[_tableView registerClass:[MyAddressCell class] forCellReuseIdentifier:@"AddressCell"];

	// 添加地址
	UIButton *addressButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[addressButton setTitle:@"+添加新地址" forState:UIControlStateNormal];
	[addressButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[addressButton addTarget:self action:@selector(addAddress:) forControlEvents:UIControlEventTouchUpInside];
	addressButton.backgroundColor = [UIColor colorWithHexString:@"#2d2f30"];
	addressButton.titleLabel.font = font(19);
	[self.view addSubview:addressButton];

	[addressButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.view).with.offset(UNITHEIGHT * 25);
		make.right.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 25);
		make.bottom.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 7.5);
		make.height.mas_equalTo(UNITHEIGHT * 45);
	}];
}



#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _addressArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	MyAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressCell"];
	cell.deleteView.tag = 60000 + indexPath.row;
	cell.deleteButton.tag = 63000 + indexPath.row;
	cell.reviseButton.tag = 66000 + indexPath.row;
	cell.model = _addressArr[indexPath.row];
	cell.defaultAddressStr = _defaultAddressStr;
	cell.delegate = self;

	return cell;
}

#pragma mark - headView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UIView *headView = [[UIView alloc] init];

	UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(UNITHEIGHT * 25, 0, UNITHEIGHT * 324, 1)];
	lineView.backgroundColor = [UIColor colorWithHexString:@"#a5a5a5"];
	[headView addSubview:lineView];

	return headView;
}



#pragma mark - tableViewEdit
- (void)rightButton:(UIButton *)button {
	if (isEdit) {
		[button setTitle:@"编辑" forState:UIControlStateNormal];
		[self setEditing:NO animated:YES];
	} else {
		[button setTitle:@"完成" forState:UIControlStateNormal];
		[self setEditing:YES animated:YES];
	}
	isEdit = !isEdit;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
	[super setEditing:editing animated:animated];

//	[self.tableView setEditing:editing animated:animated];

	for (NSInteger i = 0; i < 10; i++) {

		UIView *deleteView = (UIView *)[self.view viewWithTag:60000 + i];

		if (editing) {
			// 动画效果
			CATransition *animation = [CATransition animation];
			animation.duration = 0.3f;
			animation.timingFunction = UIViewAnimationCurveEaseInOut;
			// 改编动画样式
			animation.type = kCATransitionPush;
			// animation.type = @"";
			animation.subtype = kCATransitionFromRight;
			[deleteView.layer addAnimation:animation forKey:@"animation"];

			deleteView.transform = CGAffineTransformMakeTranslation(-UNITHEIGHT * 112, 0);
		} else {
			// 动画效果
			CATransition *animation = [CATransition animation];
			animation.duration = 0.3f;
			animation.timingFunction = UIViewAnimationCurveEaseInOut;
			// 改编动画样式
			animation.type = kCATransitionPush;
			// animation.type = @"";
			animation.subtype = kCATransitionFromLeft;
			[deleteView.layer addAnimation:animation forKey:@"animation"];

			deleteView.transform = CGAffineTransformMakeTranslation(UNITHEIGHT * 112, 0);
		}
	}
}

#pragma mark - celldelegate
- (void)deleteAction:(NSInteger)buttonTag {
	NSLog(@"%@", [_addressArr[buttonTag - 63000] address_id]);
	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userAddress.php?act=delete" params:@{@"id" : [_addressArr[buttonTag - 63000] address_id]} Success:^(id responseObject) {
		NSLog(@"%@", responseObject);
		NSLog(@"%@", responseObject[@"info"]);

		dispatch_async(dispatch_get_main_queue(), ^{
			[self createData];
		});
	} Failed:^(NSError *error) {

	}];
}

- (void)reviseAction:(NSInteger)buttonTag {
	AddAddressVC *addVC = [[AddAddressVC alloc] init];
	addVC.isRevise = 1;
	addVC.model = _addressArr[buttonTag - 66000];
	addVC.isDefaultID = _defaultAddressStr;
	addVC.address_id = [_addressArr[buttonTag - 66000] address_id];
	[self.navigationController pushViewController:addVC animated:YES];
}


#pragma mark - addAddress
- (void)addAddress:(UIButton *)button {
	AddAddressVC *addVC = [[AddAddressVC alloc] init];
	addVC.isRevise = 0;
	addVC.address_id = @"0";
	[self.navigationController pushViewController:addVC animated:YES];
}



#pragma mark - cellDidSelect
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (_isMyYuCheng) {
		// 个人中心进入
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
	} else {
		// 结算进入
		[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/orderSelAddress.php" params:@{@"address_id" : [_addressArr[indexPath.row] address_id]} Success:^(id responseObject) {

			[self.navigationController popViewControllerAnimated:YES];
		} Failed:^(NSError *error) {

		}];
	}
}

#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	dispatch_async(dispatch_get_main_queue(), ^{
		[self createData];
	});
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
