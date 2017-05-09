//
//  BIgDataModel.m
//  Live
//
//  Created by Cheng on 2017/5/9.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "BIgDataModel.h"

@implementation BIgDataModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

//- (void)setValue:(id)value forKey:(NSString *)key{
//    if ([key isEqualToString:@"list"]) {// list对应的key是数组，在数组里字典拆分为模型
//        [(NSArray *)value enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            LiveVideoDetailCommentModel *model = [[LiveVideoDetailCommentModel alloc] init];
//            [model setValuesForKeysWithDictionary:obj];
//            [_commentArray addObject:model];
//        }];
//    }else{
//        [super setValue:value forKey:key];
//    }
//}

@end
