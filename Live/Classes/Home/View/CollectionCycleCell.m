//
//  CollectionCycleCell.m
//  Live
//
//  Created by Cheng on 2017/5/10.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "CollectionCycleCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation CollectionCycleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCycleModel:(CycleModel *)cycleModel
{
    _cycleModel = cycleModel;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:cycleModel.pic_url]];
    self.title.text = cycleModel.title;
}

@end
