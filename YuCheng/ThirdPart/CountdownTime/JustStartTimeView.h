//
//  JustStartTimeView.h
//  ChekeBank
//
//  Created by apple on 16/2/29.
//  Copyright © 2016年 刘德刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JustStartTimeView : UIView

@property (nonatomic, strong) UILabel *dayLabel;// 天

@property (nonatomic, strong) UILabel *hourLabel;// 小时

@property (nonatomic, strong) UILabel *minuteLabel;// 分

@property (nonatomic, strong) UILabel *secondLabel;// 秒

// 倒计时结束回调
@property (nonatomic, copy) void (^TimerComplete)();

/**
 *  根据指定结束时间开始倒计时
 *
 *  @param endDate NSDate格式的结束时间
 */
- (void)countDownViewWithEndData:(NSDate *)endDate;

/**
 *  根据指定结束时间开始倒计时
 *
 *  @param endStr NSString格式的结束时间
 */
- (void)countDownViewWithEndString:(NSString *)endStr;

@end
