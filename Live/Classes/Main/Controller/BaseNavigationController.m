//
//  BaseNavigationController.m
//  Live
//
//  Created by Cheng on 2017/6/15.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.取出手势View
    
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    
    gesture.enabled = false;
    
    UIView *gestureView = gesture.view;
    
    // 2.获取所有的target
    
    id target = [(NSMutableArray *)[gesture valueForKey:@"_targets"] firstObject];
    
    id transition = [target valueForKey:@"_target"];
    
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    
    // 3.创建新的手势
    
    UIPanGestureRecognizer *popGes = [[UIPanGestureRecognizer alloc] init];
    
    popGes.maximumNumberOfTouches = 1;
    
    popGes.delegate = self;
    
    [gestureView addGestureRecognizer:popGes];
    
    [popGes addTarget:transition action:action];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    // 其中navigationController还使用了私有变量“_isTransitioning”，用于判断交互是否正在进行中。
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}

- (void)reloadView{
    NSLog(@"reloadView");
    [self reloadInputViews];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    viewController.hidesBottomBarWhenPushed = YES;
    
    [super pushViewController:viewController animated:animated];
}


@end
