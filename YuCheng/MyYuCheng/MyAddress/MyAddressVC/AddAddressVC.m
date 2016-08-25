//
//  AddAddressVC.m
//  YuCheng
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AddAddressVC.h"
#import "AddAddressCell.h"
#import "AddphoneCell.h"
#import "LastAddressCell.h"
#import "ProvinceVC.h"
#import "ProvinceVC.h"

@interface AddAddressVC ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, LastAddressCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AddAddressVC

{
	NSString *consignee;// 收货人名称
	NSString *mobile;// 手机
	NSString *provinceID;// 省ID
	NSString *cityID;// 市
	NSString *districtID;// 区
	NSString *address;// 地址
	NSString *is_default;// 是否默认
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.title = @"添加地址";

	[self createView];

	[self createData];
}



#pragma mark - createData
- (void)createData {
	if (_isRevise) {
		// 详情


		if ([_model.address_id isEqualToString:_isDefaultID]) {
			is_default = @"1";
		} else {
			is_default = @"1";
		}
		
		consignee = _model.consignee;
		mobile = _model.mobile;
		provinceID = _model.province;
		cityID = _model.city;
		districtID = _model.country;
		address = _model.address;

//		NSDictionary *paramsDic = @{@"consignee" : consignee, @"mobile" : mobile, @"country" : @"1", @"province" : provinceID, @"city" : cityID, @"district" : districtID, @"address" : address, @"is_default" : is_default, @"address_id" : _address_id};

	} else {

	}

}

#pragma mark - createView
- (void)createView {
	self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.rowHeight = UNITHEIGHT * 57;
	_tableView.bounces = NO;
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview:_tableView];

	[_tableView registerClass:[AddAddressCell class] forCellReuseIdentifier:@"addAddressCell"];

	[_tableView registerClass:[AddphoneCell class] forCellReuseIdentifier:@"phoneCell"];

	[_tableView registerClass:[LastAddressCell class] forCellReuseIdentifier:@"lastCell"];
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 2) {

		AddAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addAddressCell"];
		cell.contentTextField.delegate = self;

		if (_isRevise) {
			// 详情
			if (indexPath.row == 0) {
				cell.contentTextField.text = _model.consignee;
				cell.contentTextField.tag = 123454;
			} else if (indexPath.row == 2) {
				cell.contentTextField.text = [NSString stringWithFormat:@"%@%@%@", _model.province_name, _model.city_name, _model.district_name];
				cell.contentTextField.userInteractionEnabled = NO;
				cell.contentTextField.tag = 123456;
			} else if (indexPath.row == 3) {
				cell.contentTextField.text = [NSString stringWithFormat:@"%@", _model.address];
				cell.contentTextField.tag = 123457;
			}
		} else {
			if (indexPath.row == 3) {
				cell.contentTextField.placeholder = [NSString stringWithFormat:@"小区、街道、门牌等详细信息"];
				cell.contentTextField.tag = 123457;
			} else if (indexPath.row == 2) {
				cell.contentTextField.tag = 123456;
				cell.contentTextField.placeholder = [NSString stringWithFormat:@"省/市/区"];
				cell.contentTextField.userInteractionEnabled = NO;
			} else {
				cell.contentTextField.tag = 123454;
			}
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}

		return cell;
	} else if (indexPath.row == 1) {
		AddphoneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"phoneCell"];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.contentTextField.tag = 123455;
		cell.contentTextField.delegate = self;

		if (_isRevise) {
			cell.contentTextField.text = _model.mobile;
		}

		return cell;
	} else {
		LastAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lastCell"];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.delegate = self;


		if (!is_default) {
			[cell.defaultButton setBackgroundImage:[UIImage imageNamed:@"button1"] forState:UIControlStateNormal];
		} else {
			[cell.defaultButton setBackgroundImage:[UIImage imageNamed:@"button2"] forState:UIControlStateNormal];
		}


		return cell;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (indexPath.row == 2) {
		ProvinceVC *provinceVC = [[ProvinceVC alloc] init];
		UINavigationController *provinceNaVC = [[UINavigationController alloc] initWithRootViewController:provinceVC];

		// 返回block
		provinceVC.block = ^(NSMutableDictionary *dic) {

			dispatch_async(dispatch_get_main_queue(), ^{
				UITextField *textField = (UITextField *)[self.view viewWithTag:123456];
				if (!dic[@"zoom"]) {
					NSString *provinceStr = [NSString stringWithFormat:@"%@%@", dic[@"province"], dic[@"city"]];
					textField.text = provinceStr;
				} else {
					NSString *provinceStr = [NSString stringWithFormat:@"%@%@%@", dic[@"province"], dic[@"city"], dic[@"zoom"]];
					textField.text = provinceStr;
				}
				_isRevise = 0;
				[self.tableView reloadData];
			});

			// 获取省市区ID
			provinceID = dic[@"provinceID"];
			cityID = dic[@"cityID"];
			if (!dic[@"zoomID"]) {
				districtID = @"0";
			} else {
				districtID = dic[@"zoomID"];
			}
		};
		[self presentViewController:provinceNaVC animated:YES completion:nil];
	} 
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
	lineView.backgroundColor = [UIColor blackColor];
	[headView addSubview:lineView];

	return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return UNITHEIGHT * 90;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 90)];

	// 添加地址
	UIButton *addressButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[addressButton setTitle:@"确定" forState:UIControlStateNormal];
	[addressButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[addressButton addTarget:self action:@selector(tureAddress:) forControlEvents:UIControlEventTouchUpInside];
	addressButton.backgroundColor = [UIColor colorWithHexString:@"#2d2f30"];
	addressButton.titleLabel.font = font(19);
	[footView addSubview:addressButton];

	[addressButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(footView).with.offset(UNITHEIGHT * 25);
		make.right.mas_equalTo(footView).with.offset(-UNITHEIGHT * 25);
		make.bottom.mas_equalTo(footView).with.offset(-UNITHEIGHT * 7.5);
		make.height.mas_equalTo(UNITHEIGHT * 45);
	}];

	return footView;
}

#pragma mark - textFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
	if (textField.tag == 123454) {
		consignee = textField.text;
	} else if (textField.tag == 123455) {
		mobile = textField.text;
	} else if (textField.tag == 123457) {
		address = textField.text;
	}
}

- (void)tureAddress:(UIButton *)button {
	[self.view endEditing:YES];

	NSLog(@"%@---%@---%@", consignee, mobile, address);
	NSLog(@"%@--%@--%@", provinceID, cityID, districtID);
	NSLog(@"%@---%@", is_default, _address_id);

	if (!is_default) {
		is_default = @"0";
	}

	NSDictionary *paramsDic = @{@"consignee" : consignee, @"mobile" : mobile, @"country" : @"1", @"province" : provinceID, @"city" : cityID, @"district" : districtID, @"address" : address, @"is_default" : is_default, @"address_id" : _address_id};

	[NetWorkingTool OtherPostNetWorking:[NSString stringWithFormat:@"%@mapi/userAddress.php?act=update" , API_BASE_URL] params:paramsDic Success:^(id responseObject) {
//		NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

		[self.navigationController popViewControllerAnimated:YES];

	} Failed:^(NSError *error) {

	}];
}

- (void)lastIsDefault:(NSInteger)isdefault {
	is_default = [NSString stringWithFormat:@"%ld", (long)isdefault];
}



#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
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
