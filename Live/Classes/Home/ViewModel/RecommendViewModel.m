//
//  RecommendViewModel.m
//  Live
//
//  Created by Cheng on 2017/5/9.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "RecommendViewModel.h"
#import "NetWork.h"
#import "NewWorkHeader.h"
#import "BIgDataModel.h"
#import "NSObject+Extend.h"
#import "PrettyDataModel.h"
#import "HotCareModel.h"
#import "CycleModel.h"
@interface RecommendViewModel()
{
    NSMutableArray *_hotArray;
    NSMutableArray *_prettyArray;
    NSMutableArray *_gameArray;
}
@property (nonatomic,retain) NSMutableArray *hotArray;
@property (nonatomic,retain) NSMutableArray *prettyArray;
@property (nonatomic,retain) NSMutableArray *gameArray;
@end

@implementation RecommendViewModel



+ (void)requestRecommendData:(void (^)(NSArray *bigDataArray,NSArray *prettyArray,NSArray *hotArray))block;
{
    NSMutableArray *bigDataArray = [NSMutableArray array];
    NSMutableArray *prettyArray = [NSMutableArray array];
    NSMutableArray *hotArray = [NSMutableArray array];
    
    NSDate *date = [NSDate date];
    NSTimeInterval time = [date timeIntervalSince1970];
    NSString *timeStr = [NSString stringWithFormat:@"%d",(int)time];
    
    dispatch_group_t group = dispatch_group_create();
    // 1.请求热门数据
    dispatch_group_enter(group);
    [NetWork requestDataMethod:GET WithUrl:NETWORK_BIGDATA_DATA parameters:@{@"time":timeStr} success:^(NSURLSessionDataTask *task, id responseObject) {
//        MYLog(@"%@",responseObject);
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *dict in data) {
            BIgDataModel *bigDataModel = [[BIgDataModel alloc] initWithDict:dict];
            [bigDataArray addObject:bigDataModel];
        }
        dispatch_group_leave(group);
        MYLog(@"请求完成第1组数据");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    // 2.请求颜值数据 "limit":"4", "offset" : "0", "time"
    dispatch_group_enter(group);
    [NetWork requestDataMethod:GET WithUrl:NETWORK_PRETTY_DATA parameters:@{@"time" : timeStr,@"limit" : @"4",@"offset" : @"0"} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *dict in data) {
            PrettyDataModel *prettyDataModel = [[PrettyDataModel alloc] initWithDict:dict];
            [prettyArray addObject:prettyDataModel];
        }
        dispatch_group_leave(group);
        MYLog(@"请求完成第2组数据");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    // 3.请求游戏数据
    dispatch_group_enter(group);
    [NetWork requestDataMethod:GET WithUrl:NETWORK_HOTCARE_DATA parameters:@{@"time" : timeStr,@"limit" : @"4",@"offset" : @"0"} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *dict in data) {
            HotCareModel *hotCareModel = [[HotCareModel alloc] initWithDict:dict];
            [hotArray addObject:hotCareModel];
        }
        dispatch_group_leave(group);
        MYLog(@"请求完成第3组数据");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
     // 4.所有数据加载完成
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        MYLog(@"所有数据加载完成");
        block(bigDataArray,prettyArray,hotArray);
    });
}


+ (void)requestCycleData:(void(^)(NSArray *cycleArray))block
{
    NSMutableArray *array = [NSMutableArray array];
    [NetWork requestDataMethod:GET WithUrl:NETWORK_CYCLEAD_DATA parameters:@{@"version":@"2.300"} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *dict in data) {
            CycleModel *cycleModel = [[CycleModel alloc] initWithDict:dict];
            [array addObject:cycleModel];
        }
        block(array);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
@end
