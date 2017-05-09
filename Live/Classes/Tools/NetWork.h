//
//  NetWork.h
//  WYFX_Demo
//
//  Created by Cheng on 2017/5/2.
//  Copyright © 2017年 ChenDan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef NS_ENUM(NSInteger, RequestMethod) {
    
    //以下是枚举成员
    
    GET = 0,
    
    POST = 1,
    
};

@interface NetWork : NSObject
//不添加请求头的 Manager
+(AFHTTPSessionManager *)shareSessionManager;
//添加请求头的 Manager
+(AFHTTPSessionManager *)shareRowSessionManager;
//APP后台 POST Raw 添加请求头
+(void)requestDataMethod:(RequestMethod)method WithUrl:(NSString *)urlStr
           parameters:(NSDictionary *)parameter
              success:(void (^)(NSURLSessionDataTask * task, id responseObject))block
              failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failblock;

@end
