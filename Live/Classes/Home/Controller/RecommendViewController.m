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
#import "BIgDataModel.h"
#import "PrettyDataModel.h"
#import "HotCareModel.h"
#import "CollectionNormalCell.h"
#import "CollectionPrettyCell.h"
#import "RecommendCycleView.h"
#import "RecommendGameView.h"
#import <MJRefresh/MJRefresh.h>
#define kNormalCellID @"kNormalCellID"
#define kPrettyCellID @"kPrettyCellID"
#define kRecommendHeaderViewID @"kRecommendHeaderViewID"
#define kRecommendFooterViewID @"kRecommendFooterViewID"
#define kCycleViewH 160
#define kGameViewH  90
#define kItemMargin 10
#define kItemW ([UIScreen mainScreen].bounds.size.width - 3 * kItemMargin) / 2
#define kNormalItemH kItemW * 3 / 4
#define kPrettyItemH kItemW * 4 / 3
#define kHeaderViewH 30
#define kFooterViewH 10
@interface RecommendViewController () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    NSArray *_bigDataArray;
    NSArray *_prettyArray;
    NSArray *_hotCareArray;
    RecommendCycleView *_recommentCycleView;
    RecommendGameView *_recommendGameView;
    
}
@property (nonatomic,retain) RecommendCycleView *recommentCycleView;
@property (nonatomic,retain) RecommendGameView *recommendGameView;
@property (nonatomic,retain) UICollectionView *collectionView;
@property (nonatomic,copy) NSArray *bigDataArray;
@property (nonatomic,copy) NSArray *prettyArray;
@property (nonatomic,copy) NSArray *hotCareArray;
@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化VC
    self.view.backgroundColor = [UIColor ColorWithHexString:@"#F4F4F4" withAlpha:1];
    
    // 添加下面展示的推荐数据-collectionView
    [self.view addSubview:self.collectionView];
    // 在collectionView上面添加广告轮播
    [_collectionView addSubview:self.recommentCycleView];
    
    // 在collectionView上添加推荐游戏
    [_collectionView addSubview:self.recommendGameView];
    
    // 设置collectionView上面偏移出来的距离
    _collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH+kGameViewH, 0, 0, 0);
    
    // 设置下拉刷新
    [self setupRefresh];
    
    // 第一次进入刷新请求
    [self.collectionView.mj_header beginRefreshing];
}

- (void)setupRefresh {
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    [header setImages:@[[UIImage imageNamed:@"dyla_img_mj_stateIdle_64x66_"]] forState:MJRefreshStateIdle];
    [header setImages:@[[UIImage imageNamed:@"dyla_img_mj_statePulling_64x66_"]] forState:MJRefreshStatePulling];
    [header setImages:@[[UIImage imageNamed:@"dyla_img_mj_stateRefreshing_01_135x66_"],
                        [UIImage imageNamed:@"dyla_img_mj_stateRefreshing_02_135x66_"],
                        [UIImage imageNamed:@"dyla_img_mj_stateRefreshing_03_135x66_"],
                        [UIImage imageNamed:@"dyla_img_mj_stateRefreshing_04_135x66_"]] duration:0.5 forState:MJRefreshStateRefreshing];
    [header setTimeLabelHidden:YES forState:MJRefreshStateRefreshing];
    header.ignoredScrollViewContentInsetTop = kCycleViewH+kGameViewH;  // 忽略insets
    self.collectionView.mj_header = header;
}

- (void)refreshData
{
    // 请求推荐数据
    [RecommendViewModel requestRecommendData:^(NSArray *bigDataArray, NSArray *prettyArray, NSArray *hotArray) {
        _bigDataArray = bigDataArray;
        _prettyArray = prettyArray;
        _hotCareArray = hotArray;
        [_collectionView reloadData];
        
        //刷新游戏推荐
        [self.recommendGameView reloadDataWithModelArray:hotArray];
        
        [self.collectionView.mj_header endRefreshing];
    }];
    // 请求轮播数据
    [RecommendViewModel requestCycleData:^(NSArray *cycleArray) {
        [self.recommentCycleView reloadDataWithModelArray:cycleArray];
    }];
}

- (RecommendCycleView *)recommentCycleView
{
    if (!_recommentCycleView){
        _recommentCycleView = [RecommendCycleView recommendCycleView];
        _recommentCycleView.frame = CGRectMake(0, -kCycleViewH-kGameViewH, ScreenWith, kCycleViewH);
    }
    return _recommentCycleView;
}

- (RecommendGameView *)recommendGameView
{
    if (!_recommendGameView) {
        _recommendGameView = [RecommendGameView recommendGameView];
        _recommendGameView.frame = CGRectMake(0, -kGameViewH, ScreenWith, kGameViewH);
    }
    return _recommendGameView;
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
        CGRect frame = self.view.bounds;
        frame.size.height = frame.size.height - 64 - 44 - 44;
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
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
    return _hotCareArray.count + 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) { // bigdata
        return _bigDataArray.count;
    }else if (section == 1){ // pretty
        return MIN(4, _prettyArray.count) ;
    }else{ // hotcare
        return MIN(4, [(HotCareModel *)_hotCareArray[section - 2] room_list].count);
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        RecommendHeaderView *head = (RecommendHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kRecommendHeaderViewID forIndexPath:indexPath];
        
        if (indexPath.section == 0) {
            head.title.text = @"最热";
            head.iconImageView.image = [UIImage imageNamed:@"home_header_hot_18x18_"];
        }else if (indexPath.section == 1){
            head.title.text = @"颜值";
            head.iconImageView.image = [UIImage imageNamed:@"home_header_phone_18x18_"];
        }else{
            HotCareModel *hotCareModel = _hotCareArray[indexPath.section - 2];
            head.title.text = hotCareModel.tag_name;
            head.iconImageView.image = [UIImage imageNamed:@"home_header_normal_18x18_"];
        }
//        [head.moreBtn addTarget:self action:@selector(clickMoreLiveButton) forControlEvents:UIControlEventTouchDown];
        reusableView = head;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kRecommendFooterViewID forIndexPath:indexPath];
        foot.backgroundColor = [UIColor ColorWithHexString:@"#E4E4E4" withAlpha:1];
        reusableView = foot;
    }
    
    return reusableView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    
    if (indexPath.section == 0) { // bigData 第0组
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNormalCellID forIndexPath:indexPath];
        [(CollectionNormalCell *)cell setBigDataModel:_bigDataArray[indexPath.item]];
    }else if (indexPath.section == 1) { // prettyCell 第一组
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPrettyCellID forIndexPath:indexPath];
        [(CollectionPrettyCell *)cell setPrettyModel:_prettyArray[indexPath.item]];
    }else { // hotcare 第2-12组
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNormalCellID forIndexPath:indexPath];
        HotCareModel *hotcare = _hotCareArray[indexPath.section - 2];
        NSArray *room_list = hotcare.room_list;
        RoomListModel *room = room_list[indexPath.item];
        [(CollectionNormalCell *)cell setRoomListModel:room];
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
