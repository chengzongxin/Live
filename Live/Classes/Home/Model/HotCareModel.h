//
//  HotCareModel.h
//  Live
//
//  Created by Cheng on 2017/5/9.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoomListModel.h"

@interface HotCareModel : NSObject
@property (nonatomic,retain) NSMutableArray *room_list;
@property (nonatomic,assign) int push_vertical_screen;
@property (nonatomic,copy) NSString *icon_url;
@property (nonatomic,copy) NSString *tag_name;
@property (nonatomic,assign) int push_nearby;
@property (nonatomic,assign) int tag_id;
//@property (nonatomic,retain) NSMutableArray *room_list_array;
@end
