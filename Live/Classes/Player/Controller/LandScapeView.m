//
//  LandScapeView.m
//  Live
//
//  Created by Cheng on 2017/5/11.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "LandScapeView.h"

@implementation LandScapeView

+ (instancetype)landScapeView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LandScapeView class]) owner:nil options:nil].firstObject;
}
@end