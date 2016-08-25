//
//  JustStartTimeView.m
//  ChekeBank
//
//  Created by apple on 16/2/29.
//  Copyright © 2016年 刘德刚. All rights reserved.
//

#import "JustStartTimeView.h"

@implementation JustStartTimeView
{
	dispatch_source_t _timer;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
	self = [super init];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	// 天
	self.dayLabel = [[UILabel alloc] init];
	_dayLabel.textAlignment = NSTextAlignmentCenter;
	_dayLabel.textColor = [UIColor blackColor];
	_dayLabel.font = font(11);
	_dayLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
	[self addSubview:_dayLabel];


	// 小时
	self.hourLabel = [[UILabel alloc] init];
	_hourLabel.textAlignment = NSTextAlignmentCenter;
	_hourLabel.textColor = [UIColor blackColor];
	_hourLabel.font = font(11);
	_hourLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
	[self addSubview:_hourLabel];

	[_hourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(self.mas_centerX);
		make.width.and.top.and.height.mas_equalTo(_dayLabel);
	}];

	[_dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(_hourLabel.mas_left);
		make.top.mas_equalTo(self).with.offset(UNITHEIGHT * 5);
		make.bottom.mas_equalTo(self).with.offset(-UNITHEIGHT * 5);
	}];

	// 分
	self.minuteLabel = [[UILabel alloc] init];
	_minuteLabel.textAlignment = NSTextAlignmentCenter;
	_minuteLabel.textColor = [UIColor blackColor];
	_minuteLabel.font = font(11);
	_minuteLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
	[self addSubview:_minuteLabel];

	[_minuteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_hourLabel.mas_right);
		make.width.and.top.and.height.mas_equalTo(_dayLabel);
	}];

	// 秒
	self.secondLabel = [[UILabel alloc] init];
	_secondLabel.textColor = [UIColor blackColor];
	_secondLabel.textAlignment = NSTextAlignmentCenter;
	_secondLabel.font = font(11);
	_secondLabel.textColor = [UIColor colorWithHexString:@"#792b34"];
	[self addSubview:_secondLabel];

	[_secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_minuteLabel.mas_right);
		make.width.and.top.and.height.mas_equalTo(_dayLabel);
	}];
}



/**
 *  根据指定时间间隔开始倒计时
 */
- (void)fireWithTimeIntervar:(NSTimeInterval)timerInterval
{
	if (_timer == nil) {
		__block int timeout = timerInterval; //倒计时时间

		if (timeout != 0) {
			dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
			_timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
			dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0); //每秒执行
			dispatch_source_set_event_handler(_timer, ^{
				if(timeout <= 0){ //倒计时结束，关闭
					dispatch_source_cancel(_timer);
					_timer = nil;
					dispatch_async(dispatch_get_main_queue(), ^{
						self.dayLabel.text = @"00天";
						self.hourLabel.text = @"00时";
						self.minuteLabel.text = @"00分";
						self.secondLabel.text = @"00秒";
					});
					// 结束的回调
					if (_TimerComplete) {
						_TimerComplete();
					}
				}else{
					int days = (int)(timeout / (3600 * 24));
					int hours = (int)((timeout - days * 24 * 3600) / 3600);
					int minute = (int)(timeout - days * 24 * 3600 - hours * 3600) / 60;
					int second = timeout - days * 24 * 3600 - hours * 3600 - minute * 60;
					dispatch_async(dispatch_get_main_queue(), ^{
						if (days == 0) {
							self.dayLabel.text = @"00天";
						}else {
							self.dayLabel.text = [NSString stringWithFormat:@"%d天",days];
						}
						if (hours < 10) {
							self.hourLabel.text = [NSString stringWithFormat:@"0%d时",hours];
						}else {
							self.hourLabel.text = [NSString stringWithFormat:@"%d时",hours];
						}
						if (minute < 10) {
							self.minuteLabel.text = [NSString stringWithFormat:@"0%d分",minute];
						}else{
							self.minuteLabel.text = [NSString stringWithFormat:@"%d分",minute];
						}
						if (second < 10) {
							self.secondLabel.text = [NSString stringWithFormat:@"0%d秒",second];
						}else {
							self.secondLabel.text = [NSString stringWithFormat:@"%d秒",second];
						}
					});
					timeout--;
				}
			});
			dispatch_resume(_timer);
		}
	}
}

#pragma mark 根据NSString格式的结束时间倒计时
- (void)countDownViewWithEndString:(NSString *)endStr
{
	NSDate *now = [NSDate date];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.dateFormat = @"yyyy-MM-dd";
	NSDate *endDate = [formatter dateFromString:endStr];
	NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:now];

	[self fireWithTimeIntervar:timeInterval];
}

#pragma mark 根据NSDate格式的结束时间倒计时
- (void)countDownViewWithEndData:(NSDate *)endDate
{
	NSDate *now = [NSDate date];
	NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:now];

	[self fireWithTimeIntervar:timeInterval];
}




@end
