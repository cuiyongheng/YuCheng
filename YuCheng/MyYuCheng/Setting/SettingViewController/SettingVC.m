//
//  SettingVC.m
//  YuCheng
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SettingVC.h"
#import "SettingCell.h"
#import "LoginVC.h"
#import "PayPassVC.h"
#import <StoreKit/StoreKit.h>

@interface SettingVC ()<UITableViewDataSource, UITableViewDelegate, SKStoreProductViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *settingArr;

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.title = @"设置";

	[self createView];

	[self createData];
}

#pragma mark - createData
- (void)createData {
	self.settingArr = [NSMutableArray arrayWithObjects:@"登录密码", @"支付密码", @"关于玉城", @"清除缓存", nil];
}

#pragma mark - createView
- (void)createView {
	self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
	_tableView.showsVerticalScrollIndicator = NO;
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.rowHeight = UNITHEIGHT * 46;
	_tableView.bounces = NO;
	[self.view addSubview:_tableView];

	[_tableView registerClass:[SettingCell class] forCellReuseIdentifier:@"settingCell"];

}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell"];

	cell.titleLabel.text = [NSString stringWithFormat:@"%@", _settingArr[indexPath.row]];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	if (indexPath.row == 0) {
		// 登录密码
		LoginVC *loginVC = [[LoginVC alloc] init];
		[self.navigationController pushViewController:loginVC animated:YES];
	} else if (indexPath.row == 1) {
		// 支付密码
		PayPassVC *payPassVC = [[PayPassVC alloc] init];
		[self.navigationController pushViewController:payPassVC animated:YES];
	} else if (indexPath.row == 2) {
//		[self openApp];
	} else if (indexPath.row == 3) {

		NSString *sandBoxPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
		NSString *folderSize = [NSString stringWithFormat:@"是否要清除缓存(%.2fM)", [self folderSizeAtPath:sandBoxPath]];

		// 清除缓存
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除缓存" message:folderSize preferredStyle:1];
		UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
			[SaveWorking clearSave];
			[self.tableView reloadData];
		}];
		UIAlertAction *alertcanel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {

		}];
		[alert addAction:alertcanel];
		[alert addAction:alertAction];

		[self presentViewController:alert animated:YES completion:^{

		}];
	}
}

#pragma mark - floderPath
- (float) folderSizeAtPath:(NSString*) folderPath{

	NSFileManager* manager = [NSFileManager defaultManager];

	if (![manager fileExistsAtPath:folderPath]) return 0;

	NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];

	NSString* fileName;

	long long folderSize = 0;

	while ((fileName = [childFilesEnumerator nextObject]) != nil){

		NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];

		folderSize += [self fileSizeAtPath:fileAbsolutePath];

	}

	return folderSize/(1024.0*1024.0);

}

- (long long) fileSizeAtPath:(NSString*) filePath{

	NSFileManager* manager = [NSFileManager defaultManager];

	if ([manager fileExistsAtPath:filePath]){

		return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
	}
	return 0;
}

#pragma mark - 跳转APPStore
//- (void)openApp {
//	[self openAppStore:@"935188636"];
//}
//
//- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
//{
//	[viewController dismissViewControllerAnimated:YES completion:nil];
//}
//
//- (void)openAppStore:(NSString *)appId
//{
//	SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
//	storeProductVC.delegate = self;
//
//	NSDictionary *dict = [NSDictionary dictionaryWithObject:appId forKey:SKStoreProductParameterITunesItemIdentifier];
//	[storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError *error)
//	 {
//		 if (result)
//		 {
//			 [self presentViewController:storeProductVC animated:YES completion:nil];
//		 }
//	 }];
//}
//


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
	[exitButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
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
