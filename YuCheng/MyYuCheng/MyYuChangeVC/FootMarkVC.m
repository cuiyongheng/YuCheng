//
//  FootMarkVC.m
//  YuCheng
//
//  Created by apple on 16/8/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FootMarkVC.h"
#import "MyCollectionCell.h"

@interface FootMarkVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *footmarkArr;

@end

@implementation FootMarkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.title = @"我的足迹";

	[self createView];

	[self createData];
}

#pragma mark - createView
- (void)createView {
	self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	_tableView.backgroundColor = [UIColor whiteColor];
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	_tableView.showsVerticalScrollIndicator = NO;
	_tableView.rowHeight = UNITHEIGHT * 144;
	[self.view addSubview:_tableView];

	[_tableView registerClass:[MyCollectionCell class] forCellReuseIdentifier:@"myCollectionCell"];
}

#pragma mark - createData
- (void)createData {
	_footmarkArr = [SaveTool takeSaveValue];
}



#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _footmarkArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	MyCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCollectionCell"];
	cell.tag = 130000 + indexPath.row;
	cell.productModel = _footmarkArr[_footmarkArr.count - indexPath.row - 1];

	return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UIView *headView = [[UIView alloc] init];
	UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(UNITHEIGHT * 20, 0, WIDTH - UNITHEIGHT * 40, 1)];
	backView.backgroundColor = [UIColor colorWithHexString:@"#a5a5a5"];
	[headView addSubview:backView];

	return headView;
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
