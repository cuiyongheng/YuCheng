//
//  RegisterVC.m
//  YuCheng
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RegisterVC.h"
#import "RegisterView.h"
#import "RegisterAccountVC.h"
#import "WXRegisterVC.h"
#import "NSString+MD5Addition.h"

@interface RegisterVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UIButton *registerButton;

@property (nonatomic, strong) UIButton *lognButton;// 登录

@property (nonatomic, strong) UIButton *sendButton;// 发送验证码

@property (nonatomic, strong) RegisterView *registerOneView;

@property (nonatomic, strong) RegisterView *registerTwoView;

@end

@implementation RegisterVC

{
	NSString *phoneStr;// 手机号
	NSString *codeStr;// 验证码
	BOOL isLogn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.view.backgroundColor = [UIColor blackColor];

	[self createView];

//	[self animation];

	// 背景图片
	// 用实例方法减少内存占用
	NSString *bacString = [[NSBundle mainBundle]pathForResource:@"yc6.24-79(1)"ofType:@"png"];
	UIImage *bacImage = [[UIImage alloc] initWithContentsOfFile:bacString];
	UIImageView *imgView = [[UIImageView alloc] initWithImage:bacImage];
	imgView.frame = CGRectMake(0, 0, WIDTH, self.view.frame.size.height);

	// 控件的宽度随父视图的宽度改变
	imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[self.view insertSubview:imgView atIndex:0];
}

#pragma mark - animation
- (void)animation {
	CABasicAnimation *anima = [CABasicAnimation animation];
	//1.1告诉系统要执行什么样的动画
	anima.keyPath = @"position";
	//设置通过动画，将layer从哪儿移动到哪儿
	anima.fromValue = [NSValue valueWithCGPoint:CGPointMake(-WIDTH, UNITHEIGHT * 253.5)];
	anima.toValue = [NSValue valueWithCGPoint:CGPointMake(WIDTH / 2, UNITHEIGHT * 253.5)];
	anima.duration = 1.0;

	//1.2设置动画执行完毕之后不删除动画d
	anima.removedOnCompletion = NO;
	//1.3设置保存动画的最新状态
	anima.fillMode = kCAFillModeForwards;
	anima.delegate = self;
	//打印
	//    NSString *str=NSStringFromCGPoint(self.myLayer.position);
	//	     NSLog(@"执行前：%@",str);

	//2.添加核心动画到layer
	[self.registerOneView.layer addAnimation:anima forKey:nil];



	CABasicAnimation *animaTwo = [CABasicAnimation animation];
	//1.1告诉系统要执行什么样的动画
	animaTwo.keyPath = @"position";
	//设置通过动画，将layer从哪儿移动到哪儿
	animaTwo.fromValue = [NSValue valueWithCGPoint:CGPointMake(-WIDTH, UNITHEIGHT * 312.5)];
	animaTwo.toValue = [NSValue valueWithCGPoint:CGPointMake(WIDTH / 2, UNITHEIGHT * 312.5)];
	animaTwo.duration = 1.0;

	//1.2设置动画执行完毕之后不删除动画d
	animaTwo.removedOnCompletion = NO;
	//1.3设置保存动画的最新状态
	animaTwo.fillMode = kCAFillModeForwards;
	animaTwo.delegate = self;
	[self.registerTwoView.layer addAnimation:animaTwo forKey:nil];



	[self performSelector:@selector(buttonAnimagtion) withObject:nil afterDelay:1.0f];
}

- (void)buttonAnimagtion {
	NSTimeInterval nowTime = [[NSDate date]timeIntervalSince1970] * 1000;
	NSInteger imTag = (long)nowTime % (3600000 * 24);
	UIImageView * sImgView = [[UIImageView alloc]initWithFrame:_lognButton.frame];
	sImgView.tag = imTag;
//	sImgView.image = [UIImage imageNamed:@"upimMainGrayShopCar"];
	[self.view addSubview:sImgView];

	//组动画之修改透明度
	CABasicAnimation * alphaBaseAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	alphaBaseAnimation.fillMode = kCAFillModeForwards;//不恢复原态
	alphaBaseAnimation.duration = 1.0f;
	alphaBaseAnimation.removedOnCompletion = NO;
	[alphaBaseAnimation setFromValue:[NSNumber numberWithFloat:0.0]];
	[alphaBaseAnimation setToValue:[NSNumber numberWithFloat:1.0]];
	alphaBaseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//决定动画的变化节奏



	CAAnimationGroup *animGroup = [CAAnimationGroup animation];
	animGroup.animations = @[alphaBaseAnimation];
	animGroup.duration = 1.0f;
	animGroup.fillMode = kCAFillModeForwards;//不恢复原态
	animGroup.removedOnCompletion = NO;
	[_lognButton.layer addAnimation:animGroup forKey:[NSString stringWithFormat:@"%ld",(long)imTag]];
	_lognButton.alpha = 1;

	[_sendButton.layer addAnimation:animGroup forKey:[NSString stringWithFormat:@"%ld",(long)imTag]];
	_sendButton.alpha = 1;

}

#pragma mark - createView
- (void)createView {
	// 注册
	self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_registerButton setTitle:@"跳过" forState:UIControlStateNormal];
	[_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[_registerButton addTarget:self action:@selector(registerPush:) forControlEvents:UIControlEventTouchUpInside];
	_registerButton.titleLabel.font = font(13);
	[self.view addSubview:_registerButton];

	[_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 31.5);
		make.top.mas_equalTo(self.view).with.offset(UNITHEIGHT * 44);
	}];

	self.logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yucheng"]];
	[self.view addSubview:_logoImageView];

	[_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_registerButton.mas_top).with.offset(UNITHEIGHT * 30);
		make.width.mas_equalTo(UNITHEIGHT * 62);
		make.height.mas_equalTo(UNITHEIGHT * 73.8);
		make.centerX.mas_equalTo(self.view);
	}];

	self.registerOneView = [[RegisterView alloc] init];
	_registerOneView.contentTextField.placeholder = @"手机号码";
	_registerOneView.contentTextField.delegate = self;
	_registerOneView.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
	_registerOneView.headImageView.image = [UIImage imageNamed:@"dianhua"];
	[self.view addSubview:_registerOneView];

	[_registerOneView.contentTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
	[_registerOneView.contentTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
	[_registerOneView.contentTextField setValue:@1 forKeyPath:@"_placeholderLabel.textAlignment"];

	[_registerOneView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.view);
		make.width.mas_equalTo(UNITHEIGHT * 375);
		make.height.mas_equalTo(UNITHEIGHT * 70);
		make.top.mas_equalTo(_logoImageView.mas_bottom).with.offset(UNITHEIGHT * 85);
	}];

	self.registerTwoView = [[RegisterView alloc] init];
	_registerTwoView.contentTextField.placeholder = @"验证码";
	_registerTwoView.contentTextField.delegate = self;
	_registerTwoView.headImageView.image = [UIImage imageNamed:@"register3"];
	[self.view addSubview:_registerTwoView];

	[_registerTwoView.contentTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
	[_registerTwoView.contentTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
	[_registerTwoView.contentTextField setValue:@1 forKeyPath:@"_placeholderLabel.textAlignment"];

	[_registerTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.view);
		make.width.mas_equalTo(WIDTH);
		make.height.mas_equalTo(UNITHEIGHT * 70);
		make.top.mas_equalTo(_registerOneView.mas_bottom);
	}];

	self.lognButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_lognButton setTitle:@"登录" forState:UIControlStateNormal];
	[_lognButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[_lognButton addTarget:self action:@selector(lognButton:) forControlEvents:UIControlEventTouchUpInside];
	_lognButton.titleLabel.font = font(18);
	_lognButton.backgroundColor = [UIColor colorWithHexString:@"#68c5da"];
	[self.view addSubview:_lognButton];
	_lognButton.layer.cornerRadius = UNITHEIGHT * 18;
	_lognButton.layer.masksToBounds = YES;

	[_lognButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.mas_equalTo(UNITHEIGHT * 200);
//		make.top.mas_equalTo(_registerTwoView.mas_bottom).with.offset(UNITHEIGHT * 20);
		make.height.mas_equalTo(UNITHEIGHT * 36);
		make.centerX.mas_equalTo(self.view);
		make.bottom.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 100);
	}];

	self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_sendButton setTitle:@"获取" forState:UIControlStateNormal];
	[_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[_sendButton addTarget:self action:@selector(sendButton:) forControlEvents:UIControlEventTouchUpInside];
	_sendButton.titleLabel.font = font(15);
	_sendButton.layer.cornerRadius = UNITHEIGHT * 5;
	_sendButton.layer.masksToBounds = YES;
	_sendButton.backgroundColor = [UIColor colorWithHexString:@"#68c5da"];
	[self.view addSubview:_sendButton];

	[_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(_registerTwoView).with.offset(UNITHEIGHT * 10);
		make.right.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 20);
		make.height.mas_equalTo(UNITHEIGHT * 25);
		make.width.mas_equalTo(UNITHEIGHT * 50);
	}];



	// 三方登录
	[self createThirdLogin];

}



#pragma mark - createThirdLogin
- (void)createThirdLogin {
	UIButton *WXButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	[WXButton setTitle:@"微信登录" forState:UIControlStateNormal];
//	[WXButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//	[WXButton setBackgroundImage:[UIImage imageNamed:@"yc6.24-97"] forState:UIControlStateNormal];
	[WXButton setTitle:@"微信登录" forState:UIControlStateNormal];
	[WXButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	WXButton.backgroundColor = [UIColor clearColor];
	[WXButton addTarget:self action:@selector(WXButton:) forControlEvents:UIControlEventTouchUpInside];
	WXButton.layer.cornerRadius = UNITHEIGHT * 18;
	WXButton.layer.masksToBounds = YES;
	WXButton.layer.borderColor = [UIColor whiteColor].CGColor;
	WXButton.layer.borderWidth = 1;
	[self.view addSubview:WXButton];

	[WXButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.mas_equalTo(UNITHEIGHT * 200);
		make.height.mas_equalTo(UNITHEIGHT * 36);
		make.bottom.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 50);
		make.centerX.mas_equalTo(self.view);
	}];

//	UIButton *QQButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	[QQButton setTitle:@"QQ登录" forState:UIControlStateNormal];
//	[QQButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//	[QQButton addTarget:self action:@selector(QQButton:) forControlEvents:UIControlEventTouchUpInside];
//	[self.view addSubview:QQButton];
//
//	[QQButton mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.height.width.top.mas_equalTo(WXButton);
//		make.left.mas_equalTo(WXButton.mas_right).with.offset(UNITHEIGHT * 18.75);
//	}];
//
//	UIButton *weiboButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	[weiboButton setTitle:@"微博登录" forState:UIControlStateNormal];
//	[weiboButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//	[weiboButton addTarget:self action:@selector(weiboButton:) forControlEvents:UIControlEventTouchUpInside];
//	[self.view addSubview:weiboButton];
//
//	[weiboButton mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.height.width.top.mas_equalTo(QQButton);
//		make.left.mas_equalTo(QQButton.mas_right).with.offset(UNITHEIGHT * 18.75);
//	}];


}



#pragma mark - ButtonLogin
- (void)WXButton:(UIButton *)button {
	// 微信登录
	__weak __typeof__(self) weakSelf = self;
	UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];

	snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){

		if (response.responseCode == UMSResponseCodeSuccess) {

			NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
			UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
			NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);

			NSDictionary *paramsDic = @{@"username" : snsAccount.userName, @"token" : snsAccount.accessToken, @"unionId" : snsAccount.unionId, @"country" : response.thirdPlatformUserProfile[@"country"], @"province" : response.thirdPlatformUserProfile[@"province"], @"city" : response.thirdPlatformUserProfile[@"city"], @"usid" : snsAccount.usid, @"iconUrl" : snsAccount.iconURL, @"sex" : response.thirdPlatformUserProfile[@"sex"]};



			[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userBindWechat.php?act=wechat_login" params:paramsDic Success:^(id responseObject) {

				NSLog(@"%@", responseObject);
				if ([responseObject[@"bind"] isEqualToString:@"0"]) {
					// 未绑定微信
#warning 未绑定微信
					WXRegisterVC *WXVC = [[WXRegisterVC alloc] init];
					WXVC.usid = response.thirdPlatformUserProfile[@"openid"];
					WXVC.headerImageView = snsAccount.iconURL;
					[weakSelf.navigationController pushViewController:WXVC animated:YES];

				} else {
					// 已绑定
#warning 已绑定微信
					[self dismissViewControllerAnimated:YES completion:nil];
					NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"]);
					__block NSMutableDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
					NSString *MD5Info = [NSString stringWithFormat:@"ER21Ha26jIu89SHI02sa45Shou11MEI%@%@%@", responseObject[@"mobile_phone"], responseObject[@"user_id"], responseObject[@"auto_code"]];

					// 自动登录
					[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/mobileAutoLogin.php" params:@{@"auto_code" : [MD5Info stringFromMD5Lowercase]} Success:^(id responseObject) {

						NSLog(@"%@", responseObject);
						if ([responseObject[@"status"] isEqual:@0]) {
							[[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"Register"];
							[[NSUserDefaults standardUserDefaults] synchronize];
						} else {
							[[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"Register"];
							[[NSUserDefaults standardUserDefaults] synchronize];
							[self dismissViewControllerAnimated:YES completion:nil];
							
							if (responseObject[@"auto_code"] == nil) {

								NSDictionary *dic = @{@"phone" : userInfo[@"phone"], @"user_id" : userInfo[@"user_id"], @"auto_code" : userInfo[@"auto_code"]};
								[[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"userInfo"];
								[[NSUserDefaults standardUserDefaults] synchronize];
							} else {
								if (userInfo) {
									NSDictionary *dic = @{@"phone" : userInfo[@"phone"], @"user_id" : userInfo[@"user_id"], @"auto_code" : responseObject[@"auto_code"]};
									[[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"userInfo"];
									[[NSUserDefaults standardUserDefaults] synchronize];
								}
							}



							// cookie
							NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
							for (NSHTTPCookie *cookie in [cookieJar cookies]) {
								if ([cookie.name isEqualToString:@"ECS_ID"]) {
									[[NSUserDefaults standardUserDefaults] setObject:cookie.properties forKey:@"cookie"];
								}
							}
						}


					} Failed:^(NSError *error) {
						
					}];
				}

			} Failed:^(NSError *error) {

			}];

		}
		
	});
}

- (void)QQButton:(UIButton *)button {
	// QQ登录
//	UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
//
//	snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//
//		//          获取微博用户名、uid、token等
//
//		if (response.responseCode == UMSResponseCodeSuccess) {
//
//			NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
//			UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
//			NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
//			
//		}});
}

- (void)weiboButton:(UIButton *)button {
	// 微博登录
//	UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
//
//	snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//
//		//          获取微博用户名、uid、token等
//
//		if (response.responseCode == UMSResponseCodeSuccess) {
//
//			NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
//			UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
//			NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
//			
//		}});
}



#pragma mark - buttonPush
- (void)registerPush:(UIButton *)button {
//	RegisterAccountVC *registerAccountVC = [[RegisterAccountVC alloc] init];
//	[self.navigationController pushViewController:registerAccountVC animated:YES];
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)lognButton:(UIButton *)button {
	[self.view endEditing:YES];
	if (phoneStr && codeStr) {
		NSDictionary *paramsDic = @{@"mobile" : phoneStr, @"code" : codeStr};
		[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userLogin.php" params:paramsDic Success:^(id responseObject) {

			if ([responseObject[@"status"] isEqual:@1]) {
				isLogn = 1;
				[self showAlert:@"登陆成功" err:responseObject[@"info"]];

				[[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"Register"];
				[[NSUserDefaults standardUserDefaults] synchronize];

				NSHTTPCookieStorage *myCookie = [NSHTTPCookieStorage sharedHTTPCookieStorage];
				NSLog(@"%@", myCookie);
				for (NSHTTPCookie *cookie in [myCookie cookies]) {
					NSLog(@"%@", cookie);
					[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie]; // 保存
				}



				// cookie
				NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
				for (NSHTTPCookie *cookie in [cookieJar cookies]) {
					if ([cookie.name isEqualToString:@"ECS_ID"]) {
						[[NSUserDefaults standardUserDefaults] setObject:cookie.properties forKey:@"cookie"];
					}
				}

				NSDictionary *userDic = @{@"phone" : phoneStr, @"auto_code" : responseObject[@"auto_code"], @"user_id" : responseObject[@"user_id"]};

				[[NSUserDefaults standardUserDefaults] setObject:userDic forKey:@"userInfo"];
				[[NSUserDefaults standardUserDefaults] synchronize];
			} else {
				[self showAlert:@"登陆失败" err:responseObject[@"info"]];
			}

			NSLog(@"%@", responseObject);


		} Failed:^(NSError *error) {

		}];
	} else {
		[self showAlert:@"登录失败" err:@"请输入正确信息"];
	}
}



#pragma mark - 发送验证码
- (void)sendButton:(UIButton *)button {
	[self.view endEditing:YES];
	if (phoneStr) {

		NSDictionary *paramsDic = @{@"mobile_phone" : phoneStr};
		[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/sendLoginSms.php" params:paramsDic Success:^(id responseObject) {

			if ([responseObject[@"status"] isEqual:@1]) {
				[self showAlert:@"发送验证码成功" err:responseObject[@"info"]];
				[self performSelector:@selector(againGetPass) withObject:nil afterDelay:0];
			} else {
				[self showAlert:@"发送验证码失败" err:responseObject[@"info"]];
			}

		} Failed:^(NSError *error) {

		}];

	} else {
		[self showAlert:@"发送验证码失败" err:@"请输入正确手机号"];
	}

}

- (void)againGetPass {
	_sendButton.backgroundColor = [UIColor whiteColor];
	[_sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	_sendButton.userInteractionEnabled = NO;
	[self performSelector:@selector(canGetPass) withObject:nil afterDelay:60];
}

- (void)canGetPass {
	_sendButton.backgroundColor = [UIColor colorWithHexString:@"#68c5da"];
	[_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	_sendButton.userInteractionEnabled = YES;
}



#pragma mark - 监听输入
- (void)textFieldDidEndEditing:(UITextField *)textField {
	if (textField == _registerOneView.contentTextField) {
		phoneStr = textField.text;
	} else {
		codeStr = textField.text;
	}
}



#pragma mark - alert
- (void)showAlert:(NSString *)title err:(NSString *)err {
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:err preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction *tureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		if (isLogn) {
			[self registerPush:_registerButton];
		}
	}];
	[alert addAction:tureAction];

	[self presentViewController:alert animated:YES completion:^{

	}];
}



#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
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
