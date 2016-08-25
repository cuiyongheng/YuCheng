//
//  PayPassVC.m
//  YuCheng
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PayPassVC.h"
#import "SettingCell.h"

@interface PayPassVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *titleArr;

@end

@implementation PayPassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.title = @"支付密码";

	[self createView];
}

- (void)createView {
	self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
	_tableView.showsVerticalScrollIndicator = NO;
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.bounces = NO;
	_tableView.rowHeight = UNITHEIGHT * 46;
	[self.view addSubview:_tableView];

	[_tableView registerClass:[SettingCell class] forCellReuseIdentifier:@"payPassCell"];

}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0) {

		SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"payPassCell"];

		cell.titleLabel.text = @"修改支付密码";
		return cell;
	} else {
		static NSString *reuse = @"payOtherCell";
		SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
		if (!cell) {
			cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse];
			cell.arrowImageView.hidden = YES;
			cell.titleLabel.text = @"找回密码";

			UILabel *alertLabel = [[UILabel alloc] init];
			alertLabel.text = @"(点击后系统将自动发送新密码到您的手机)";
			alertLabel.textColor = [UIColor colorWithHexString:@"#b4b5b5"];
			alertLabel.font = font(9);
			[cell addSubview:alertLabel];

			[alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(cell.titleLabel.mas_right).with.offset(UNITHEIGHT * 10);
				make.centerY.mas_equalTo(cell);
				make.height.mas_equalTo(UNITHEIGHT * 20);
			}];

		}

		return cell;
	}

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
