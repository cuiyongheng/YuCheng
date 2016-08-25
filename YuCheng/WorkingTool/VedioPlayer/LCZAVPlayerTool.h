//
//  LCZAVPlayerTool.h
//  AVPlayerDemo
//
//  Created by Golibyo on 15/12/9.
//  Copyright © 2015年 changshuhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
@interface LCZAVPlayerTool : UIView
#warning 功能太多没都加=. =
+ (instancetype)shareSingleton;
@property(nonatomic, strong)AVPlayer *player;// 播放器对象
@property(nonatomic, strong)AVPlayerItem *playerItem;// 播放属性
//@property(nonatomic, strong)UISlider *slider;// 进度条
//@property(nonatomic, strong)UILabel *currentTimeLabel;// 当前播放时间
//@property(nonatomic, strong)UILabel *systemTimeLabel;// 系统时间
@property(nonatomic, assign)CGPoint startPoint;
@property(nonatomic, assign)CGFloat systemVolume;//系统音量
@property(nonatomic, strong)UISlider *volumeViewSlider;
@property(nonatomic, strong)UIActivityIndicatorView *activity;// 系统菊花
//@property(nonatomic, strong)UIProgressView *progress;// 缓冲条
//@property(nonatomic, strong)UIView *topView;//承载上部视图的view
//@property(nonatomic, strong)UIView *bottomView;//承载下部视图的view
@property(nonatomic, strong)AVPlayerLayer *playerLayer;//avplayer的layer层
//创建一个avplayer播放器
- (void)creatAVplayer:(NSString *)url;
//改变播放器的大小
- (void)changeFrame:(CGRect)rect;
//改变播放的视频网址
- (void)changeUrl:(NSString *)url;

@end
