//
//  PageTitleView.m
//  Live
//
//  Created by Cheng on 2017/5/8.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "PageTitleView.h"
#define kScrollLineH 2
#define kSelectTitleColor [UIColor orangeColor]
#define kNormalTitleColor [UIColor blackColor]

@interface PageTitleView ()
{
    NSMutableArray *_titleLabelArray;
    int _currentIndex;
}
@property (nonatomic,retain) NSMutableArray *titleLabelArray;
@property (nonatomic,assign) int currentIndex;
@end

@implementation PageTitleView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles isScrollEnable:(BOOL)enable
{
    self = [super initWithFrame:frame];
    
    self.titles = titles;
    
    self.isScrollEnale = enable;
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    
    return self;
}

- (NSMutableArray *)titleLabelArray
{
    if (!_titleLabelArray) {
        _titleLabelArray = [NSMutableArray array];
    }
    return _titleLabelArray;
}


- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    }
    _scrollView.showsHorizontalScrollIndicator = false;
    _scrollView.scrollsToTop = false;
    _scrollView.bounces = false;

    return _scrollView;
}

- (void)setupUI
{
    [self addSubview:self.scrollView];
    
    [self setupTitleLabelsView];
    
    [self setupBottomlineAndScrollline];
}

- (void)setupTitleLabelsView
{
    [self.titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        // 设置lable属性
        label.text = title;
        label.tag = idx;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:16.0];
        [self.titleLabelArray addObject:label];
        //  设置lable的frame
        CGFloat titleX = 0;
        CGFloat titleY = 0;
        CGFloat titleW = 0;
        CGFloat titleH = self.bounds.size.height - kScrollLineH;
        
        if (!_isScrollEnale) {
            titleW = self.bounds.size.width / _titles.count;
            titleX = titleW * idx;
        }else{
            CGRect rect = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : label.font} context:nil];
            titleW = rect.size.width;
        }
        label.frame = CGRectMake(titleX, titleY, titleW, titleH);
        
        // 监听label的点击
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTitleLabel:)];
        [label addGestureRecognizer:tapGes];
        // 将label加入到scrollview中
        [self.scrollView addSubview:label];
        
    }];
}

- (void)setupBottomlineAndScrollline
{
    // 1.添加bottomLine
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 0.5, self.bounds.size.width, 0.5)];
    bottomLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:bottomLine];
    
    // 2.设置滑块的view
    UILabel *firstLabel = _titleLabelArray.firstObject;
    CGFloat lineX = firstLabel.frame.origin.x;
    CGFloat lineY = self.bounds.size.height - kScrollLineH;
    CGFloat lineW = firstLabel.frame.size.width;
    CGFloat lineH = kScrollLineH;
    _scrollLine = [[UIView alloc] initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
    [_scrollView addSubview:self.scrollLine];
    _scrollLine.backgroundColor = kSelectTitleColor;
    firstLabel.textColor = kSelectTitleColor;
}

- (void)clickTitleLabel:(UITapGestureRecognizer *)tapGes
{
    int index = (int)tapGes.view.tag;
    if ([_delegate respondsToSelector:@selector(didSelectTitleView:index:)]) {
        [_delegate didSelectTitleView:self index:index];
    }
    [self scrollToIndex:index];
}


- (void)scrollToIndex:(int)index
{
    // 1.获取最新的label和之前的label
    UILabel *oldLabel = _titleLabelArray[_currentIndex];
    UILabel *newLabel = _titleLabelArray[index];
    
    // 2.设置label的颜色
    newLabel.textColor = kSelectTitleColor;
    oldLabel.textColor = kNormalTitleColor;
    
    // 3.scrollLine滚到正确的位置
    CGFloat scrollLineEndX = _scrollLine.frame.size.width * (CGFloat)index;
    [UIView animateWithDuration:0.15 animations:^{
        CGRect frame = _scrollLine.frame;
        frame.origin.x = scrollLineEndX;
        _scrollLine.frame = frame;
    }];
    // 4.记录index
    _currentIndex = index;
}

@end
