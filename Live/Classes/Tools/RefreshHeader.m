//
//  RefreshHeader.m
//  Live
//
//  Created by Cheng on 2017/5/12.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "RefreshHeader.h"

@implementation RefreshHeader

- (instancetype)init{
    if (self = [super init]) {
        self.lastUpdatedTimeLabel.hidden = YES;
        self.stateLabel.hidden = YES;
        [self setImages:@[[UIImage imageNamed:@"dyla_img_mj_stateIdle_64x66_"]] forState:MJRefreshStateIdle];
        [self setImages:@[[UIImage imageNamed:@"dyla_img_mj_statePulling_64x66_"]] forState:MJRefreshStatePulling];
        [self setImages:@[[UIImage imageNamed:@"dyla_img_mj_stateRefreshing_01_135x66_"],
                            [UIImage imageNamed:@"dyla_img_mj_stateRefreshing_02_135x66_"],
                            [UIImage imageNamed:@"dyla_img_mj_stateRefreshing_03_135x66_"],
                            [UIImage imageNamed:@"dyla_img_mj_stateRefreshing_04_135x66_"]] duration:0.5 forState:MJRefreshStateRefreshing];
        
    }
    return self;
}

@end
