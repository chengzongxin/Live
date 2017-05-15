//
//  QMRecommendModel.h
//  Live
//
//  Created by Cheng on 2017/5/12.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface List : NSObject
@property (nonatomic,copy) NSString *beauty_cover;
@property (nonatomic,assign) int no;
@property (nonatomic,copy) NSString *first_play_at;
@property (nonatomic,copy) NSString *category_name;
@property (nonatomic,assign) int gender;
@property (nonatomic,copy) NSString *thumb;
@property (nonatomic,copy) NSString *last_play_at;
@property (nonatomic,assign) int screen;
@property (nonatomic,copy) NSString *video;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *recommend_image;
@property (nonatomic,assign) int is_shield;
@property (nonatomic,copy) NSString *nick;
@property (nonatomic,assign) int uid;
@property (nonatomic,assign) int view;
@property (nonatomic,assign) int category_id;
@property (nonatomic,copy) NSString *stream;
@property (nonatomic,copy) NSString *slug;
@property (nonatomic,copy) NSString *love_cover;
@property (nonatomic,assign) int level;
@property (nonatomic,assign) int like;
@property (nonatomic,copy) NSString *video_quality;
@property (nonatomic,assign) int weight;
@property (nonatomic,assign) int starlight;
@property (nonatomic,assign) int check;
@property (nonatomic,assign) int avatar;
@property (nonatomic,assign) int follow;
@property (nonatomic,assign) int play_count;
@property (nonatomic,assign) int play_true;
@property (nonatomic,assign) int fans;
@property (nonatomic,assign) int max_view;
@property (nonatomic,copy) NSString *default_image;
@property (nonatomic,copy) NSString *last_end_at;
@property (nonatomic,copy) NSString *position;
@property (nonatomic,copy) NSString *create_at;
@property (nonatomic,copy) NSString *last_thumb;
@property (nonatomic,assign) int landscape;
@property (nonatomic,copy) NSString *category_slug;
@property (nonatomic,assign) int anniversary;
@property (nonatomic,assign) int play_status;
@property (nonatomic,assign) int status;
@property (nonatomic,assign) int coin;
@property (nonatomic,copy) NSString *frame;
@property (nonatomic,copy) NSString *link;
@end


@interface QMRecommendModel : NSObject

@property (nonatomic,assign) int id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) int is_default;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *slug;
@property (nonatomic,copy) NSString *category_more;
@property (nonatomic,assign) int type;
@property (nonatomic,assign) int screen;
@property (nonatomic,retain) NSMutableArray<List *> *list;
@end
