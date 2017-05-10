//
//  RecommendCycleView.h
//  Live
//
//  Created by Cheng on 2017/5/10.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendCycleView : UIView
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

+ (instancetype)recommendCycleView;
// 从根控制器获取数据
- (void)reloadDataWith:(NSArray *)cycleArray;
@end
