//
//  LCZAVPlayerTool.m
//  AVPlayerDemo
//
//  Created by Golibyo on 15/12/9.
//  Copyright © 2015年 changshuhua. All rights reserved.
//

#import "LCZAVPlayerTool.h"

@implementation LCZAVPlayerTool

+ (instancetype)shareSingleton {
    static LCZAVPlayerTool *singleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[LCZAVPlayerTool alloc] init];
    });
    return singleton;
}



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)changeFrame:(CGRect)rects {
    self.playerLayer.frame = CGRectMake(0, UNITHEIGHT * 20, rects.size.width, rects.size.height);
//    self.topView.frame = CGRectMake(0, 0, rects.size.width, rects.size.height * 0.15);
//    self.bottomView.frame = CGRectMake(0, rects.size.height * 0.85, rects.size.width, rects.size.height * 0.15);
//    self.progress.frame = CGRectMake(rects.size.width / 375.0 * 20, self.bottomView.frame.size.height / 2.0, rects.size.width * 0.65, rects.size.height / 25.0 * 1);
//    self.slider.frame = CGRectMake(rects.size.width / 375.0 * 18, self.bottomView.frame.size.height / 2.5, rects.size.width * 0.69, rects.size.height / 250.0 * 10);
//    self.currentTimeLabel.frame = CGRectMake(rects.size.width * 0.75, rects.size.height / 250.0 * 220, rects.size.width / 375.0 * 100, rects.size.height / 250.0 * 20);
}

- (void)changeUrl:(NSString *)url {
    self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:url]];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _playerLayer.videoGravity = AVLayerVideoGravityResize;
    [self.layer addSublayer:_playerLayer];
}

- (void)creatAVplayer:(NSString *)url
{
    self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:url]];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _playerLayer.videoGravity = AVLayerVideoGravityResize;
    [self.layer addSublayer:_playerLayer];
//    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 0.15)];
//    self.topView.backgroundColor = [UIColor blackColor];
//    self.topView.alpha = 0.5;
//    [self addSubview:self.topView];
//    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height * 0.85, self.frame.size.width, self.frame.size.height * 0.15)];
//    self.bottomView.backgroundColor = [UIColor blackColor];
//    self.bottomView.alpha = 0.5;
//    [self addSubview:self.bottomView];
//    //        创建progress缓冲条
//    self.progress = [[UIProgressView alloc] initWithFrame:CGRectMake(self.frame.size.width / 375.0 * 47, self.bottomView.frame.size.height / 2.0, self.frame.size.width * 0.65, self.frame.size.height / 25.0 * 1)];
//    [self.bottomView addSubview:self.progress];
//    //        创建进度条
//    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(self.frame.size.width / 375.0 * 45, self.bottomView.frame.size.height / 2.4, self.frame.size.width * 0.69, self.frame.size.height / 250.0 * 10)];
//    [self.bottomView addSubview:self.slider];
//    [self.slider setThumbImage:[UIImage imageNamed:@"iconfont-yuan.png"] forState:UIControlStateNormal];
//    [self.slider addTarget:self action:@selector(progressSlider:) forControlEvents:UIControlEventValueChanged];
//    self.slider.minimumTrackTintColor = [UIColor colorWithRed:30 / 255.0 green:80 / 255.0 blue:100 / 255.0 alpha:1];
//    self.currentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.85, self.frame.size.height / 250.0 * 220, self.frame.size.width / 375.0 * 100, self.frame.size.height / 250.0 * 20)];
//    [self addSubview:self.currentTimeLabel];
//    self.currentTimeLabel.font = [UIFont systemFontOfSize:12];
//    self.currentTimeLabel.text = @"00:00/00:00";
//    self.currentTimeLabel.textColor = [UIColor whiteColor];

    //        创建手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    
    
    
    //获取系统音量
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    _volumeViewSlider = nil;
    for (UIView *view in [volumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            _volumeViewSlider = (UISlider *)view;
            break;
        }
    }
    _systemVolume = _volumeViewSlider.value;
//    视图虚化功能,没啥用
//    UIGraphicsBeginImageContextWithOptions((CGSize){ 1, 1 }, NO, 0.0f);
//    UIImage *transparentImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [self.slider setMaximumTrackImage:transparentImage forState:UIControlStateNormal];

    
    //        播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
    
    //    监听loadedTimeRanges属性
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    //计时器
    [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(Stack) userInfo:nil repeats:YES];
    
}

#pragma mark - 滑动调整音量大小
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(event.allTouches.count == 1){
        //保存当前触摸的位置
        CGPoint point = [[touches anyObject] locationInView:self];
        _startPoint = point;
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if(event.allTouches.count == 1){
        //计算位移
        CGPoint point = [[touches anyObject] locationInView:self];
        float dy = point.y - _startPoint.y;
        int index = (int)dy;
        if(index>0){
            if(index%5==0){//每10个像素声音减一格
                NSLog(@"%.2f",_systemVolume);
                if(_systemVolume>0.1){
                    _systemVolume = _systemVolume-0.05;
                    [_volumeViewSlider setValue:_systemVolume animated:YES];
                    [_volumeViewSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
                }
            }
        }else{
            if(index%5==0){//每10个像素声音增加一格
                NSLog(@"+x ==%d",index);
                NSLog(@"%.2f",_systemVolume);
                if(_systemVolume>=0 && _systemVolume<1){
                    _systemVolume = _systemVolume+0.05;
                    [_volumeViewSlider setValue:_systemVolume animated:YES];
                    [_volumeViewSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
                }
            }
        }

    }
}


- (void)Stack
{
    if (_playerItem.duration.timescale != 0) {
        
//        _slider.maximumValue = 1;//音乐总共时长
//        _slider.value = CMTimeGetSeconds([_playerItem currentTime]) / (_playerItem.duration.value / _playerItem.duration.timescale);//当前进度

        //当前时长进度progress
//        NSInteger proMin = (NSInteger)CMTimeGetSeconds([_player currentTime]) / 60;//当前秒
//        NSInteger proSec = (NSInteger)CMTimeGetSeconds([_player currentTime]) % 60;//当前分钟
        //    NSLog(@"%d",_playerItem.duration.timescale);
        //    NSLog(@"%lld",_playerItem.duration.value/1000 / 60);
        
        //duration 总时长
        
//        NSInteger durMin = (NSInteger)_playerItem.duration.value / _playerItem.duration.timescale / 60;//总秒
//        NSInteger durSec = (NSInteger)_playerItem.duration.value / _playerItem.duration.timescale % 60;//总分钟
//        self.currentTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld / %02ld:%02ld", proMin, proSec, durMin, durSec];
    }
    if (_player.status == AVPlayerStatusReadyToPlay) {
        [_activity stopAnimating];
    } else {
        [_activity startAnimating];
    }
    
}



- (void)tapAction:(UITapGestureRecognizer *)tap
{
//    if ( self.topView.alpha == 0.5) {
//        [UIView animateWithDuration:0.5 animations:^{
//            
//            self.topView.alpha = 0;
//            self.bottomView.alpha = 0;
//        }];
//    } else if (self.topView.alpha == 0){
//        [UIView animateWithDuration:0.5 animations:^{
//            
//            self.topView.alpha = 0.5;
//            self.bottomView.alpha = 0.5;
//        }];
//    }
//    if (self.topView.alpha == 0.5) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
//            [UIView animateWithDuration:0.5 animations:^{
//                
//                self.topView.alpha = 0;
//                self.bottomView.alpha = 0;
//            }];
//            
//        });
//        
//    }
}

- (void)progressSlider:(UISlider *)slider {
    //    拖动改变视频播放进度
    if (self.player.status == AVPlayerStatusReadyToPlay) {
        //        计算出拖动的当前秒数
        CGFloat total = (CGFloat)self.playerItem.duration.value / self.playerItem.duration.timescale;
        NSInteger dragedSeconds = floorf(total * slider.value);
        //        转换成CMTime才能给player来控制播放进度
        CMTime dragedCMTime = CMTimeMake(dragedSeconds, 1);
        [self.player pause];
        [self.player seekToTime:dragedCMTime completionHandler:^(BOOL finished) {
            [self.player play];
        }];
    }
}



- (void)moviePlayDidEnd:(id)sender
{
    //    播放停止并把自己从父视图上移除
    //    [_player pause];
    //    [self removeFromSuperview];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
//		NSTimeInterval timeInterval = [self availableDuration];//计算缓冲进度
//        CMTime duration = self.playerItem.duration;
//        CGFloat totalDuration = CMTimeGetSeconds(duration);
//        [self.progress setProgress:timeInterval / totalDuration animated:NO];
    }
}

- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[self.player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;//计算缓冲总进度
    return result;
}



@end
