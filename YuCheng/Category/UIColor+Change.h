//
//  UIColor+Change.h
//  YuCheng
//
//  Created by apple on 16/5/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Change)

/**
 *  16进制转换
 *
 *  @param color 16进制
 *
 *  @return UIColor
 */
+ (UIColor *) colorWithHexString: (NSString *)color;

@end
