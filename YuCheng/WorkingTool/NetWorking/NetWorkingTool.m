//
//  NetWorkingTool.m
//  YuCheng
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NetWorkingTool.h"

@implementation NetWorkingTool

+ (void)GetNetWorking:(NSString *)URL Params:(id)params Success:(requestsuccessBlock)successBlock Failed:(requestFailedBlock)failedBlock {

	// 缓冲
	[MBProgressHUDManager showHUDtoView:[self getCurrentVC].view labelText:nil];
//	[MBProgressHUDManager showGifHUDtoView:[self getCurrentVC].view withGifArr:nil gifSize:CGSizeMake(UNITHEIGHT * 50, UNITHEIGHT * 50) animationDuration:2 labelText:nil];

    // 网络不可用
    if (![self checkNetworkStatus]) {
        successBlock(nil);
        failedBlock(nil);
//		[MBProgressHUDManager removeHUD];
        return;
    }



	// 寻找URL为HOST的相关cookie，不用担心，步骤2已经自动为cookie设置好了相关的URL信息
	NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:API_BASE_URL]]; // 这里的HOST是你web服务器的域名地址
	// 比如你之前登录的网站地址是abc.com（当然前面要加http://，如果你服务器需要端口号也可以加上端口号），那么这里的HOST就是http://abc.com

	// 设置header，通过遍历cookies来一个一个的设置header
	for (NSHTTPCookie *cookie in cookies){

		// cookiesWithResponseHeaderFields方法，需要为URL设置一个cookie为NSDictionary类型的header，注意NSDictionary里面的forKey需要是@"Set-Cookie"
		NSArray *headeringCookie = [NSHTTPCookie cookiesWithResponseHeaderFields:
									[NSDictionary dictionaryWithObject:
									 [[NSString alloc] initWithFormat:@"%@=%@",[cookie name],[cookie value]]
																forKey:@"Set-Cookie"]
																		  forURL:[NSURL URLWithString:API_BASE_URL]];

		// 通过setCookies方法，完成设置，这样只要一访问URL为HOST的网页时，会自动附带上设置好的header
		[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:headeringCookie
														   forURL:[NSURL URLWithString:API_BASE_URL]
												  mainDocumentURL:nil];

	}



    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 响应数据支持的类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    // 请求超时设定
    manager.requestSerializer.timeoutInterval = 10;
    
    [manager GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        NSLog(@"%@", downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
		[MBProgressHUDManager removeHUD];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failedBlock(error);
		[MBProgressHUDManager removeHUD];
    }];
}

+ (void)PostNetWorking:(NSString *)URL params:(id)params Success:(requestsuccessBlock)successBlock Failed:(requestFailedBlock)failedBlock {

	// 缓冲
	[MBProgressHUDManager showHUDtoView:[self getCurrentVC].view labelText:nil];

    // 网络不可用
    if (![self checkNetworkStatus]) {
        successBlock(nil);
        failedBlock(nil);
//		[MBProgressHUDManager removeHUD];
        return;
    }



//	// 寻找URL为HOST的相关cookie，不用担心，步骤2已经自动为cookie设置好了相关的URL信息
//	NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:API_BASE_URL]]; // 这里的HOST是你web服务器的域名地址
//	// 比如你之前登录的网站地址是abc.com（当然前面要加http://，如果你服务器需要端口号也可以加上端口号），那么这里的HOST就是http://abc.com
//
//	// 设置header，通过遍历cookies来一个一个的设置header
//	for (NSHTTPCookie *cookie in cookies){
//		// cookiesWithResponseHeaderFields方法，需要为URL设置一个cookie为NSDictionary类型的header，注意NSDictionary里面的forKey需要是@"Set-Cookie"
//		NSArray *headeringCookie = [NSHTTPCookie cookiesWithResponseHeaderFields:
//									[NSDictionary dictionaryWithObject:
//									 [[NSString alloc] initWithFormat:@"%@=%@",[cookie name],[cookie value]]
//																forKey:@"Set-Cookie"]
//																		  forURL:[NSURL URLWithString:API_BASE_URL]];
//		NSLog(@"%@", cookie);
//		// 通过setCookies方法，完成设置，这样只要一访问URL为HOST的网页时，会自动附带上设置好的header
//		[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:headeringCookie
//														   forURL:[NSURL URLWithString:API_BASE_URL]
//												  mainDocumentURL:nil];
//	}

	if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Register"] isEqual:@1]) {
		// 已登录
		NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:[[NSUserDefaults standardUserDefaults] objectForKey:@"cookie"]];

		[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
	} else {
		NSURL *url = [NSURL URLWithString:API_BASE_URL];
		if (url) {
			NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
			for (int i = 0; i < [cookies count]; i++) {
				NSHTTPCookie *cookie = (NSHTTPCookie *)[cookies objectAtIndex:i];
				[[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
			}
		}
	}



    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 响应数据支持的类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
	
    // 请求超时设定
    manager.requestSerializer.timeoutInterval = 10;
    
    [manager POST:URL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
//        NSLog(@"%lld", uploadProgress.completedUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
		[MBProgressHUDManager removeHUD];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failedBlock(error);
		[MBProgressHUDManager removeHUD];
    }];
}



+ (void)OtherPostNetWorking:(NSString *)URL params:(id)params Success:(requestsuccessBlock)successBlock Failed:(requestFailedBlock)failedBlock {

	// 缓冲
	[MBProgressHUDManager showHUDtoView:[self getCurrentVC].view labelText:nil];

	// 网络不可用
	if (![self checkNetworkStatus]) {
		successBlock(nil);
		failedBlock(nil);
//		[MBProgressHUDManager removeHUD];
		return;
	}



	// 寻找URL为HOST的相关cookie，不用担心，步骤2已经自动为cookie设置好了相关的URL信息
	NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:API_BASE_URL]]; // 这里的HOST是你web服务器的域名地址
	// 比如你之前登录的网站地址是abc.com（当然前面要加http://，如果你服务器需要端口号也可以加上端口号），那么这里的HOST就是http://abc.com

	// 设置header，通过遍历cookies来一个一个的设置header
	for (NSHTTPCookie *cookie in cookies){

		// cookiesWithResponseHeaderFields方法，需要为URL设置一个cookie为NSDictionary类型的header，注意NSDictionary里面的forKey需要是@"Set-Cookie"
		NSArray *headeringCookie = [NSHTTPCookie cookiesWithResponseHeaderFields:
									[NSDictionary dictionaryWithObject:
									 [[NSString alloc] initWithFormat:@"%@=%@",[cookie name],[cookie value]]
																forKey:@"Set-Cookie"]
																		  forURL:[NSURL URLWithString:API_BASE_URL]];

		// 通过setCookies方法，完成设置，这样只要一访问URL为HOST的网页时，会自动附带上设置好的header
		[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:headeringCookie
														   forURL:[NSURL URLWithString:API_BASE_URL]
												  mainDocumentURL:nil];
	}



	//增加这几行代码；
	AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
	[securityPolicy setAllowInvalidCertificates:YES];



	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	// 响应数据支持的类型
	manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
	// 请求超时设定
	manager.requestSerializer.timeoutInterval = 10;



	[manager setSecurityPolicy:securityPolicy];
	manager.responseSerializer = [AFHTTPResponseSerializer serializer];



	[manager POST:URL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
		//        NSLog(@"%lld", uploadProgress.completedUnitCount);
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		successBlock(responseObject);
		[MBProgressHUDManager removeHUD];
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		failedBlock(error);
		[MBProgressHUDManager removeHUD];
	}];
}




#pragma mark - chectNetworkStatus
+ (BOOL)checkNetworkStatus {
    __block BOOL isNetworkUse = YES;
    // 网络状态管理类
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        // 未知网络
        if (status == AFNetworkReachabilityStatusUnknown) {
            isNetworkUse = YES;
            // Wifi
        } else if (status ==AFNetworkReachabilityStatusReachableViaWiFi){
            isNetworkUse = YES;
            // WWAn
        } else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            isNetworkUse = YES;
            // 网络不可用
        } else if (status == AFNetworkReachabilityStatusNotReachable){
            // 网络异常操作
            isNetworkUse = NO;
            NSLog(@"网络异常,请检查网络是否可用！");
        }
    }];
    [reachabilityManager startMonitoring];
    return isNetworkUse;
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

- (void)uploadImg:(UIImage *)uploadImage URL:(NSString *)URL type:(NSNumber *)type Success:(requestsuccessBlock)successBlock
{

	//	    UIImage *img = uploadImage;


		// 压缩图片
		UIImage *img = [self imageWithImage:uploadImage scaledToSize:CGSizeMake(300, 300 * uploadImage.size.height / uploadImage.size.width)];

		//转换为ｐｎｇ格式
		NSData * imagedata = UIImagePNGRepresentation(img);
		//保存到本地沙盒
		NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask ,YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];

		NSLog(@"%@", documentsDirectory);
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
		NSString * upfile = [NSString stringWithFormat:@"%@.png", [formatter stringFromDate:[NSDate date]]];
		NSString * savedImagePath = [documentsDirectory stringByAppendingPathComponent:upfile];

		//文件名
		[imagedata writeToFile:savedImagePath atomically:YES];



		AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
		// 响应数据支持的类型
		manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
		// 请求超时设定
		manager.requestSerializer.timeoutInterval = 10;



		// 寻找URL为HOST的相关cookie，不用担心，步骤2已经自动为cookie设置好了相关的URL信息
		NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:API_BASE_URL]]; // 这里的HOST是你web服务器的域名地址
		// 比如你之前登录的网站地址是abc.com（当然前面要加http://，如果你服务器需要端口号也可以加上端口号），那么这里的HOST就是http://abc.com

		// 设置header，通过遍历cookies来一个一个的设置header
		for (NSHTTPCookie *cookie in cookies){

			// cookiesWithResponseHeaderFields方法，需要为URL设置一个cookie为NSDictionary类型的header，注意NSDictionary里面的forKey需要是@"Set-Cookie"
			NSArray *headeringCookie = [NSHTTPCookie cookiesWithResponseHeaderFields:
										[NSDictionary dictionaryWithObject:
										 [[NSString alloc] initWithFormat:@"%@=%@",[cookie name],[cookie value]]
																	forKey:@"Set-Cookie"]
																			  forURL:[NSURL URLWithString:API_BASE_URL]];

			// 通过setCookies方法，完成设置，这样只要一访问URL为HOST的网页时，会自动附带上设置好的header
			[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:headeringCookie
															   forURL:[NSURL URLWithString:API_BASE_URL]
													  mainDocumentURL:nil];
		}

//		if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"outRegister"] isEqual:@1]) {
//			[manager.requestSerializer setValue:[NSString stringWithFormat:@"%@%@", COOKIE, [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"][@"session_id"]] forHTTPHeaderField:@"Cookie"];
//			NSLog(@"本地cookie%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"][@"session_id"]);
//		} else {
//			NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:URL]];
//			for (int i = 0; i < [cookies count]; i++) {
//				NSHTTPCookie *cookie = (NSHTTPCookie *)[cookies objectAtIndex:i];
//				[[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
//			}
//			NSLog(@"清除cookie");
//		}



		[manager POST:URL parameters:@{@"upfile" : upfile} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

			[formData appendPartWithFileData:imagedata name:@"file" fileName:upfile mimeType:@"image/png"];

		} progress:^(NSProgress * _Nonnull uploadProgress) {

		} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
			successBlock(responseObject);

		} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
			NSLog(@"%@", error);
		}];

}


#pragma mark - scaleImg
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
	// Create a graphics image context
	UIGraphicsBeginImageContext(newSize);

	// Tell the old image to draw in this new context, with the desired
	// new size
	[image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];

	// Get the new image from the context
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

	// End the context
	UIGraphicsEndImageContext();
	
	// Return the new image.
	return newImage;
}


@end
