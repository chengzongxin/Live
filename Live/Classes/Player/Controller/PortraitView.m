//
//  PortraitView.m
//  Live
//
//  Created by Cheng on 2017/5/11.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "PortraitView.h"

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
}

- (IBAction)clickFullScreen:(id)sender {
    if ([self.delegate respondsToSelector:@selector(portraitView:setLandScape:)]) {
        [self.delegate portraitView:self setLandScape:UIInterfaceOrientationLandscapeRight];
    }
}


@end
