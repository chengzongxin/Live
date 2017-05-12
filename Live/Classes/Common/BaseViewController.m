//
//  BaseViewController.m
//  Live
//
//  Created by Cheng on 2017/5/12.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic,retain) UIImageView *animImageView;
@end

@implementation BaseViewController

// img_loading_fail_124x138_
- (UIImageView *)animImageView{
    if (!_animImageView) {
        _animImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_loading_1_151x232_"]];
        _animImageView.center = self.view.center;
        _animImageView.animationImages = @[[UIImage imageNamed:@"img_loading_1_151x232_"],[UIImage imageNamed:@"img_loading_2_151x232_"]];
        _animImageView.animationRepeatCount = 0;
        _animImageView.animationDuration = 0.3;
        // 设置过后动画会居中显示
        _animImageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    }
    return _animImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    // 0.设置整个背景
    self.view.backgroundColor = [UIColor ColorWithHexString:@"#FBFBFB" withAlpha:1];
    // 1.添加animImageView
    [self.view addSubview:self.animImageView];
    // 2.执行动画
    [self.animImageView startAnimating];
    // 3.隐藏collectionView
    self.contentView.hidden = YES;
}


- (void)animationFinished{
    [self.animImageView stopAnimating];
    self.animImageView.hidden = true;
    self.contentView.hidden = false;
}

@end
