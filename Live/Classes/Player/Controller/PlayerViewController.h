//
//  PlayerViewController.h
//  Live
//
//  Created by Cheng on 2017/5/11.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QMRecommendModel.h"

@interface PlayerViewController : UIViewController

@property (nonatomic,copy) NSString *live_stream_url;

@property (nonatomic,retain) List *list;

@end
