//
//  CollectionNormalCell.m
//  Live
//
//  Created by Cheng on 2017/5/9.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "CollectionNormalCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSObject+Extend.h"
@implementation CollectionNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setContentWithBigDataModel:(BIgDataModel *)model
{
    MYLog(@"%@",[model properties_aps]);
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.room_src]];
    self.name.text = model.nickname;
    self.online.text = model.game_name;
    [self.titleButton setTitle:model.room_name forState:UIControlStateNormal];

}

- (void)setContentWithRoomListModel:(RoomListModel *)model
{
    MYLog(@"%@",[model properties_aps]);
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.room_src]];
    self.name.text = model.nickname;
    self.online.text = model.game_name;
    [self.titleButton setTitle:model.room_name forState:UIControlStateNormal];
    
}

@end
