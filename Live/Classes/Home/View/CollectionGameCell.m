//
//  CollectionGameCell.m
//  Live
//
//  Created by Cheng on 2017/5/10.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "CollectionGameCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation CollectionGameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconImageView.layer.cornerRadius = self.iconImageView.bounds.size.width * 0.5;
    self.iconImageView.layer.masksToBounds = true;
}

- (void)setHotCareModel:(HotCareModel *)hotCareModel
{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:hotCareModel.icon_url]];
    self.title.text = hotCareModel.tag_name;
}

@end
