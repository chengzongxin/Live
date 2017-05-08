//
//  PageContentView.h
//  Live
//
//  Created by Cheng on 2017/5/8.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentView : UIView

@property (nonatomic,retain) NSArray *childVcs;

@property (nonatomic,retain) UIViewController *parentViewController;

- (instancetype)initWithFrame:(CGRect)frame childViewControllers:(NSArray *)viewControllers parentViewController:(UIViewController *)parentViewController;
/*
 * 设置内容偏移
 */
- (void)scrollToIndex:(int)index;
@end
