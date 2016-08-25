//
//  MoreYuChengVC.m
//  YuCheng
//
//  Created by apple on 16/8/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MoreYuChengVC.h"
#import "UserTableCell.h"
#import "MyYuChengWebVC.h"

@interface MoreYuChengVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation MoreYuChengVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	[self createView];
	[self createData];
}



#pragma mark - createView
- (void)createView {
	self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:_tableView];

	[_tableView registerClass:[UserTableCell class] forCellReuseIdentifier:@"moreCell"];

}

#pragma mark - createData
- (void)createData {

	_titleArr = @[@"使用帮助", @"售后帮助", @"鉴定中心", @"在线客服", @"关于玉城", @"清除缓存"];
}



#pragma mark - tabelViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UserTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreCell"];

	cell.titleLabel.text = [NSString stringWithFormat:@"%@", _titleArr[indexPath.row]];

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0) {
		// 使用帮助
		MyYuChengWebVC *webVC = [[MyYuChengWebVC alloc] init];
		webVC.webURL = @"http://www.jadechina.cn/mobile/article_app.php?type=2";
		[self.navigationController pushViewController:webVC animated:YES];
		
	} else if (indexPath.row == 1) {
		// 售后帮助
		MyYuChengWebVC *webVC = [[MyYuChengWebVC alloc] init];
		webVC.webURL = @"http://www.jadechina.cn/mobile/article_app.php?type=4";
		[self.navigationController pushViewController:webVC animated:YES];

	} else if (indexPath.row == 2) {
		// 鉴定中心
		MyYuChengWebVC *webVC = [[MyYuChengWebVC alloc] init];
		webVC.webURL = @"http://www.jadechina.cn/mobile/article_app.php?type=3";
		[self.navigationController pushViewController:webVC animated:YES];

	} else if (indexPath.row == 3) {
		// 在线客服
		[self callPhone];
		
	} else if (indexPath.row == 4) {
		// 关于客服
		MyYuChengWebVC *webVC = [[MyYuChengWebVC alloc] init];
		webVC.webURL = @"http://www.jadechina.cn/mobile/article_app.php?type=1";
		[self.navigationController pushViewController:webVC animated:YES];
		
	} else if (indexPath.row == 5) {
		// 清除缓存
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

	return folderSize / (1024.0 * 1024.0);
}

- (long long) fileSizeAtPath:(NSString*) filePath {

	NSFileManager* manager = [NSFileManager defaultManager];

	if ([manager fileExistsAtPath:filePath]){

		return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
	}
	return 0;
}

#pragma mark - applyButton
- (void)callPhone {
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"在线客服" message:[NSString stringWithFormat:@"请拨打%@", _phone] preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction *callAlert = [UIAlertAction actionWithTitle:@"拨打" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		[self callAction];
	}];

	UIAlertAction *cancleAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
		[self dismissViewControllerAnimated:YES completion:nil];
	}];

	[alert addAction:callAlert];
	[alert addAction:cancleAlert];
	[self presentViewController:alert animated:YES completion:^{

	}];
	
}

- (void)callAction{

	NSString *number = _phone;// 此处读入电话号码

	NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法 结束电话之后会进入联系人列表



	//	NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核

	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
	
}



#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.navigationController.navigationBar.hidden = NO;
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	self.navigationController.navigationBar.hidden = YES;
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

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
