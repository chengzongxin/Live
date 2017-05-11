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

@interface PlayerViewController ()<PortraitViewDelegate>{
}

@property (nonatomic,retain) PortraitView *portraitView;

@property (nonatomic,retain) LandScapeView *landScapeView;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden  = YES;
    
    self.portraitView.delegate = self;
    
    [self.view addSubview:self.portraitView];
}

- (PortraitView *)portraitView{
    if (!_portraitView) {
        _portraitView = [PortraitView portraitView];
    }
    return _portraitView;
}

- (LandScapeView *)landScapeView{
    if (!_landScapeView) {
        _landScapeView = [LandScapeView landScapeView];
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
/**
 *  全屏
 */
- (void)portraitView:(PortraitView *)portraitView setLandScape:(UIInterfaceOrientation)interfaceOrientation
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
        
        [self.portraitView removeFromSuperview];
        [self.view addSubview:self.landScapeView];
    }
}

@end
