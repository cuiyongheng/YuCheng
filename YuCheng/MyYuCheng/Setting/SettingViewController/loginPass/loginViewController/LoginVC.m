//
//  LoginVC.m
//  YuCheng
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LoginVC.h"
#import "LoginPassCell.h"

@interface LoginVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *placeholderArr;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.title = @"修改登录密码";

	[self createView];

	[self createData];

}

#pragma mark - createData 
- (void)createData {
	self.placeholderArr = [NSMutableArray arrayWithObjects:@"请输入旧登录密码", @"请输入新登录密码", @"再次输入新登录密码", nil];
}

#pragma mark - createView
- (void)createView {
	self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
	_tableView.showsVerticalScrollIndicator = NO;
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.bounces = NO;
	_tableView.rowHeight = UNITHEIGHT * 46;
	[self.view addSubview:_tableView];

	[_tableView registerClass:[LoginPassCell class] forCellReuseIdentifier:@"loginCell"];

}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _placeholderArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	LoginPassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"loginCell"];

	cell.inputTextField.placeholder = [NSString stringWithFormat:@"%@", _placeholderArr[indexPath.row]];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - tableViewHeadView footView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UIView *head = [[UIView alloc] init];
	head.backgroundColor = [UIColor whiteColor];

	UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(UNITHEIGHT * 33.5, 0, UNITHEIGHT * 308, 1)];
	headView.backgroundColor = [UIColor colorWithHexString:@"#b4b5b5"];
	[head addSubview:headView];

	return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return UNITHEIGHT * 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

	UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 75)];
	footView.backgroundColor = [UIColor whiteColor];

	UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[exitButton setTitle:@"提交" forState:UIControlStateNormal];
	exitButton.titleLabel.font = font(19);
	exitButton.backgroundColor = [UIColor blackColor];
	exitButton.frame = CGRectMake(UNITHEIGHT * 52, UNITHEIGHT * 30, UNITHEIGHT * 270, UNITHEIGHT * 45);
	[footView addSubview:exitButton];

	return footView;
}



#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.tabBarController.tabBar.hidden = YES;
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
