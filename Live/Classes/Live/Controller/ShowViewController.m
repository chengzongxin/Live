//
//  ShowViewController.m
//  Live
//
//  Created by Cheng on 2017/5/17.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "ShowViewController.h"
#import <IJKMediaFrameworkWithSSL/IJKMediaFrameworkWithSSL.h>

@interface ShowViewController ()
{}
@property (nonatomic,retain) IJKFFMoviePlayerController *player;

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
}


- (void)playerWithURLString:(NSString *)urlString{
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:1  forKey:@"videotoolbox"];
    
    // 帧速率(fps) （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）
    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
    // -vol——设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    IJKFFMoviePlayerController *moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:urlString withOptions:options];
    
    [IJKFFMoviePlayerController setLogReport:YES];
    
    [IJKFFMoviePlayerController setLogLevel:k_IJK_LOG_WARN];
    
    [moviePlayer setOptionValue:@"0" forKey:@"safe" ofCategory:kIJKFFOptionCategoryFormat];
    
    [moviePlayer setOptionValue:@"http,https,tls,rtp,tcp,udp,crypto,httpproxy,rtmp" forKey:@"protocol_whitelist" ofCategory:kIJKFFOptionCategoryFormat];
    
    //    [moviePlayer setOptionValue:@"ijkplayer" forKey:@"user_agent" ofCategory:kIJKFFOptionCategoryFormat];
    
    moviePlayer.view.frame = self.view.frame;
    // 填充fill
    moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    // 设置自动播放(必须设置为NO, 防止自动播放, 才能更好的控制直播的状态)
    moviePlayer.shouldAutoplay = NO;
    // 默认不显示
    moviePlayer.shouldShowHudView = NO;
    
    [self.view insertSubview:moviePlayer.view atIndex:0];
    
    [moviePlayer prepareToPlay];
    
    self.player = moviePlayer;
    
    [self initObserver];
}

- (void)initObserver
{
    // 监听视频是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishPlay) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.player];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.player];
}
- (IBAction)clickClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - notify method

- (void)stateDidChange
{
    if ((self.player.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if (!self.player.isPlaying) {
            [self.player play];
        }else{
            // 如果是网络状态不好, 断开后恢复, 也需要去掉加载
        }
    }else if (self.player.loadState & IJKMPMovieLoadStateStalled){ // 网速不佳, 自动暂停状态
        
    }
}

- (void)didFinishPlay
{
    NSLog(@"加载状态...%ld %ld %s", self.player.loadState, self.player.playbackState, __func__);
    // 因为网速或者其他原因导致直播stop了, 也要显示GIF
    if (self.player.loadState & IJKMPMovieLoadStateStalled) {
        return;
    }
    //    方法：
    //      1、重新获取直播地址，服务端控制是否有地址返回。
    //      2、用户http请求该地址，若请求成功表示直播未结束，否则结束
}

- (void)dealloc
{
    if (_player) {
        [_player shutdown];
        [_player.view removeFromSuperview];
        _player = nil;
    }
}

- (void)setLive_stream_url:(NSString *)live_stream_url{
    [self playerWithURLString:live_stream_url];
}
@end
