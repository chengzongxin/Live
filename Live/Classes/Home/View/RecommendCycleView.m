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
@interface RecommendCycleView () <UICollectionViewDataSource>
{
    NSArray *_cycleArray;
}
@property (nonatomic,retain) NSArray *cycleArray;
@end

@implementation RecommendCycleView
- (void)awakeFromNib {
    [super awakeFromNib];
    
//    self.autoresizingMask = UIViewAutoresizingNone; 设置不自动拉伸，否则cycleview不能显示
    
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionCycleCell" bundle:nil] forCellWithReuseIdentifier:kCycleCellID];
}

- (void)reloadDataWith:(NSArray *)cycleArray
{
    self.cycleArray = cycleArray;
    [_collectionView reloadData];
    _pageControl.numberOfPages = cycleArray.count;
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
    return self.cycleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCycleCell *cell = nil;
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCycleCellID forIndexPath:indexPath];
    
    cell.cycleModel = self.cycleArray[indexPath.item];
    
    return cell;
}

@end
