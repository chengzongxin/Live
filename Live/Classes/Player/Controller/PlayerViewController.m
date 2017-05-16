//
//  PlayerViewController.m
//  Live
//
//  Created by Cheng on 2017/5/11.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "PlayerViewController.h"
#import "PortraitView.h"
#import "LandScapeView.h"
#import <IJKMediaFrameworkWithSSL/IJKMediaFrameworkWithSSL.h>

@interface PlayerViewController ()<PortraitViewDelegate,LandScapeViewDelegate>{
}

@property (nonatomic,retain) UIView *blackCoverView;

@property (nonatomic,retain) PortraitView *portraitView;

@property (nonatomic,retain) LandScapeView *landScapeView;

@property (nonatomic,retain) IJKFFMoviePlayerController *player;

@end

@implementation PlayerViewController

- (PortraitView *)portraitView{
    if (!_portraitView) {
        _portraitView = [PortraitView portraitView];
        _portraitView.delegate = self;
    }
    return _portraitView;
}

- (LandScapeView *)landScapeView{
    if (!_landScapeView) {
        _landScapeView = [LandScapeView landScapeView];
        _landScapeView.delegate = self;
        _landScapeView.liveTitle.text = self.list.title;
    }
    return _landScapeView;
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
    
    [moviePlayer setOptionValue:@"http,https,tls,rtp,tcp,udp,crypto,httpproxy" forKey:@"protocol_whitelist" ofCategory:kIJKFFOptionCategoryFormat];
    
//    [moviePlayer setOptionValue:@"ijkplayer" forKey:@"user_agent" ofCategory:kIJKFFOptionCategoryFormat];

    moviePlayer.view.frame = self.portraitView.bounds;
    // 填充fill
    moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    // 设置自动播放(必须设置为NO, 防止自动播放, 才能更好的控制直播的状态)
    moviePlayer.shouldAutoplay = NO;
    // 默认不显示
    moviePlayer.shouldShowHudView = NO;
    
//    [self.portraitView insertSubview:moviePlayer.view atIndex:0];
    
    [self.portraitView addPlayerView:moviePlayer.view];
    
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


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden  = YES;
    
//    [self setupUI];
    
    [self.view addSubview:self.portraitView];
    
    [self listeningNoticefication];
}

//- (void)setupUI{
//    // 在顶部添加一个黑色的遮盖
//    UIView *blackCoverView = [[UIView alloc] init];
//    blackCoverView.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:blackCoverView];
//    self.blackCoverView = blackCoverView;
//    // 设置黑色遮盖view的约束
//    [self.blackCoverView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top);
//        make.left.equalTo(self.view.mas_left);
//        make.right.equalTo(self.view.mas_right);
//        make.height.offset(self.view.width * 9 / 16 + 20);
//    }];
//    
//    [self.blackCoverView addSubview:_portraitView];
//    
//    // 添加一个手势
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapControlView:)];
//    [self.blackCoverView addGestureRecognizer:tap];
//}

/**
 *  点击了控制view的遮盖view，用来显示和隐藏控制的view
 */
- (void)tapControlView:(UITapGestureRecognizer *)tapGest {
    MYLogFun;
}

- (void)viewWillAppear:(BOOL)animated{
    // 设置状态栏的样式
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    // 设置回状态栏的样式
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

#pragma mark - portraitView代理方法

- (void)portraitViewDidClickBackBtn:(PortraitView *)portControlView
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)portraitViewDidClickPauseBtn:(PortraitView *)portControlView
{
    if ([self.player isPlaying]) {
        [self.player pause];
    }else{
        [self.player play];
    }
}

/*
 *  全屏
 */
- (void)portraitView:(PortraitView *)portraitView setLandScape:(UIInterfaceOrientation)interfaceOrientation
{
    [self interfaceOrientation:interfaceOrientation];
}

/*
 *  竖屏
 */
- (void)landScapeView:(LandScapeView *)landScapeView setPortrait:(UIInterfaceOrientation)interfaceOrientation
{
    [self interfaceOrientation:interfaceOrientation];
}


#pragma mark - 设置强制屏幕转屏
/**
 *  强制屏幕转屏
 *
 *  @param orientation 屏幕方向
 */
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation {
    // arc下
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

#pragma mark - 监听方法
/**
 *  监听设备旋转通知
 */
- (void)listeningNoticefication {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOrientationChanged)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    
    // app退到后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground) name:UIApplicationWillResignActiveNotification object:nil];
    
    // app进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterPlayGround) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    
}

/**
 *  设置的方向改变了
 */
- (void)deviceOrientationChanged {
//    if (self.lockBtn.isSelected) {
//        return;
//    }
    UIDeviceOrientation orientation             = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortrait:{
            NSLog(@"竖屏");
            // 设置竖屏
            [self setOrientationPortrait];
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"横屏");
            // 设置横屏
            [self setOrientationLandscape];
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"横屏");
            // 设置横屏
            [self setOrientationLandscape];
        }
            break;
        default:
            break;
    }
}

- (void)setOrientationPortrait{
    [self.landScapeView removeFromSuperview];
    self.landScapeView = nil;
    [self.view addSubview:self.portraitView];
    self.player.view.frame = self.portraitView.frame;
    [self.portraitView addPlayerView:self.player.view];
    [self.view layoutIfNeeded];
}

- (void)setOrientationLandscape{
    [self.portraitView removeFromSuperview];
    self.portraitView = nil;
    self.player.view.frame = self.landScapeView.frame;
    [self.view addSubview:self.landScapeView];
    [self.landScapeView addPlayerView:self.player.view];
    [self.view layoutIfNeeded];
}

/**
 *  程序进入后台
 */
- (void)appDidEnterBackground {
//    [self.moviePlayer pause];
//    [self.portControlView setIsPlaying:NO];
//    [self.landScapeControlView setIsPlaying:NO];
}

/**
 *  程序进入前台
 */
- (void)appDidEnterPlayGround {
//    [self.moviePlayer play];
//    [self.portControlView setIsPlaying:YES];
//    [self.landScapeControlView setIsPlaying:YES];
}

@end
