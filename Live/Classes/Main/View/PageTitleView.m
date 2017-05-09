//
//  PageTitleView.m
//  Live
//
//  Created by Cheng on 2017/5/8.
//  Copyright © 2017年 Joe. All rights reserved.
//

#import "PageTitleView.h"
#define kScrollLineH 2
#define kSelectTitleColor [UIColor colorWithRed:255/255.0 green:128/255.0 blue:0/255.0 alpha:1.0];
#define kNormalTitleColor [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];

@implementation ColorRGB

@end


@interface PageTitleView ()
{
    NSMutableArray *_titleLabelArray;
    int _currentIndex;
    ColorRGB *_deltaRGB;
    ColorRGB *_selectRGB;
    ColorRGB *_normalRGB;
}
@property (nonatomic,retain) NSMutableArray *titleLabelArray;
@property (nonatomic,assign) int currentIndex;
@property (nonatomic,retain) ColorRGB *deltaRGB;
@property (nonatomic,retain) ColorRGB *selectRGB;
@property (nonatomic,retain) ColorRGB *normalRGB;
@end

@implementation PageTitleView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles isScrollEnable:(BOOL)enable
{
    self = [super initWithFrame:frame];
    
    self.titles = titles;
    
    self.isScrollEnale = enable;
    
    self.backgroundColor = [UIColor whiteColor];
    
    _currentIndex = 0;
    
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

- (ColorRGB *)deltaRGB
{
    if (!_deltaRGB) {
        _deltaRGB = [[ColorRGB alloc] init];
        
        UIColor *selectColor = kSelectTitleColor;
        UIColor *normalColor = kNormalTitleColor;
        double selectRed,selectGreen,selectBlue,alpha;
        double normalRed,normalGreen,normalBlue;
        double deltaRed,deltaGreen,deltaBlue;
        [selectColor getRed:&selectRed green:&selectGreen blue:&selectBlue alpha:&alpha];
        [normalColor getRed:&normalRed green:&normalGreen blue:&normalBlue alpha:&alpha];
        deltaRed = selectRed - normalRed;
        deltaGreen = selectGreen - normalGreen;
        deltaBlue = selectBlue - normalBlue;
        
        _deltaRGB.red = deltaRed;
        _deltaRGB.green = deltaGreen;
        _deltaRGB.blue = deltaBlue;
    }
    return _deltaRGB;
}

- (ColorRGB *)normalRGB
{
    if (!_normalRGB) {
        _normalRGB = [[ColorRGB alloc] init];
        _normalRGB.red = 85;
        _normalRGB.green = 85;
        _normalRGB.blue = 85;
    }
    return _normalRGB;
}

- (ColorRGB *)selectRGB
{
    if (!_selectRGB) {
        _selectRGB = [[ColorRGB alloc] init];
        _selectRGB.red = 255;
        _selectRGB.green = 128;
        _selectRGB.blue = 0;
    }
    return _normalRGB;
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
        label.textColor = kNormalTitleColor;
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
//     1.获取最新的label和之前的label
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

- (void)setCurrentTitleSourceIndex:(int)sourceIndex targetIndex:(int)targetIndex progress:(CGFloat)progress
{
    // 1.取出两个Label
    UILabel *sourceLabel = _titleLabelArray[sourceIndex];
    UILabel *targetLabel = _titleLabelArray[targetIndex];
    
    // 2.移动scrollLine
    CGFloat moveMargin = targetLabel.frame.origin.x - sourceLabel.frame.origin.x;
    CGRect frame = self.scrollLine.frame;
    frame.origin.x = sourceLabel.frame.origin.x + moveMargin;// * progress;
    [UIView animateWithDuration:0.15 animations:^{
        self.scrollLine.frame = frame;
    }];
    
    // 2.设置label的颜色
    sourceLabel.textColor = kNormalTitleColor;
    targetLabel.textColor = kSelectTitleColor;
    
    _currentIndex = targetIndex;
    // 3.颜色渐变
//    sourceLabel.textColor = [UIColor colorWithRed:(self.selectRGB.red - self.deltaRGB.red * progress)/255.0  green:(self.selectRGB.green - self.deltaRGB.green * progress)/255.0 blue:(self.selectRGB.blue - self.deltaRGB.blue * progress)/255.0 alpha:1.0];
//    targetLabel.textColor = [UIColor colorWithRed:(self.normalRGB.red + self.deltaRGB.red * progress)/255.0  green:(self.normalRGB.green + self.deltaRGB.green * progress)/255.0 blue:(self.normalRGB.blue + self.deltaRGB.blue * progress)/255.0 alpha:1.0];
    
}

// swift

//    kNormalRGB : (CGFloat, CGFloat, CGFloat) = (85, 85, 85);
//    private let kSelectRGB : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
//    private let kDeltaRGB = (kSelectRGB.0 - kNormalRGB.0, kSelectRGB.1 - kNormalRGB.1, kSelectRGB.2 - kNormalRGB.2)
//    private let kNormalTitleColor = UIColor(red: 85/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1.0)
//    private let kSelectTitleColor = UIColor(red: 255.0/255.0, green: 128/255.0, blue: 0/255.0, alpha: 1.0)
//    sourceLabel.textColor = UIColor(red: (kSelectRGB.0 - kDeltaRGB.0 * progress) / 255.0, green: (kSelectRGB.1 - kDeltaRGB.1 * progress) / 255.0, blue: (kSelectRGB.2 - kDeltaRGB.2 * progress) / 255.0, alpha: 1.0)
//    targetLabel.textColor = UIColor(red: (kNormalRGB.0 + kDeltaRGB.0 * progress)/255.0, green: (kNormalRGB.1 + kDeltaRGB.1 * progress)/255.0, blue: (kNormalRGB.2 + kDeltaRGB.2 * progress)/255.0, alpha: 1.0)

@end
