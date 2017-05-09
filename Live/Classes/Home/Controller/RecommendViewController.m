//
//  RecommendViewController.m
//  Live
//
//  Created by Cheng on 2017/5/9.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "RecommendViewController.h"
#import "RecommendHeaderView.h"
#import "RecommendViewModel.h"
#define kNormalCellID @"kNormalCellID"
#define kPrettyCellID @"kPrettyCellID"
#define kRecommendHeaderViewID @"kRecommendHeaderViewID"
#define kRecommendFooterViewID @"kRecommendFooterViewID"
@interface RecommendViewController () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
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
    kHeaderViewH = 40;
    kFooterViewH = 10;
    
    self.view.backgroundColor = [UIColor ColorWithHexString:@"#F4F4F4" withAlpha:1];
    
    [self.view addSubview:self.collectionView];
    
    RecommendViewModel *recommendVM = [[RecommendViewModel alloc] init];
    [recommendVM requestRecommendData];
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
        _collectionView.delegate = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"RecommendHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kRecommendHeaderViewID];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kRecommendFooterViewID];
        [_collectionView registerNib:[UINib nibWithNibName:@"CollectionNormalCell" bundle:nil] forCellWithReuseIdentifier:kNormalCellID];
        [_collectionView registerNib:[UINib nibWithNibName:@"CollectionPrettyCell" bundle:nil] forCellWithReuseIdentifier:kPrettyCellID];
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
//        foot.layer.cornerRadius =1;
//        foot.layer.masksToBounds = YES;
    }
    
    return reusableView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    
    if (indexPath.section == 1) {  // prettyCell
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPrettyCellID forIndexPath:indexPath];
    }else{   // normalCell
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNormalCellID forIndexPath:indexPath];
    }
    
    return cell;
}

#pragma mark -- LayOut代理方法改变prettyCell的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return CGSizeMake(kItemW,kPrettyItemH);
    } else {
        return CGSizeMake(kItemW,kNormalItemH);
    }
}


@end
