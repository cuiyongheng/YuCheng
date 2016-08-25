//
//  SureClearingVC.m
//  YuCheng
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SureClearingVC.h"

@interface SureClearingVC ()

@property (nonatomic, strong) UILabel *orderLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UILabel *sendLabel;

@end

@implementation SureClearingVC

{
	UIButton *tureButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.title = @"提交订单";

	[self createView];

	NSLog(@"%@", _modelDic);

}

- (void)createView {
	UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(UNITHEIGHT * 20, 64, WIDTH - UNITHEIGHT * 40, 1)];
	topView.backgroundColor = [UIColor colorWithHexString:@"#a5a5a5"];
	[self.view addSubview:topView];

	UILabel *successLabel = [[UILabel alloc] init];
	successLabel.text = @"订单已提交成功";
	successLabel.font = boldFont(18);
	[self.view addSubview:successLabel];

	[successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.view);
		make.height.mas_equalTo(UNITHEIGHT * 20);
		make.top.mas_equalTo(topView).with.offset(UNITHEIGHT * 30);
	}];

	UIImageView *binggouView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yc6.24-91"]];
	[self.view addSubview:binggouView];

	[binggouView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(successLabel.mas_left).with.offset(-UNITHEIGHT * 10);
		make.centerY.mas_equalTo(successLabel);
		make.height.width.mas_equalTo(UNITHEIGHT * 30);
	}];

	UIView *bottomView = [[UIView alloc] init];
	bottomView.backgroundColor = [UIColor colorWithHexString:@"#a5a5a5"];
	[self.view addSubview:bottomView];

	[bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(topView);
		make.top.mas_equalTo(successLabel.mas_bottom).with.offset(UNITHEIGHT * 30);
		make.height.mas_equalTo(1);
	}];

	[self createDataLabel];

}

- (void)createDataLabel {
	self.orderLabel = [[UILabel alloc] init];
	_orderLabel.text = [NSString stringWithFormat:@"订单号：%@", _modelDic[@"order_sn"]];
	_orderLabel.font = font(14);
	[self.view addSubview:_orderLabel];

	[_orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.view).with.offset(UNITHEIGHT * 20);
		make.top.mas_equalTo(self.view).with.offset(UNITHEIGHT * 164);
		make.right.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 20);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

	self.moneyLabel = [[UILabel alloc] init];
	_moneyLabel.text = [NSString stringWithFormat:@"支付金额：¥%@", _modelDic[@"order_amount"]];
	_moneyLabel.font = font(14);
	[self.view addSubview:_moneyLabel];

	[_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_orderLabel);
		make.top.mas_equalTo(_orderLabel.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

	self.sendLabel = [[UILabel alloc] init];
	_sendLabel.text = [NSString stringWithFormat:@"配送方式：%@", _modelDic[@"shipping_name"]];
	_sendLabel.font = font(14);
	[self.view addSubview:_sendLabel];

	[_sendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_moneyLabel);
		make.top.mas_equalTo(_moneyLabel.mas_bottom).with.offset(UNITHEIGHT *10);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

	tureButton = [UIButton buttonWithType:UIButtonTypeCustom];
	tureButton.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
	[tureButton setTitle:@"前往支付" forState:UIControlStateNormal];
	[tureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[tureButton addTarget:self action:@selector(tureButton:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:tureButton];

	[tureButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 15);
		make.height.mas_equalTo(UNITHEIGHT * 45);
		make.left.mas_equalTo(self.view).with.offset(UNITHEIGHT * 20);
		make.right.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 20);
	}];

	if ([_modelDic[@"pay_id"] isEqual:@6]) {
		tureButton.hidden = YES;
	}
}



#pragma mark - tureButton
- (void)tureButton:(UIButton *)button {
	NSLog(@"前往支付");

	if ([_modelDic[@"pay_id"] isEqual:@1]) {
		// 支付宝支付

	} else if ([_modelDic[@"pay_id"] isEqual:@7]) {
		// 微信支付

		[self jumpToBizPay];
	} else if ([_modelDic[@"pay_id"] isEqual:@6]) {
		// 货到付款

	}

//	if( ![@"" isEqual:res] ){
//		UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//
//		[alter show];
//	}

}

#warning 支付
- (void)jumpToBizPay {

	//============================================================
	// V3&V4支付流程实现
	//============================================================
//	NSString *urlString   = @"http://yucheng.chebank.com/testpay.php";
//	//解析服务端返回json数据
//	NSError *error;
//	//加载一个NSURL对象
//	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//	request.HTTPMethod = @"POST";
//	NSString *str = [NSString stringWithFormat:@"order_id=%@", _modelDic[@"order_id"]];
//
//	// 将字符串转换成数据
//	request.HTTPBody = [str dataUsingEncoding:NSUTF8StringEncoding];

	NSString *paramsID;
	if ([_modelDic[@"parent_order_id"] isEqual:@0]) {
		// 一个订单
		paramsID = _modelDic[@"order_id"];
		[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/apppay.php" params:@{@"order_id" : paramsID} Success:^(id responseObject) {

			NSLog(@"%@", responseObject);

			[WXPay WXPay:responseObject Success:^{
				// 支付成功

			}];

		} Failed:^(NSError *error) {
			
		}];
	} else {
		// 多个订单
		paramsID = _modelDic[@"parent_order_id"];
		[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/apppay.php" params:@{@"parent_order_id" : paramsID} Success:^(id responseObject) {

			NSLog(@"%@", responseObject);

			[WXPay WXPay:responseObject Success:^{
				// 支付成功

			}];

		} Failed:^(NSError *error) {
			
		}];
	}

}

#pragma mark - 收到支付成功的消息后作相应的处理
- (void)getOrderPayResult:(NSNotification *)notification
{
	if ([notification.object isEqualToString:@"success"])
	{
		NSLog(@"支付成功！");

		if ([_modelDic[@"parent_order_id"] isEqual:@0]) {
			// 一个订单
			[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/payResult.php" params:@{@"order_id" : _modelDic[@"order_id"]} Success:^(id responseObject) {

				if ([responseObject[@"retcode"] isEqualToString:@"0"]) {
					[self showAlert:@"支付失败" err:responseObject[@"retmsg"]];
				} else {
					[self showAlert:@"支付成功" err:responseObject[@"retmsg"]];

				}

			} Failed:^(NSError *error) {
				
			}];
		} else {
			// 多个订单
			[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/payResult.php" params:@{@"parent_order_id" : _modelDic[@"parent_order_id"]} Success:^(id responseObject) {

				if ([responseObject[@"retcode"] isEqualToString:@"0"]) {
					[self showAlert:@"支付失败" err:responseObject[@"retmsg"]];
				} else {
					[self showAlert:@"支付成功" err:responseObject[@"retmsg"]];

				}

			} Failed:^(NSError *error) {
				
			}];
		}
	}
	else
	{
		if ([_modelDic[@"parent_order_id"] isEqual:@0]) {
			// 一个订单
			[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/payResult.php" params:@{@"order_id" : _modelDic[@"order_id"]} Success:^(id responseObject) {

				if ([responseObject[@"retcode"] isEqualToString:@"0"]) {
					[self showAlert:@"支付失败" err:responseObject[@"retmsg"]];
				} else {
					[self showAlert:@"支付成功" err:responseObject[@"retmsg"]];

				}

			} Failed:^(NSError *error) {

			}];
		} else {
			// 多个订单
			[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/payResult.php" params:@{@"parent_order_id" : _modelDic[@"parent_order_id"]} Success:^(id responseObject) {

				if ([responseObject[@"retcode"] isEqualToString:@"0"]) {
					[self showAlert:@"支付失败" err:responseObject[@"retmsg"]];
				} else {
					[self showAlert:@"支付成功" err:responseObject[@"retmsg"]];

				}

			} Failed:^(NSError *error) {
				
			}];
		}

		NSLog(@"支付失败！");
	}
}

- (void)showAlert:(NSString *)title err:(NSString *)err {
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:err preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction *tureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		[self.navigationController popToRootViewControllerAnimated:YES];
	}];
	[alert addAction:tureAction];

	[self presentViewController:alert animated:YES completion:^{

	}];
}



- (void)leftItemAction:(UIButton *)button {
	[self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.tabBarController.tabBar.hidden = YES;

	// 监听通知
	if([WXApi isWXAppInstalled]) // 判断 用户是否安装微信
	{
		// 监听一个通知
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"ORDER_PAY_NOTIFICATION" object:nil];
	}
	[super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 移除通知
- (void)dealloc
{
	[[NSNotificationCenter defaultCenter]removeObserver:self];
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
