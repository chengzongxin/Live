//
//  PortraitView.m
//  Live
//
//  Created by Cheng on 2017/5/11.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "PortraitView.h"

@interface PortraitView (){
}

@end

@implementation PortraitView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    // 添加一个手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapControlView:)];
    [self.blackCoverView addGestureRecognizer:tap];
}

/**
 *  点击了控制view的遮盖view，用来显示和隐藏控制的view
 */
- (void)tapControlView:(UITapGestureRecognizer *)tapGest {
    MYLogFun;
    self.back.hidden = ![self.back isHidden];
    self.more.hidden = ![self.more isHidden];
    self.gift.hidden = ![self.gift isHidden];
    self.play.hidden = ![self.play isHidden];
    self.fullScreen.hidden = ![self.fullScreen isHidden];
    
}

- (void)addPlayerView:(UIView *)view{
    [self.blackCoverView insertSubview:view atIndex:0];
}

+ (instancetype)portraitView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PortraitView class]) owner:nil options:nil].firstObject;
}

- (IBAction)clickBack:(id)sender {
    if ([self.delegate respondsToSelector:@selector(portraitViewDidClickBackBtn:)]) {
        [self.delegate portraitViewDidClickBackBtn:self];
    }
}

- (IBAction)clickMore:(id)sender {
}

- (IBAction)clickGift:(id)sender {
}

- (IBAction)clickPause:(id)sender {
    if ([self.delegate respondsToSelector:@selector(portraitViewDidClickPauseBtn:)]) {
        [self.delegate portraitViewDidClickPauseBtn:self];
    }
}

- (IBAction)clickFullScreen:(id)sender {
    if ([self.delegate respondsToSelector:@selector(portraitView:setLandScape:)]) {
        [self.delegate portraitView:self setLandScape:UIInterfaceOrientationLandscapeRight];
    }
}
/*
// 点击空白区域隐藏controlView
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    //1.判断自己能否接收事件
    if(self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01) {
        return nil;
    }
    //2.判断当前点在不在当前View.
    if (![self pointInside:point withEvent:event]) {
        return nil;
    }
    
    BOOL pointAtBackBtn = CGRectContainsPoint(self.back.frame, point);
    BOOL pointAtMoreBtn = CGRectContainsPoint(self.more.frame, point);
//    BOOL pointAtMoreView = CGRectContainsPoint(self.moreView.frame, point);
    BOOL pointAtGiftBtn = CGRectContainsPoint(self.gift.frame, point);
    BOOL pointAtPlayOrPauseBtn = CGRectContainsPoint(self.play.frame, point);
    BOOL pointAtFullScreenBtn = CGRectContainsPoint(self.fullScreen.frame, point);
    
    if (pointAtBackBtn || pointAtMoreBtn || pointAtGiftBtn || pointAtPlayOrPauseBtn || pointAtFullScreenBtn) {
        return [super hitTest:point withEvent:event];
    } else {
 
        return nil;
    }
}
*/
@end
