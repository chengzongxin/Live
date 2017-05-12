//
//  BaseViewController.h
//  Live
//
//  Created by Cheng on 2017/5/12.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
/*
 * 强引用子ViewController
 */
@property (nonatomic,retain) UIView *contentView;
/*
 * 加载数据完成，动画结束调用事件
 */
- (void)animationFinished;
@end
