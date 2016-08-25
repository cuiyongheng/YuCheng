//
//  MyYuChangeVC.m
//  YuCheng
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyYuChangeVC.h"
#import "UserHeadView.h"
#import "UserTableCell.h"
#import "MyOrderViewController.h"
#import "SettingVC.h"
#import "MyAddressVC.h"
#import "MyTicketVC.h"
#import "MyEvaluateVC.h"
#import "MyCollectionVC.h"
#import "AboutYuChengVC.h"
#import "WXRegisterVC.h"
#import "MyYuChengWebVC.h"
#import "FootMarkVC.h"
#import "MoreYuChengVC.h"


@interface MyYuChangeVC ()<UITableViewDataSource, UITableViewDelegate, UserHeadViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UserHeadView *headView;

@property (nonatomic, strong) NSMutableArray *funcArr;

@end

@implementation MyYuChangeVC

{
	NSString *nameStr;
	NSString *phone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的玉城";

	[self createView];

	[self createData];
}



#pragma mark - createData
- (void)createData {
	self.funcArr = [NSMutableArray arrayWithObjects:@"我的优惠券", @"收货地址", @"我的收藏", @"我的评价", @"使用帮助", @"我的足迹", @"", @"", @"", nil];

	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userCenter.php" params:nil Success:^(id responseObject) {

		if ([responseObject[@"login_status"] isEqual:@0]) {

		} else {
			phone = responseObject[@"service_phone"];
			if (responseObject[@"user_info"][@"wechat_nickname_app"] == [NSNull null]) {
				_headView.nameLabel.text = [NSString stringWithFormat:@"%@", responseObject[@"user_info"][@"user_name"]];
			} else {
				if ([responseObject[@"user_info"][@"wechat_nickname_app"] length] == 0) {
					_headView.nameLabel.text = [NSString stringWithFormat:@"%@", responseObject[@"user_info"][@"user_name"]];
				} else {
					_headView.nameLabel.text = [NSString stringWithFormat:@"%@", responseObject[@"user_info"][@"wechat_nickname_app"]];
				}
			}

			if ([responseObject[@"user_info"][@"head_img"] hasPrefix:@"/mobile/"]) {
				[_headView.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, responseObject[@"user_info"][@"head_img"]]] placeholderImage:[UIImage imageNamed:@"yc-48"]];
			} else {
				[_headView.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", responseObject[@"user_info"][@"head_img"]]] placeholderImage:[UIImage imageNamed:@"yc-48"]];
			}
		}

	} Failed:^(NSError *error) {
		
	}];
}



#pragma mark - createView
- (void)createView {
	self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.backgroundColor = [UIColor colorWithRed:45 / 255.0 green:47 / 255.0 blue:48 / 255.0 alpha:1];
//	_tableView.bounces = NO;
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	_tableView.showsVerticalScrollIndicator = NO;
	[self.view addSubview:_tableView];

	[_tableView registerClass:[UserTableCell class] forCellReuseIdentifier:@"userCell"];

	self.headView = [[UserHeadView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 280)];
	_headView.delegate = self;
	_headView.backgroundColor = [UIColor whiteColor];
	_tableView.tableHeaderView = _headView;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.funcArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UserTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell"];

	cell.titleLabel.text = [NSString stringWithFormat:@"%@", _funcArr[indexPath.row]];

	if (indexPath.row > 5) {
		cell.lineView.hidden = YES;
	}
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return UNITHEIGHT * 42.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (indexPath.row == 0) {
		// 我的优惠券
		MyTicketVC *ticketVC = [[MyTicketVC alloc] init];
		ticketVC.isMyYuCheng = 1;
		[self.navigationController pushViewController:ticketVC animated:YES];
	} else if (indexPath.row == 1) {
		// 收货地址
		MyAddressVC *addressVC = [[MyAddressVC alloc] init];
		addressVC.isMyYuCheng = 1;
		[self.navigationController pushViewController:addressVC animated:YES];
	} else if (indexPath.row == 2) {
		// 我的收藏
		MyCollectionVC *collectionVC = [[MyCollectionVC alloc] init];
		[self.navigationController pushViewController:collectionVC animated:YES];
	} else if (indexPath.row == 3) {
		// 我的评价
		MyEvaluateVC *evaluateVC = [[MyEvaluateVC alloc] init];
		[self.navigationController pushViewController:evaluateVC animated:YES];
	} else if (indexPath.row == 4) {
		// 清除缓存
//		NSString *sandBoxPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//		NSString *folderSize = [NSString stringWithFormat:@"是否要清除缓存(%.2fM)", [self folderSizeAtPath:sandBoxPath]];
//
//		// 清除缓存
//		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除缓存" message:folderSize preferredStyle:1];
//		UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//			[SaveWorking clearSave];
//			[self.tableView reloadData];
//		}];
//		UIAlertAction *alertcanel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//
//		}];
//		[alert addAction:alertcanel];
//		[alert addAction:alertAction];
//
//		[self presentViewController:alert animated:YES completion:^{
//			
//		}];

		// 使用帮助
		MoreYuChengVC *moreVC = [[MoreYuChengVC alloc] init];
		moreVC.phone = phone;
		[self.navigationController pushViewController:moreVC animated:YES];

	} else if (indexPath.row == 4) {
//		// 使用帮助
//		MoreYuChengVC *moreVC = [[MoreYuChengVC alloc] init];
//		moreVC.phone = phone;
//		[self.navigationController pushViewController:moreVC animated:YES];
//		MyYuChengWebVC *webVC = [[MyYuChengWebVC alloc] init];
//		webVC.webURL = @"http://www.jadechina.cn/mobile/article_app.php?type=2";
//		[self.navigationController pushViewController:webVC animated:YES];

	} else if (indexPath.row == 6) {
		// 售后帮助
//		MyYuChengWebVC *webVC = [[MyYuChengWebVC alloc] init];
//		webVC.webURL = @"http://www.jadechina.cn/mobile/article_app.php?type=4";
//		[self.navigationController pushViewController:webVC animated:YES];

	} else if (indexPath.row == 7) {
		// 鉴定中心
//		MyYuChengWebVC *webVC = [[MyYuChengWebVC alloc] init];
//		webVC.webURL = @"http://www.jadechina.cn/mobile/article_app.php?type=3";
//		[self.navigationController pushViewController:webVC animated:YES];

	} else if (indexPath.row == 8) {
		// 在线客服
//		[self callPhone];

	} else if (indexPath.row == 9) {
		// 关于玉城
//		MyYuChengWebVC *webVC = [[MyYuChengWebVC alloc] init];
//		webVC.webURL = @"http://www.jadechina.cn/mobile/article_app.php?type=1";
//		[self.navigationController pushViewController:webVC animated:YES];

	}  else if (indexPath.row == 5) {
		// 我的足迹
		FootMarkVC *footMarkVC = [[FootMarkVC alloc] init];
		[self.navigationController pushViewController:footMarkVC animated:YES];
//		WXRegisterVC *wxVC = [[WXRegisterVC alloc] init];
//		[self.navigationController pushViewController:wxVC animated:YES];
	}
}

#pragma mark - applyButton
//- (void)callPhone {
//	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"申请维权" message:[NSString stringWithFormat:@"申请维权请拨打%@", phone] preferredStyle:UIAlertControllerStyleAlert];
//
//	UIAlertAction *callAlert = [UIAlertAction actionWithTitle:@"拨打" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//		[self callAction];
//	}];
//
//	UIAlertAction *cancleAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//		[self dismissViewControllerAnimated:YES completion:nil];
//	}];
//
//	[alert addAction:callAlert];
//	[alert addAction:cancleAlert];
//	[self presentViewController:alert animated:YES completion:^{
//
//	}];
//
//}



//- (void)callAction{
//
//	NSString *number = phone;// 此处读入电话号码
//
//	NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法 结束电话之后会进入联系人列表
//
//
//
//	//	NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
//
//	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
//	
//}


#pragma mark - floderPath
//- (float) folderSizeAtPath:(NSString*) folderPath{
//
//	NSFileManager* manager = [NSFileManager defaultManager];
//
//	if (![manager fileExistsAtPath:folderPath]) return 0;
//
//	NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
//
//	NSString* fileName;
//
//	long long folderSize = 0;
//
//	while ((fileName = [childFilesEnumerator nextObject]) != nil){
//
//		NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
//
//		folderSize += [self fileSizeAtPath:fileAbsolutePath];
//
//	}
//
//	return folderSize / (1024.0 * 1024.0);
//}
//
//- (long long) fileSizeAtPath:(NSString*) filePath {
//
//	NSFileManager* manager = [NSFileManager defaultManager];
//
//	if ([manager fileExistsAtPath:filePath]){
//
//		return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
//	}
//	return 0;
//}



#pragma  mark - headerDelegate
- (void)MyOrderViewController {
	// 我的订单
	MyOrderViewController *orderVC = [[MyOrderViewController alloc] init];
	orderVC.orderStats = MyOrder;
	[self.navigationController pushViewController:orderVC animated:YES];
}

- (void)refundViewController {
	// 退款商品
	MyOrderViewController *orderVC = [[MyOrderViewController alloc] init];
	orderVC.orderStats = refund;
	[self.navigationController pushViewController:orderVC animated:YES];
}

- (void)receivingViewController {
	// 待收货
	MyOrderViewController *orderVC = [[MyOrderViewController alloc] init];
	orderVC.orderStats = waitsend;
	[self.navigationController pushViewController:orderVC animated:YES];
}

- (void)payViewController {
	// 待付款
	MyOrderViewController *orderVC = [[MyOrderViewController alloc] init];
	orderVC.orderStats = waitPay;
	[self.navigationController pushViewController:orderVC animated:YES];
}

- (void)changeName {
	// 修改名字
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改昵称" message:@"请输入新昵称" preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction *cancleAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {

	}];

	UIAlertAction *tureAlert = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];

		[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userCenter.php?act=update_username" params:@{@"username" : nameStr} Success:^(id responseObject) {
			if ([responseObject[@"status"] isEqual:@1]) {
				_headView.nameLabel.text = nameStr;
			} else {
				[RegosterAlert showAlert:@"改名失败" err:responseObject[@"info"]];
			}
		} Failed:^(NSError *error) {

		}];
	}];

	[alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
	}];

	tureAlert.enabled = NO;
	[alert addAction:cancleAlert];
	[alert addAction:tureAlert];

	[self presentViewController:alert animated:YES completion:^{

	}];
}

- (void)alertTextFieldDidChange:(NSNotification *)notification{
	UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
	if (alertController) {
		UITextField *login = alertController.textFields.firstObject;
		UIAlertAction *okAction = alertController.actions.lastObject;
		okAction.enabled = login.text.length > 2;
		nameStr = login.text;
	}
}



- (void)mySetting {
	// 退出登录

	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userLogin.php?act=logout" params:nil Success:^(id responseObject) {

		if ([responseObject[@"status"] isEqual:@1]) {
			// 退出登录成功
			[RegosterAlert showAlert:@"退出成功" err:responseObject[@"info"]];
			[[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"Register"];
			[[NSUserDefaults standardUserDefaults] synchronize];
		} else {
			[RegosterAlert showAlert:@"退出失败" err:responseObject[@"info"]];
		}

		if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Register"] isEqual:@1]) {
			_headView.settingButton.hidden = NO;
		} else {
//			_headView.settingButton.hidden = YES;
		}
		dispatch_async(dispatch_get_main_queue(), ^{
			_headView.headImageView.image = [UIImage imageNamed:@"yc-48"];
			_headView.nameLabel.text = @"";
			[self reloadInputViews];
		});

	} Failed:^(NSError *error) {

	}];



//	SettingVC *settingVC = [[SettingVC alloc] init];
//	[self.navigationController pushViewController:settingVC animated:YES];
}

- (void)updateImageViewForService {
	// 修改头像
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	// 可编辑
	picker.allowsEditing = YES;
	// 要通过choose获取本地图片就必须签订协议
	picker.delegate = self;
	// 模态显示出来
	[self presentViewController:picker animated:YES completion:^{

	}];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
	// 先让相册消失
	[picker dismissViewControllerAnimated:YES completion:^{

	}];
	UIImage *image = info[UIImagePickerControllerEditedImage];
	_headView.headImageView.image = image;



	NetWorkingTool *tool = [[NetWorkingTool alloc] init];
	[tool uploadImg:_headView.headImageView.image URL:@"http://www.jadechina.cn/mapi/headImgUpload.php" type:nil Success:^(id responseObject) {

		if ([responseObject[@"status"] isEqual:@1]) {
			[_headView.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, responseObject[@"img_url"]]] placeholderImage:[UIImage imageNamed:@""]];
			
		} else {
			[RegosterAlert showAlert:@"上传头像失败" err:nil];
		}
	}];
}



#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.navigationController.navigationBar.hidden = YES;
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
	self.tabBarController.tabBar.hidden = NO;
	if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Register"] isEqual:@1]) {
		_headView.settingButton.hidden = NO;
	} else {
		//		_headView.settingButton.hidden = YES;
	}
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self createData];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	self.navigationController.navigationBar.hidden = NO;
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
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
