//
//  RegisterInfo.h
//  YuCheng
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterInfo : NSObject

@property (nonatomic, strong) UMSocialResponseEntity *singletonResponse;

@property (nonatomic, strong) UMSocialAccountEntity *singletonsnsAccount;

+ (instancetype)shareSingleton;

@end
