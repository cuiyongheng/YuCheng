//
//  NetWorkingTool.h
//  YuCheng
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  请求成功Block
 *
 *  @param responseObject 请求成功数据
 */
typedef void(^requestsuccessBlock)(id responseObject);

/**
 *  请求失败Block
 *
 *  @param error 请求失败错误信息
 */
typedef void (^requestFailedBlock) (NSError *error);

@interface NetWorkingTool : NSObject

/**
 *  Get请求
 *
 *  @param URL          接口
 *  @param params       body
 *  @param successBlock 请求成功回调
 *  @param failedBlock  请求失败回调
 */
+ (void)GetNetWorking:(NSString *)URL
               Params:(id)params
              Success:(requestsuccessBlock)successBlock
               Failed:(requestFailedBlock)failedBlock;

/**
 *  Psot请求
 *
 *  @param URL          接口
 *  @param params       body
 *  @param successBlock 请求成功回调
 *  @param failedBlock  请求失败回调
 */
+ (void)PostNetWorking:(NSString *)URL
                params:(id)params
               Success:(requestsuccessBlock)successBlock
                Failed:(requestFailedBlock)failedBlock;


+ (void)OtherPostNetWorking:(NSString *)URL params:(id)params Success:(requestsuccessBlock)successBlock Failed:(requestFailedBlock)failedBlock
;


+ (UIViewController *)getCurrentVC;

- (void)uploadImg:(UIImage *)uploadImage URL:(NSString *)URL type:(NSNumber *)type Success:(requestsuccessBlock)successBlock;

@end
