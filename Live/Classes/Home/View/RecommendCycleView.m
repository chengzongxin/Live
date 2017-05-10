//
//  RecommendCycleView.m
//  Live
//
//  Created by Cheng on 2017/5/10.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "RecommendCycleView.h"
#import "CycleModel.h"
#import "CollectionCycleCell.h"
#define kCycleCellID @"kCycleCellID"
@interface RecommendCycleView () <UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *_cycleArray;
    NSTimer *_cycleTimer;
}
@property (nonatomic,retain) NSArray *cycleArray;
@property (nonatomic,retain) NSTimer *cycleTimer;
@end

@implementation RecommendCycleView
- (void)awakeFromNib {
    [super awakeFromNib];
    
//    self.autoresizingMask = UIViewAutoresizingNone; 设置不自动拉伸，否则cycleview不能显示
    
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionCycleCell" bundle:nil] forCellWithReuseIdentifier:kCycleCellID];
    
    [self addCycleTimer];
}

- (void)reloadDataWithModelArray:(NSArray *)modelArray
{
    self.cycleArray = modelArray;
    [_collectionView reloadData];
    _pageControl.numberOfPages = modelArray.count;
    // 默认滚动到60处，那么用户向前滚动也有内容
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.cycleArray.count * 10 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

// 布局的尺寸必须在layoutsubviews中计算，否则拿到的size不准确
- (void)layoutSubviews
{
    [super layoutSubviews];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
    layout.itemSize = _collectionView.bounds.size;
}

+ (instancetype)recommendCycleView
{
    return [[NSBundle mainBundle] loadNibNamed:@"RecommendCycleView" owner:nil options:nil].firstObject;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cycleArray.count * 1000;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCycleCell *cell = nil;
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCycleCellID forIndexPath:indexPath];
    
    cell.cycleModel = self.cycleArray[indexPath.item%self.cycleArray.count];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.x + scrollView.bounds.size.width * 0.5;  // 拖动到一半就显示到下一个
    
    int offsetIndex = (int)offset / scrollView.bounds.size.width;
    
    _pageControl.currentPage = offsetIndex % self.cycleArray.count;
}


#pragma mark -- 定时器自动轮播
- (void)scrollToNext
{
    CGFloat offset = _collectionView.contentOffset.x + _collectionView.bounds.size.width;
    [_collectionView setContentOffset:CGPointMake(offset, 0) animated:YES];
}

- (void)addCycleTimer
{
    _cycleTimer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(scrollToNext) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:_cycleTimer forMode:NSRunLoopCommonModes];
}

- (void)removeCycleTime
{
    [_cycleTimer invalidate];
    
    _cycleTimer = nil;
}


// 用户拖拽过程中，定时器不更新
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeCycleTime];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addCycleTimer];
}

@end
