//
//  PortraitView.h
//  Live
//
//  Created by Cheng on 2017/5/11.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PortraitView;
@protocol PortraitViewDelegate <NSObject>

@optional
- (void)portraitViewDidClickBackBtn:(PortraitView *)portControlView;

- (void)portraitViewDidClickPauseBtn:(PortraitView *)portControlView;

- (void)portraitView:(PortraitView *)portraitView setLandScape:(UIInterfaceOrientation)interfaceOrientation;

@end


@interface PortraitView : UIView

@property (weak, nonatomic) IBOutlet UIButton *back;

@property (weak, nonatomic) IBOutlet UIButton *more;

@property (weak, nonatomic) IBOutlet UIButton *gift;

@property (weak, nonatomic) IBOutlet UIButton *play;

@property (weak, nonatomic) IBOutlet UIButton *fullScreen;

@property (nonatomic,weak) id<PortraitViewDelegate> delegate;

+ (instancetype)portraitView;
@end
