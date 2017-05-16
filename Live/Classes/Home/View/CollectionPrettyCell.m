//
//  CollectionPrettyCell.m
//  Live
//
//  Created by Cheng on 2017/5/9.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "CollectionPrettyCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation CollectionPrettyCell

- (void)setPrettyModel:(PrettyDataModel *)prettyModel
{
    _prettyModel = prettyModel;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:prettyModel.vertical_src]];
    self.name.text = prettyModel.nickname;
    self.online.text = [NSString stringWithFormat:@"%d",prettyModel.online];
    [self.locationButton setTitle:prettyModel.anchor_city forState:UIControlStateNormal];
}

@end
