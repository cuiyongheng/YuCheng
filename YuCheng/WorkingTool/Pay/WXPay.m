//
//  WXPay.m
//  YuCheng
//
//  Created by apple on 16/8/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WXPay.h"

@implementation WXPay

+ (void)WXPay:(NSDictionary *)dict Success:(payBlock)success {

	if(dict != nil){
		NSMutableString *retcode = [dict objectForKey:@"retcode"];
		if (retcode.intValue == 0){
			NSMutableString *stamp  = [dict objectForKey:@"timestamp"];

			NSLog(@"服务器输出%@", dict);
			//调起微信支付
			PayReq* req             = [[PayReq alloc] init];
			req.partnerId           = [dict objectForKey:@"partnerid"];
			req.prepayId            = [dict objectForKey:@"prepayid"];
			req.nonceStr            = [dict objectForKey:@"noncestr"];
			req.timeStamp           = stamp.intValue;
			req.package             = [dict objectForKey:@"package"];
			req.sign                = [dict objectForKey:@"sign"];

			if ([WXApi sendReq:req])
			{
				NSLog(@"调起成功!!!!");
			}
			else
			{
				NSLog(@"调起失败!!!");
			}

			//日志输出
			NSLog(@"appid=%@\npartnerId=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign);
			//					return @"";
			success();
		}else{
			//					return [dict objectForKey:@"retmsg"];
			NSLog(@"%@", [dict objectForKey:@"retmsg"]);
		}
	}else{
		//				return @"服务器返回错误，未获取到json对象";
		NSLog(@"服务器返回错误，未获取到json对象");
	}


}

@end
