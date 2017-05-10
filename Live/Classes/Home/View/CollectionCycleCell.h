//
//  CollectionCycleCell.h
//  Live
//
//  Created by Cheng on 2017/5/10.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleModel.h"
@interface CollectionCycleCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (nonatomic,retain) CycleModel *cycleModel;
@end
