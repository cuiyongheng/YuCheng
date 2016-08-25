//
//  RegosterAlert.m
//  ChekeBank
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 刘德刚. All rights reserved.
//

#import "RegosterAlert.h"

@implementation RegosterAlert

//+ (void)showRegisterAlert {
//	// 登录提示框
//	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
//	RegisterVC *registerVC = [[RegisterVC alloc] init];
//	UINavigationController *registerNaVC = [[UINavigationController alloc] initWithRootViewController:registerVC];
//
//	// 确定
//	UIAlertAction *tureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//		[[self getCurrentVC] presentViewController:registerNaVC animated:YES completion:^{
//
//		}];
//	}];
//	[alert addAction:tureAction];
//
//	[[self getCurrentVC] presentViewController:alert animated:YES completion:^{
//
//	}];
//
//}

+ (void)showAlert:(NSString *)title err:(NSString *)err {
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:err preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction *tureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		
	}];
	[alert addAction:tureAction];

	[[self getCurrentVC] presentViewController:alert animated:YES completion:^{
		
	}];
}



#pragma mark - 获取当前VC
+ (UIViewController *)getCurrentVC
{
	UIViewController *result = nil;
	UIWindow *window = [[UIApplication sharedApplication] keyWindow];
	if (window.windowLevel != UIWindowLevelNormal)
	{
		NSArray *windows = [[UIApplication sharedApplication] windows];
		for (UIWindow *tmpWindow in windows)
		{
			if (tmpWindow.windowLevel == UIWindowLevelNormal)
			{
				window = tmpWindow;
				break;
			}
		}
	}
	UIView *forntView = [[window subviews]objectAtIndex:0];
	id nextResponder = [forntView nextResponder];
	if ([nextResponder isKindOfClass:[UIViewController class]])
		result = nextResponder;
	else
		result = window.rootViewController;
	return result;
}

@end
