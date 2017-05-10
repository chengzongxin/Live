//
//  RecommendViewModel.h
//  Live
//
//  Created by Cheng on 2017/5/9.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendViewModel : NSObject
// 请求推荐数据
+ (void)requestRecommendData:(void (^)(NSArray *bigDataArray,NSArray *prettyArray,NSArray *hotArray))block;
// 请求轮播数据
+ (void)requestCycleData:(void(^)(NSArray *cycleArray))block;
@end
