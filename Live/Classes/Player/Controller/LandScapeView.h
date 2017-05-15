//
//  LandScapeView.h
//  Live
//
//  Created by Cheng on 2017/5/11.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LandScapeView;
@protocol LandScapeViewDelegate <NSObject>

@optional
- (void)landScapeViewDidClickBackBtn:(LandScapeView *)landScapeView;

- (void)landScapeView:(LandScapeView *)landScapeView setPortrait:(UIInterfaceOrientation)interfaceOrientation;

@end

@interface LandScapeView : UIView <UITextFieldDelegate>

@property (nonatomic,weak) id<LandScapeViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *back;

@property (weak, nonatomic) IBOutlet UIView *statusView;

@property (weak, nonatomic) IBOutlet UIView *topControlView;

@property (weak, nonatomic) IBOutlet UIView *bottomControlView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConstraint;

@property (nonatomic,assign) BOOL isClickReturn;

+ (instancetype)landScapeView;

@end
