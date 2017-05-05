//
//  MainViewController.m
//  Live
//
//  Created by Cheng on 2017/5/5.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildVcWithStoryboardName:@"Home"];
    [self addChildVcWithStoryboardName:@"Live"];
    [self addChildVcWithStoryboardName:@"Profile"];
    
}

- (void)addChildVcWithStoryboardName:(NSString *)name
{
    UIViewController *vc = [[UIStoryboard storyboardWithName:name bundle:nil] instantiateInitialViewController];
    
    [self addChildViewController:vc];
}


@end
