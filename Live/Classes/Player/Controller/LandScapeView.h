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

@interface LandScapeView : UIView

@property (nonatomic,weak) id<LandScapeViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *back;


+ (instancetype)landScapeView;

@end
