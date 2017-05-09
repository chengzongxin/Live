//
//  NSObject+Extend.h
//  Live
//
//  Created by Cheng on 2017/5/9.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extend)
/* 获取对象的所有属性，不包括属性值 */
- (NSArray *)getAllProperties;
/* 获取对象的所有属性 以及属性值 */
- (NSDictionary *)properties_aps;
/* 获取对象的所有方法 */
-(void)printMothList;
@end
