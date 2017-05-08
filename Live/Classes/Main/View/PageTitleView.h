//
//  PageTitleView.h
//  Live
//
//  Created by Cheng on 2017/5/8.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorRGB : NSObject
@property (nonatomic,assign) double red;
@property (nonatomic,assign) double green;
@property (nonatomic,assign) double blue;

@end

@class PageTitleView;

@protocol PageTitleViewDelegate <NSObject>

@optional
- (void)didSelectTitleView:(PageTitleView *)pageTitleView index:(int)index;
@end

@interface PageTitleView : UIView

@property (nonatomic,weak) id<PageTitleViewDelegate> delegate;

@property (nonatomic,retain) UIScrollView *scrollView;

@property (nonatomic,retain) UIView *scrollLine;

@property (nonatomic,retain) NSArray *titles;

@property (nonatomic,assign) BOOL isScrollEnale;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles isScrollEnable:(BOOL)enable;

- (void)setCurrentTitleSourceIndex:(int)sourceIndex targetIndex:(int)targetIndex progress:(CGFloat)progress;

@end
