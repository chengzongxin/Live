//
//  CollectionGameCell.h
//  Live
//
//  Created by Cheng on 2017/5/10.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotCareModel.h"
@interface CollectionGameCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (nonatomic,retain) HotCareModel *hotCareModel;
@end
