//
//  PageContentView.m
//  Live
//
//  Created by Cheng on 2017/5/8.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "PageContentView.h"
#define kContentCellID @"kContentCellID"

@interface PageContentView ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *_collectionView;
}
@property (nonatomic,retain) UICollectionView *collectionView;
@end

@implementation PageContentView


- (instancetype)initWithFrame:(CGRect)frame childViewControllers:(NSArray *)viewControllers parentViewController:(UIViewController *)parentViewController;
{
    self = [super initWithFrame:frame];
    
    self.childVcs = viewControllers;
    
    self.parentViewController = parentViewController;
    
    [self setupUI];
    
    return self;
}

- (void)setupUI
{
    // 1.添加所有的控制器
    for (UIViewController *vc in self.childVcs) {
        [self.parentViewController addChildViewController:vc];
    }
    // 2.添加collectionView
    [self addCollectionView];
}

- (void)addCollectionView
{
    // 1.创建布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = self.bounds.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 2.创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    collectionView.showsHorizontalScrollIndicator = false;
    collectionView.pagingEnabled = true;
    collectionView.bounces = false;
    collectionView.scrollsToTop = false;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kContentCellID];
    [self addSubview:collectionView];
    _collectionView = collectionView;
}

// 实现UICollectionView的数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childVcs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kContentCellID forIndexPath:indexPath];
    
    // 移除之前的
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    // 取出控制器
    UIViewController *vc = self.childVcs[indexPath.item];
    vc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:vc.view];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MYLog(@"%@",indexPath);
}

- (void)scrollToIndex:(int)index
{
    CGPoint offset = CGPointMake((CGFloat)index * self.collectionView.bounds.size.width,0);
    [self.collectionView setContentOffset:offset animated:YES];
}

@end
