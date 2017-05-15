//
//  PortraitView.m
//  Live
//
//  Created by Cheng on 2017/5/11.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "PortraitView.h"

@interface PortraitView (){
    NSTimeInterval _lastTimeStamp;
}

@end

@implementation PortraitView

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
        double timestap = event.timestamp - _lastTimeStamp;
        MYLog(@"%f",timestap);
        if (event.timestamp != _lastTimeStamp) {  //避免重复调用
            self.back.hidden = ![self.back isHidden];
            self.more.hidden = ![self.more isHidden];
            self.gift.hidden = ![self.gift isHidden];
            self.play.hidden = ![self.play isHidden];
            self.fullScreen.hidden = ![self.fullScreen isHidden];
            _lastTimeStamp = event.timestamp;
        }
        return nil;
    }
}

@end
