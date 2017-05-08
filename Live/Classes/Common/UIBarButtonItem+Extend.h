//
//  UIBarButtonItem+Extend.h
//  Live
//
//  Created by Cheng on 2017/5/8.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extend)
+ (id)itemWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action;
- (id)initWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action;
- (id)initWithTitle:(NSString *)title icon:(NSString *)icon target:(id)target action:(SEL)action;
+ (id)itemWithTitle:(NSString *)title icon:(NSString *)icon target:(id)target action:(SEL)action;
@end
