//
//  CollectionPrettyCell.m
//  Live
//
//  Created by Cheng on 2017/5/9.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "CollectionPrettyCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSObject+Extend.h"
@implementation CollectionPrettyCell

- (void)setContentWithModel:(PrettyDataModel *)model
{
    MYLog(@"%@",[model properties_aps]);
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.vertical_src]];
    self.name.text = model.nickname;
    self.online.text = [NSString stringWithFormat:@"%d",model.online];
    [self.locationButton setTitle:model.anchor_city forState:UIControlStateNormal];
}
@end
