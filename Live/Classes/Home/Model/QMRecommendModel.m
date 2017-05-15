//
//  QMRecommendModel.m
//  Live
//
//  Created by Cheng on 2017/5/12.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "QMRecommendModel.h"

@implementation List


@end

@implementation QMRecommendModel
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"list"]) {// list对应的key是数组，在数组里字典拆分为模型
        self.list = [NSMutableArray array];
        [(NSArray *)value enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            List *model = [[List alloc] init];
            [model setValuesForKeysWithDictionary:obj];
            [self.list addObject:model];
        }];
    }else{
        [super setValue:value forKey:key];
    }
}
@end
