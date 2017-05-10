//
//  HotCareModel.m
//  Live
//
//  Created by Cheng on 2017/5/9.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "HotCareModel.h"

@implementation HotCareModel

- (instancetype)init
{
    self = [super init];
    
//    _room_list_array = [NSMutableArray array];
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"room_list"]) {// list对应的key是数组，在数组里字典拆分为模型
        self.room_list = [NSMutableArray array];
        [(NSArray *)value enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            RoomListModel *model = [[RoomListModel alloc] init];
            [model setValuesForKeysWithDictionary:obj];
            [self.room_list addObject:model];
        }];
    }else{
        [super setValue:value forKey:key];
    }
}

@end
