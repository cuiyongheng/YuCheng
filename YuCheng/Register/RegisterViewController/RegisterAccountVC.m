//
//  RegisterAccountVC.m
//  YuCheng
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RegisterAccountVC.h"
#import "RegisterAccountCell.h"

@interface RegisterAccountVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UIButton *registerButton;

@property (nonatomic, strong) UIButton *lognButton;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *registerAccountArr;

@end

@implementation RegisterAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.view.backgroundColor = [UIColor blackColor];

	[self createView];

	[self createData];
}



#pragma mark - createData
- (void)createData {
	_registerAccountArr = @[@"账号", @"密码", @"密码确认", @"交易密码", @"交易密码确认"];
}

#pragma mark - createView
- (void)createView {
	self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_registerButton setTitle:@"登录" forState:UIControlStateNormal];
	[_registerButton setTitleColor:[UIColor colorWithHexString:@"#68c5da"] forState:UIControlStateNormal];
	[_registerButton addTarget:self action:@selector(registerButton:) forControlEvents:UIControlEventTouchUpInside];
	_registerButton.titleLabel.font = font(13);
	[self.view addSubview:_registerButton];

	[_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 31.5);
		make.top.mas_equalTo(self.view).with.offset(UNITHEIGHT * 44);
	}];

	self.logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"register1"]];
	[self.view addSubview:_logoImageView];

	[_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_registerButton.mas_top).with.offset(UNITHEIGHT * 10);
		make.width.mas_equalTo(UNITHEIGHT * 62);
		make.height.mas_equalTo(UNITHEIGHT * 73.8);
		make.centerX.mas_equalTo(self.view);
	}];

	self.lognButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_lognButton setTitle:@"注册" forState:UIControlStateNormal];
	[_lognButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	_lognButton.titleLabel.font = font(18);
	_lognButton.backgroundColor = [UIColor colorWithHexString:@"#68c5da"];
	[self.view addSubview:_lognButton];

	self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	_tableView.rowHeight = UNITHEIGHT * 39;
	_tableView.bounces = NO;
	_tableView.backgroundColor = [UIColor blackColor];
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview:_tableView];

	[_tableView registerClass:[RegisterAccountCell class] forCellReuseIdentifier:@"registerAccountCell"];

	[_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.view);
		make.width.mas_equalTo(WIDTH);
		make.top.mas_equalTo(_logoImageView.mas_bottom).with.offset(UNITHEIGHT * 85);
		make.height.mas_equalTo(UNITHEIGHT * 200);
	}];

	[_lognButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.mas_equalTo(UNITHEIGHT * 233.5);
		make.centerX.mas_equalTo(self.view);
		make.top.mas_equalTo(_tableView.mas_bottom).with.offset(UNITHEIGHT * 39);
		make.height.mas_equalTo(UNITHEIGHT * 36);
	}];
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	RegisterAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"registerAccountCell"];

	cell.contentTextField.placeholder = [NSString stringWithFormat:@"%@", _registerAccountArr[indexPath.row]];

	[cell.contentTextField setValue:[UIColor colorWithHexString:@"#9f9fa0"] forKeyPath:@"_placeholderLabel.textColor"];
	[cell.contentTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
	if (indexPath.row == 0) {
		cell.headImageView.image = [UIImage imageNamed:@"register2"];
	} else {
		cell.headImageView.image = [UIImage imageNamed:@"register3"];
	}

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
}



#pragma mark - registerPush
- (void)registerButton:(UIButton *)button {
	[self.navigationController popViewControllerAnimated:YES];
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
