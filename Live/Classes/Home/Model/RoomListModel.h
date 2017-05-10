//
//  RoomListModel.h
//  Live
//
//  Created by Cheng on 2017/5/9.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoomListModel : NSObject

@property (nonatomic,copy) NSString *avatar_mid;
@property (nonatomic,copy) NSString *avatar_small;
@property (nonatomic,assign) int cate_id;
@property (nonatomic,copy) NSString *game_name;
@property (nonatomic,assign) int isVertical;
@property (nonatomic,copy) NSString *jumpUrl;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,assign) int online;
@property (nonatomic,assign) int owner_uid;
@property (nonatomic,assign) int ranktype;
@property (nonatomic,assign) int room_id;
@property (nonatomic,copy) NSString *room_name;
@property (nonatomic,copy) NSString *room_src;
@property (nonatomic,assign) int show_status;
@property (nonatomic,assign) int show_time;
@property (nonatomic,copy) NSString *specific_catalog;
@property (nonatomic,assign) int specific_status;
@property (nonatomic,copy) NSString *vertical_src;

@end