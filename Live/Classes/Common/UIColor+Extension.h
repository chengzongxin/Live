//
//  UIColor+Extend.h
//  Live
//
//  Created by Cheng on 2017/5/8.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorModel : NSObject
@property (nonatomic,assign) int R;
@property (nonatomic,assign) int G;
@property (nonatomic,assign) int B;
@property (nonatomic,assign) CGFloat alpha;
@end


@interface UIColor (Extension)
// color = #FFFFFF 或者 0xFFFFFF  [UIColor ColorWithHexString:@"#cccccc" withAlpha:1];
+ (UIColor *)ColorWithHexString: (NSString *)color withAlpha:(CGFloat)alpha;

+ (ColorModel *)ColorWithRGBHexString: (NSString *)color withAlpha:(CGFloat)alpha;

+ (UIColor *)randomColor;

@end
