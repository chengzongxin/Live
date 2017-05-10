//
//  RecommendGameView.h
//  Live
//
//  Created by Cheng on 2017/5/10.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendGameView : UIView
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

+ (instancetype)recommendGameView;

- (void)reloadDataWithModelArray:(NSArray *)modelArray;
@end
