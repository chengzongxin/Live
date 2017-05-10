//
//  RecommendGameView.m
//  Live
//
//  Created by Cheng on 2017/5/10.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "RecommendGameView.h"
#import "CollectionGameCell.h"
#define kGameCellID @"kGameCellID"
#define kGameCellW 80
#define kGameCellH 80
@interface RecommendGameView () <UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray *_modelArray;
}
@property (nonatomic,retain) NSArray *modelArray;
@end

@implementation RecommendGameView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    _modelArray = [NSArray array];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionGameCell" bundle:nil] forCellWithReuseIdentifier:kGameCellID];
}

// 布局的尺寸必须在layoutsubviews中计算，否则拿到的size不准确
- (void)layoutSubviews
{
    [super layoutSubviews];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(kGameCellW,kGameCellH);
    self.collectionView.contentInset = UIEdgeInsetsMake(0,10,0,10);
    
}


+ (instancetype)recommendGameView
{
    return [[NSBundle mainBundle] loadNibNamed:@"RecommendGameView" owner:nil options:nil].firstObject;
}

-(void)reloadDataWithModelArray:(NSArray *)modelArray
{
    _modelArray = modelArray;
    [_collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionGameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGameCellID forIndexPath:indexPath];
    
    cell.hotCareModel = self.modelArray[indexPath.item];
    
    return cell;
}

@end
