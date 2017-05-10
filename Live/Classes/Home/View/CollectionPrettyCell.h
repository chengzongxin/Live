//
//  CollectionPrettyCell.h
//  Live
//
//  Created by Cheng on 2017/5/9.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrettyDataModel.h"
@interface CollectionPrettyCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *online;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;

@property (nonatomic,retain) PrettyDataModel *prettyModel;

@end
