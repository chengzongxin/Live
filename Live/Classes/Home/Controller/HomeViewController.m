//
//  HomeViewController.m
//  Live
//
//  Created by Cheng on 2017/5/5.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "HomeViewController.h"
#import "PageTitleView.h"
#import "PageContentView.h"
#define kPageTitleViewH 44

@interface HomeViewController ()<PageTitleViewDelegate>
{
    PageTitleView *_pageTitleView;
    PageContentView *_pageContentView;
}

@property (nonatomic,retain) PageTitleView *pageTitleView;
@property (nonatomic,retain) PageContentView *pageContentView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 导航栏上的左边logo
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"logo_66x26_" highlightedIcon:nil target:self action:@selector(clickLogoItem)];
    // 导航栏上的右边3个item
    [self setupRightItems];
    
    [self addPageTitleView];
    
    [self addPageContentView];
}


- (void)setupRightItems
{
    //  历史
    UIBarButtonItem *historyItem = [UIBarButtonItem itemWithIcon:@"image_my_history_26x26_" highlightedIcon:@"Image_my_history_click_22x22_" target:self action:@selector(clickHistoryItem)];
    //  搜索
    UIBarButtonItem *searchItem = [UIBarButtonItem itemWithIcon:@"btn_search_22x22_" highlightedIcon:@"btn_search_clicked_22x22_" target:self action:@selector(clickSearchItem)];
    //  二维码
    UIBarButtonItem *qrcodeItem = [UIBarButtonItem itemWithIcon:@"Image_scan_22x22_" highlightedIcon:@"Image_scan_click_22x22_" target:self action:@selector(clickQRCodeItem)];
    //  间距
    UIBarButtonItem *spaceItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    UIBarButtonItem *spaceItem2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];

    spaceItem1.width = spaceItem2.width = 25.0f;
    
    self.navigationItem.rightBarButtonItems = @[qrcodeItem,spaceItem1,searchItem,spaceItem2,historyItem];
}
#pragma mark -  导航栏上的按钮点击方法
- (void)clickLogoItem
{
    MYLogFun;
}

- (void)clickHistoryItem
{
    MYLogFun;
}

- (void)clickSearchItem
{
    MYLogFun;
}

- (void)clickQRCodeItem
{
    MYLogFun;
}

- (void)addPageTitleView
{
    CGRect frame = CGRectMake(0, 0, ScreenWith, kPageTitleViewH);
    NSArray *array = @[@"推荐",@"游戏",@"娱乐",@"趣玩"];
    _pageTitleView = [[PageTitleView alloc] initWithFrame:frame titles:array isScrollEnable:NO];
    _pageTitleView.delegate = self;
    [self.view addSubview:_pageTitleView];
}

- (void)addPageContentView
{
    NSMutableArray *vcArry = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor randomColor];
        [vcArry addObject:vc];
    }
    CGRect frame = CGRectMake(0, kPageTitleViewH, ScreenWith, ScreenHeight - 64 - kPageTitleViewH);
    _pageContentView = [[PageContentView alloc] initWithFrame:frame childViewControllers:vcArry parentViewController:self];
    [self.view addSubview:_pageContentView];
}

- (void)didSelectTitleView:(PageTitleView *)pageTitleView index:(int)index
{
    [_pageContentView scrollToIndex:index];
}

@end
