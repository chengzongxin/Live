//
//  NetWork.m
//  WYFX_Demo
//
//  Created by Cheng on 2017/5/2.
//  Copyright © 2017年 ChenDan. All rights reserved.
//

#import "NetWork.h"

@implementation NetWork

//不添加请求头的 Manager
+(AFHTTPSessionManager *)shareSessionManager
{
    static AFHTTPSessionManager *manager = nil;
    if (!manager)
    {
        manager = [AFHTTPSessionManager manager];
        // 设置超时时间
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 20.f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
    }
    return manager;
}

//添加请求头的 Manager
+(AFHTTPSessionManager *)shareRowSessionManager
{
    static AFHTTPSessionManager *manager = nil;
    if (!manager)
    {
        manager = [AFHTTPSessionManager manager];
        // 设置超时时间
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 20.f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        //添加请求头
        [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
    }
    return manager;
}

+(void)requestDataMethod:(RequestMethod)method WithUrl:(NSString *)urlStr parameters:(NSDictionary *)parameter success:(void (^)(NSURLSessionDataTask * task, id responseObject))block failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failblock
{
    
    if (!method) {  // get
        AFHTTPSessionManager *manager = [NetWork shareRowSessionManager];
        [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"%@",downloadProgress);
        } success:^(NSURLSessionDataTask * task, id responseObject) {
            block(task,responseObject);
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            failblock(task, error);
        }];
    }else{  // post
        AFHTTPSessionManager *manager = [NetWork shareRowSessionManager];
        [manager POST:urlStr parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"%@",uploadProgress);
        } success:^(NSURLSessionDataTask * task, id responseObject) {
            block(task,responseObject);
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            failblock(task, error);
        }];
    }
    
}

@end
