//
//  MainViewController.m
//  Live
//
//  Created by Cheng on 2017/5/5.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "MainViewController.h"
#import "LiveViewController.h"
@interface MainViewController ()<UINavigationControllerDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildVcWithStoryboardName:@"Home" title:@"首页" image:@"tabbar_home_normal" selected:@"tabbar_home_selected"];
    [self addChildVcWithStoryboardName:@"Live" title:@"" image:@"tabbar_live_normal" selected:@"tabbar_live_selected"];
    [self addChildVcWithStoryboardName:@"Profile" title:@"我的" image:@"tabbar_me_normal" selected:@"tabbar_me_selected"];
    
}

- (void)addChildVcWithStoryboardName:(NSString *)name title:(NSString *)title image:(NSString *)normalImg selected:(NSString *)selectedImg
{
    /*
     *  配合 UITabBar+Swizzling，否则中间tabbar多出来的部分不会响应点击事件
     */
    
    UIViewController *vc = [[UIStoryboard storyboardWithName:name bundle:nil] instantiateInitialViewController];
//    if (![vc isKindOfClass:[LiveViewController class]]) {
        [vc.tabBarItem setTitle:title];
//    }
    
    vc.navigationController.delegate = self;
    vc.tabBarItem.image = [[UIImage imageNamed:normalImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:vc];
    
}

#pragma mark -
#pragma mark 实现导航控制器代理方法
// 导航控制器即将显示新的控制器,,此时MainController的view是667，主控制器不在导航中，导航中的控制器高度为623
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *root = navigationController.viewControllers[0];
    
    if (root != viewController) {   // 不是根控制器
        root.tabBarController.tabBar.hidden = YES;
    }else{
        root.tabBarController.tabBar.hidden = NO;
    }
    
}

@end
