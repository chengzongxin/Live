//
//  RecommendViewController.m
//  Live
//
//  Created by Cheng on 2017/5/9.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "RecommendViewController.h"
#import "RecommendHeaderView.h"
#define kNormalCellID @"kNormalCellID"
#define kPrettyCellID @"kPrettyCellID"
#define kRecommendHeaderViewID @"kRecommendHeaderViewID"
#define kRecommendFooterViewID @"kRecommendFooterViewID"
@interface RecommendViewController () <UICollectionViewDataSource>
{
    CGFloat kItemMargin;
    CGFloat kItemW;
    CGFloat kNormalItemH;
    CGFloat kPrettyItemH;
    CGFloat kHeaderViewH;
    CGFloat kFooterViewH;
    
    UICollectionView *_collectionView;
}
@property (nonatomic,retain) UICollectionView *collectionView;
@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kItemMargin = 10;
    kItemW = ([UIScreen mainScreen].bounds.size.width - 3 * kItemMargin) / 2;
    kNormalItemH = kItemW * 3 / 4;
    kPrettyItemH = kItemW * 4 / 3;
    kHeaderViewH = 50;
    kFooterViewH = 10;
    
    self.view.backgroundColor = [UIColor ColorWithHexString:@"#F4F4F4" withAlpha:1];
    
    [self.view addSubview:self.collectionView];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        // 1.创建布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kItemW, kNormalItemH);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = kItemMargin;
        layout.headerReferenceSize = CGSizeMake(ScreenWith, kHeaderViewH);  //不设置foot、head的reference就不会产生实例对象
        layout.footerReferenceSize = CGSizeMake(ScreenWith, kFooterViewH);
        layout.sectionInset = UIEdgeInsetsMake(0,kItemMargin,0,kItemMargin);
        // 2.创建UICollectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"RecommendHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kRecommendHeaderViewID];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kRecommendFooterViewID];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kNormalCellID];
    }
    return _collectionView;
}

#pragma mark -- colloctionView数据源协议

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 12;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 8;
    }
    return 4;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        RecommendHeaderView *head = (RecommendHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kRecommendHeaderViewID forIndexPath:indexPath];
        
        head.title.text = @"热门";
//        [head setMoreTitle:@"更多直播 >"];
//        [head.moreBtn addTarget:self action:@selector(clickMoreLiveButton) forControlEvents:UIControlEventTouchDown];
        reusableView = head;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kRecommendFooterViewID forIndexPath:indexPath];
        foot.backgroundColor = [UIColor ColorWithHexString:@"#F4F4F4" withAlpha:1];
        reusableView = foot;
    }
    
    return reusableView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNormalCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor randomColor];
    return cell;
}

@end
