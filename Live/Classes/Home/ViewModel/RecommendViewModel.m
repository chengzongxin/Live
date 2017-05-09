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



- (void)requestRecommendData
{
    _hotArray = [NSMutableArray array];
    _prettyArray = [NSMutableArray array];
    _gameArray = [NSMutableArray array];
    
    NSDate *date = [NSDate date];
    NSTimeInterval time = [date timeIntervalSince1970];
    NSString *timeStr = [NSString stringWithFormat:@"%d",(int)time];
    // 1.请求热门数据
    [NetWork requestDataMethod:GET WithUrl:NETWORK_BIGDATA_DATA parameters:@{@"time":timeStr} success:^(NSURLSessionDataTask *task, id responseObject) {
//        MYLog(@"%@",responseObject);
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *dict in data) {
            BIgDataModel *bigDataModel = [[BIgDataModel alloc] init];
            [bigDataModel setValuesForKeysWithDictionary:dict];
            [_hotArray addObject:bigDataModel];
//            MYLog(@"properties_aps %@",[bigDataModel properties_aps] );
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    // 2.请求颜值数据 "limit":"4", "offset" : "0", "time"
    [NetWork requestDataMethod:GET WithUrl:NETWORK_PRETTY_DATA parameters:@{@"limit" : @4,@"offset" : @0,@"time" : timeStr} success:^(NSURLSessionDataTask *task, id responseObject) {
        MYLog(@"NETWORK_PRETTY_DATA%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    // 3.请求游戏数据
}


@end
