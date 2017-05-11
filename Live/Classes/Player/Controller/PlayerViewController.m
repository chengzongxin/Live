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

@interface PlayerViewController ()<PortraitViewDelegate,LandScapeViewDelegate>{
}

@property (nonatomic,retain) PortraitView *portraitView;

@property (nonatomic,retain) LandScapeView *landScapeView;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden  = YES;
    
    [self.view addSubview:self.portraitView];
    
    [self listeningNoticefication];
}

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
    }
    return _landScapeView;
}

#pragma mark - portraitView代理方法

- (void)portraitViewDidClickBackBtn:(PortraitView *)portControlView
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
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
    [self.view layoutIfNeeded];
}

- (void)setOrientationLandscape{
    [self.portraitView removeFromSuperview];
    self.portraitView = nil;
    [self.view addSubview:self.landScapeView];
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
