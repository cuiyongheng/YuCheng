//
//  RegosterAlert.h
//  ChekeBank
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 刘德刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegosterAlert : NSObject

// 登录提示框
//+ (void)showRegisterAlert;

/**
 *  提示框
 *
 *  @param title 标题
 *  @param err   错误信息
 */
+ (void)showAlert:(NSString *)title err:(NSString *)err;

@end
