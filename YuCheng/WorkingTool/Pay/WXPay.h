//
//  WXPay.h
//  YuCheng
//
//  Created by apple on 16/8/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^payBlock)(void);

@interface WXPay : NSObject

/**
 *  微信支付
 *
 *  @param dict    微信支付需要的订单参数
 *  @param success 成功返回Block
 */
+ (void)WXPay:(NSDictionary *)dict Success:(payBlock)success;

@end
