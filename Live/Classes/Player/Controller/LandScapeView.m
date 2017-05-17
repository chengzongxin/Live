//
//  LandScapeView.m
//  Live
//
//  Created by Cheng on 2017/5/11.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "LandScapeView.h"

@interface LandScapeView (){
    NSTimeInterval _lastTimeStamp;
}

@end

@implementation LandScapeView

+ (instancetype)landScapeView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LandScapeView class]) owner:nil options:nil].firstObject;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self addObserver];
    
    UIApplication *application = [UIApplication sharedApplication];
    
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    // 添加一个手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapControlView:)];
    [self.blackCoverView addGestureRecognizer:tap];
}

/**
 *  点击了控制view的遮盖view，用来显示和隐藏控制的view
 */
- (void)tapControlView:(UITapGestureRecognizer *)tapGest {
    [UIApplication sharedApplication].statusBarHidden = ![[UIApplication sharedApplication] isStatusBarHidden];
    self.statusView.hidden = ![self.statusView isHidden];
    self.topControlView.hidden = ![self.topControlView isHidden];
    self.bottomControlView.hidden = ![self.bottomControlView isHidden];
    
}

- (void)addObserver{
    // 监听键盘的显示和隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)addPlayerView:(UIView *)view{
    [self.blackCoverView insertSubview:view atIndex:0];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField hasText]) {
        self.isClickReturn = YES;
        [textField endEditing:YES];
    } else {
        [textField endEditing:YES];
    }
    return YES;
}

#pragma mark - 监听键盘的弹出和隐藏
/**
 *  键盘即将显示
 */
- (void)keyboardWillShow:(NSNotification *)note {
    
    // 隐藏上面的控制view
    self.topControlView.hidden = YES;
    
    // 关闭自动隐藏
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteTimer" object:nil];
    
//    [self.superview insertSubview:self.coverView belowSubview:self];
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    self.bottomViewConstraint.constant = keyboardFrame.size.height;
    [UIView animateWithDuration:duration animations:^{
        [self.bottomControlView layoutIfNeeded];
    }];
}

/**
 *  键盘即将隐藏
 */
- (void)keyboardWillHide:(NSNotification *)note {
    
    // 显示上面的控制view
    self.topControlView.hidden = NO;
    
    if (self.isClickReturn) {
        self.isClickReturn = NO;
        // 隐藏横屏的view、隐藏状态栏
//        self.hidden = YES;
//        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        // 发弹幕通知
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"sendBarrage" object:nil userInfo:@{ @"text" : self.barrageField.text}];
        // 清空文本框的文字
//        self.barrageField.text = nil;
    } else {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"addTimer" object:nil];
    }
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    self.bottomViewConstraint.constant = 0;
    [UIView animateWithDuration:duration animations:^{
        [self.bottomControlView layoutIfNeeded];
    } completion:^(BOOL finished) {
//        [self.coverView removeFromSuperview];
    }];
    
}

- (IBAction)clickBack:(id)sender {
    if ([self.delegate respondsToSelector:@selector(landScapeView:setPortrait:)]) {
        [self.delegate landScapeView:self setPortrait:UIInterfaceOrientationPortrait];
    }
}



@end
