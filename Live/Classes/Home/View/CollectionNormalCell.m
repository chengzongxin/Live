//
//  CollectionNormalCell.m
//  Live
//
//  Created by Cheng on 2017/5/9.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "CollectionNormalCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation CollectionNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setBigDataModel:(BIgDataModel *)bigDataModel
{
    _bigDataModel = bigDataModel;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:bigDataModel.room_src]];
    self.name.text = bigDataModel.nickname;
    self.online.text = [NSString stringWithFormat:@"%d",bigDataModel.online];
    [self.titleButton setTitle:bigDataModel.room_name forState:UIControlStateNormal];
}

- (void)setRoomListModel:(List *)roomListModel
{
    _roomListModel = roomListModel;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:roomListModel.thumb]];
    self.name.text = roomListModel.nick;
    self.online.text = [NSString stringWithFormat:@"%d",roomListModel.view];
    [self.titleButton setTitle:roomListModel.title forState:UIControlStateNormal];
}


@end
