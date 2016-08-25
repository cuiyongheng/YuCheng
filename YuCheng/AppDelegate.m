//
//  AppDelegate.m
//  YuCheng
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "MyYuChangeVC.h"
#import "StoreViewController.h"
#import "ShoppingBagVC.h"
#import "ClassifyVC.h"
#import <OpenShareHeader.h>
#import <UMSocialSinaSSOHandler.h>
#import <UMSocialData.h>
#import <UMSocialQQHandler.h>
#import <UMSocialWechatHandler.h>
#import "NSString+MD5Addition.h"

@interface AppDelegate ()<UITabBarControllerDelegate, UIScrollViewDelegate, WXApiDelegate>

@property (nonatomic, strong) UIPageControl *page;

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.



	// 主页
	HomeViewController *homeVC = [[HomeViewController alloc] init];
	UINavigationController *homeNaVC = [[UINavigationController alloc] initWithRootViewController:homeVC];
	homeNaVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"首页图标-4"] selectedImage:nil];

	// 商铺
	//    StoreViewController *storeVC = [[StoreViewController alloc] init];
	//    UINavigationController *storeNaVC = [[UINavigationController alloc] initWithRootViewController:storeVC];
	//	storeNaVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"商铺" image:[UIImage imageNamed:@"fenlei"] selectedImage:nil];

	// 分类
	ClassifyVC *storeVC = [[ClassifyVC alloc] init];
	UINavigationController *storeNaVC = [[UINavigationController alloc] initWithRootViewController:storeVC];
	storeNaVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分类" image:[UIImage imageNamed:@"首页图标-5"] selectedImage:nil];

	// 购物袋
	ShoppingBagVC *shoppingVC = [[ShoppingBagVC alloc] init];
	shoppingVC.isTabPush = 1;
	UINavigationController *shoppingNaVC = [[UINavigationController alloc] initWithRootViewController:shoppingVC];
	shoppingNaVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"购物车" image:[UIImage imageNamed:@"首页图标-6"] selectedImage:nil];

	// 我的玉城
	MyYuChangeVC *yuChangeVC = [[MyYuChangeVC alloc] init];
	UINavigationController *yuChangeNaVC = [[UINavigationController alloc] initWithRootViewController:yuChangeVC];
	yuChangeNaVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的玉城" image:[UIImage imageNamed:@"首页图标-7"] selectedImage:nil];

	self.tab = [[UITabBarController alloc] init];
	_tab.viewControllers = @[homeNaVC, storeNaVC, shoppingNaVC, yuChangeNaVC];
//	self.window.rootViewController = _tab;

	UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 49)];
	backView.backgroundColor = [UIColor blackColor];
	[_tab.tabBar insertSubview:backView atIndex:0];
	_tab.tabBar.opaque = YES;
	_tab.tabBar.tintColor = [UIColor whiteColor];
	_tab.delegate = self;

	// 修改tabbar字体颜色
	//	[[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
	//
	//	[[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor blackColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];

	// 分享
	[self openShare];

	// 地图
	[self map];

	// 自动登录
	[self autoLogin];

	// 创建文件夹
	[SaveTool isHaveFile];

	// 引导页
	// 沙盒路径
	NSString *sandBoxPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	NSString *docPath = [sandBoxPath stringByAppendingPathComponent:@"Yucheng/lead.plist"];
	NSLog(@"%@", docPath);
	//创建文件管理制
	NSFileManager *manager = [NSFileManager defaultManager];
	if (![manager fileExistsAtPath:docPath]) {

		// 第一次进入App
		[manager createDirectoryAtPath:docPath withIntermediateDirectories:YES attributes:nil error:nil];

		// 启动引导页
		[self startLeadScroll];
	} else {

		// 主页
		self.window.rootViewController = _tab;
	}

    return YES;
}



#pragma mark - map
- (void)map {
	// 要使用百度地图，请先启动BaiduMapManager
	_mapManager = [[BMKMapManager alloc]init];
	// 如果要关注网络及授权验证事件，请设定     generalDelegate参数
	BOOL ret = [_mapManager start:@"q24hGH0NolOl6hRw7McT7GyQOlNuqTjp"  generalDelegate:nil];
	if (!ret) {
		NSLog(@"manager start failed!");
	}
}



#pragma mark - openShare
- (void)openShare { 

	//设置友盟社会化组件appkey
	[UMSocialData setAppKey:@"507fcab25270157b37000010"];

	//	// 友盟登录
	//	//设置微信AppId、appSecret，分享url
	[UMSocialWechatHandler setWXAppId:@"wx389fd46f8f3efc9b" appSecret:@"5e5af6ef209dc67175910eb4affa5b16" url:@"http://www.jadechina.cn/"];

	// openShare 分享
	[OpenShare connectQQWithAppId:@"1105405877"];
	[OpenShare connectWeiboWithAppKey:@"4224982908"];
	[OpenShare connectWeixinWithAppId:@"wx389fd46f8f3efc9b"];



	// 微信支付
	BOOL isOk = [WXApi registerApp:@"wx389fd46f8f3efc9b" withDescription:@"demo 2.0"];
	if (isOk)
	{
		NSLog(@"注册微信成功");
	}
	else
	{
		NSLog(@"注册微信失败");
	}



	//设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
//	[UMSocialQQHandler setQQWithAppId:@"1105405877" appKey:@"GCEJJkMR9LPAIw7B" url:@"https://www.baidu.com/"];
//	//打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
//	[UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"4224982908"
//											  secret:@"5e7ca3d5a79d1ff7aae704d12916e02e"
//										 RedirectURL:@"https://www.baidu.com/"];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{

	BOOL result = [UMSocialSnsService handleOpenURL:url];
	if(!result){
		//处理其他openrul
		//	第二步：添加回调
		[OpenShare handleOpenURL:url];

		//这里可以写上其他OpenShare不支持的客户端的回调，比如支付宝等。
		[WXApi handleOpenURL:url delegate:self];
	}
	return YES;
}

/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
	[UMSocialSnsService  applicationDidBecomeActive];
}


#pragma mark - tabbarDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {

	if ([viewController isKindOfClass:[UINavigationController class]]) {

		[(UINavigationController *)viewController popToRootViewControllerAnimated:YES];
		
	}

	if (tabBarController.selectedIndex == 0 || tabBarController.selectedIndex == 3 || tabBarController.selectedIndex == 1) {
		[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
	}
	
//	[[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"Register"];
	// 判断是否登录
	if (tabBarController.selectedIndex == 3) {
		
		if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Register"] isEqual:@1]) {
			// 已登录

		} else {
			// 未登录
			RegisterVC *registerVC = [[RegisterVC alloc] init];
			UINavigationController *registerNaVC = [[UINavigationController alloc] initWithRootViewController:registerVC];
			[[NetWorkingTool getCurrentVC] presentViewController:registerNaVC animated:YES completion:nil];
		}
	}
}

- (void)autoLogin {
	if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Register"] isEqual:@1]) {

		NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"]);
		__block NSMutableDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
		NSString *MD5Info = [NSString stringWithFormat:@"ER21Ha26jIu89SHI02sa45Shou11MEI%@%@%@", userInfo[@"phone"], userInfo[@"user_id"], userInfo[@"auto_code"]];

		// 自动登录
		[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/mobileAutoLogin.php" params:@{@"auto_code" : [MD5Info stringFromMD5Lowercase]} Success:^(id responseObject) {

			NSLog(@"%@", responseObject);
			if ([responseObject[@"status"] isEqual:@0]) {
				[[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"Register"];
				[[NSUserDefaults standardUserDefaults] synchronize];
			} else {
				if (responseObject[@"auto_code"] == nil) {

					NSDictionary *dic = @{@"phone" : userInfo[@"phone"], @"user_id" : userInfo[@"user_id"], @"auto_code" : userInfo[@"auto_code"]};
					[[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"userInfo"];
					[[NSUserDefaults standardUserDefaults] synchronize];
				} else {

					NSDictionary *dic = @{@"phone" : userInfo[@"phone"], @"user_id" : userInfo[@"user_id"], @"auto_code" : responseObject[@"auto_code"]};
					[[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"userInfo"];
					[[NSUserDefaults standardUserDefaults] synchronize];
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
}



#pragma mark - startLeadScroll
- (void)startLeadScroll {
	UIViewController *activeVC = [[UIViewController alloc] init];
	self.window.rootViewController = activeVC;

	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
	scrollView.contentSize = CGSizeMake(WIDTH * 3, 0);
	scrollView.delegate = self;
	scrollView.pagingEnabled = YES;
	[activeVC.view addSubview:scrollView];

	UIImageView *oneImageViwe = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"引导页1.jpg"]];
	oneImageViwe.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
	[scrollView addSubview:oneImageViwe];

	UIImageView *twoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"引导页2.jpg"]];
	twoImageView.frame = CGRectMake(WIDTH, 0, WIDTH, HEIGHT);
	[scrollView addSubview:twoImageView];

	UIImageView *threeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"引导页3.jpg"]];
	threeImageView.frame = CGRectMake(WIDTH * 2, 0, WIDTH, HEIGHT);
	[scrollView addSubview:threeImageView];

	self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(WIDTH / 3, HEIGHT - UNITHEIGHT * 30, WIDTH / 3, UNITHEIGHT * 20)];
	_page.numberOfPages = 3;
	_page.currentPage = 0;
	_page.currentPageIndicatorTintColor = [UIColor whiteColor];
	_page.pageIndicatorTintColor = [UIColor colorWithRed:109 / 255.0 green:109 / 255.0 blue:109 / 255.0 alpha:1];
	_page.backgroundColor = [UIColor clearColor];
	[activeVC.view addSubview:_page];

	// 隐藏状态栏
	[[UIApplication sharedApplication] setStatusBarHidden:TRUE];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if (scrollView.contentOffset.x > WIDTH * 2 + 20) {
		sleep(0.5);
		self.window.rootViewController = _tab;
		// 隐藏状态栏
		[[UIApplication sharedApplication] setStatusBarHidden:false];
	}
	_page.currentPage = scrollView.contentOffset.x / WIDTH;
}



#warning 支付结果
- (void)onResp:(BaseResp *)resp {
	NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
	NSString *strTitle;
	if([resp isKindOfClass:[SendMessageToWXResp class]])
	{
		strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
	}
	if([resp isKindOfClass:[PayResp class]]){
#warning 4.支付返回结果，实际支付结果需要去自己的服务器端查询  由于demo的局限性这里直接使用返回的结果
		strTitle = [NSString stringWithFormat:@"支付结果"];
		// 返回码参考：https://pay.weixin.qq.com/wiki/doc/api/app.php?chapter=9_12
		switch (resp.errCode) {
			case WXSuccess:{
				strMsg = @"支付结果：成功！";
				NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
				NSNotification *notification = [NSNotification notificationWithName:@"ORDER_PAY_NOTIFICATION" object:@"success"];
				[[NSNotificationCenter defaultCenter] postNotification:notification];
				break;
			}
			default:{
				strMsg = [NSString stringWithFormat:@"支付结果：失败！"];
//				strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
				NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
				NSNotification *notification = [NSNotification notificationWithName:@"ORDER_PAY_NOTIFICATION"object:@"fail"];
				[[NSNotificationCenter defaultCenter] postNotification:notification];
				break;
			}
		}
	}
//	UIAlertController *alert = [UIAlertController alertControllerWithTitle:strTitle message:strMsg preferredStyle:UIAlertControllerStyleAlert];
//	UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//		NSLog(@"知道了");
//	}];
//	[alert addAction:action];
//	[self.window.rootViewController presentViewController:alert animated:YES completion:nil];
	NSLog(@"title = %@ message = %@", strTitle, strMsg);
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
