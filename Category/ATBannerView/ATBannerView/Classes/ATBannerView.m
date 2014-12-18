//
//  moto_BannerView.m
//  Moto
//
//  Created by KthRee on 13-12-4.
//  Copyright (c) 2013年 agile. All rights reserved.
//
#define ImagesCount (_imageURLs ? [_imageURLs count] : [_imagePaths count])
#define RGBColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#import <SDWebImage/UIImageView+WebCache.h>
#import "ATBannerView.h"

@interface ATBannerView () {
    UIScrollView *_scrollView;
    UIImageView *_imageView;
    
    UILabel *_titleLabel;            //用来显示当前页的标题
    UILabel *_titleLabelQ;           //用来显示当前页前一页的标题
    UILabel *_titleLabelH;           //用来显示当前页下一页的标题
    
    NSMutableArray *_temp;
    
    UIImageView *_leftImage;            //用来显示当前页前一页的图片
    UIImageView *_middleImage;          //用来显示当前页的图片
    UIImageView *_rightImage;           //用来显示当前页下一页的图片
    
    NSInteger _leftImageIndex;
    NSInteger _middleImageIndex;
    NSInteger _rightImageIndex;
    
    NSTimer *_timer;
    
    int timeCount;
}

- (void)setImages;

@end

@implementation ATBannerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addviews];
        _leftImage = [[UIImageView alloc] init];
        _middleImage = [[UIImageView alloc] init];
        _rightImage = [[UIImageView alloc] init];
        _isPlay = YES;
    }
    return self;
}

/**
 *  设置页码指示器颜色
 *
 *  @param indicatorColor   页码指示器主调色
 *  @param currentPageColor 当前页码指示器颜色
 */
- (void)setPageIndicatorTintColor:(UIColor *)indicatorColor currentPageIndicatorTintColor:(UIColor *)currentPageColor {
    if (!_pageCtrl) {
        _pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(5.0f, self.frame.size.height - 10.0f, self.frame.size.width - 10.0f, 5.0f)];
    }
    [_pageCtrl setPageIndicatorTintColor:indicatorColor];
    [_pageCtrl setCurrentPageIndicatorTintColor:currentPageColor];
}

- (void)reloadImages {
    [self setImages];
//    [self addImages];
//    [self addPageControll];
}

- (int)second
{
    if (!_second) {
        _second = 5;
    }
    return _second;
}

- (void)addviews
{
    [self addStrollView];
    timeCount = 0;
    if (_isPlay) {
        [self startTimer];
    }
    
}

- (void)addStrollView
{
    _scrollView = [[UIScrollView alloc] init];
    [_scrollView setFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
    _scrollView.pagingEnabled = YES;
    _scrollView.clipsToBounds = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [_scrollView setDelegate:self];
    [self addSubview:_scrollView];
}

- (void)addImages
{
    [_scrollView setContentSize:CGSizeMake(self.bounds.size.width * 3, 0)];
    
    _leftImageIndex = ImagesCount - 1;
    _middleImageIndex = 0;
    _rightImageIndex = 1;
    
    [self setImages];
    
    _leftImage.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);//当前页的前一张图片位置
    _middleImage.frame = CGRectMake(self.frame.size.width + (self.bounds.size.width - self.frame.size.width) / 2, 0.0f, self.frame.size.width, self.frame.size.height);//当前页的图片位置，在停止滑动时始终显示此图片
    _rightImage.frame = CGRectMake(2 * self.frame.size.width + (self.bounds.size.width - self.frame.size.width), 0.0f, self.frame.size.width, self.frame.size.height);//当前页下一张图片位置
    [_leftImage setContentMode:UIViewContentModeScaleAspectFill];
    [_leftImage setClipsToBounds:YES];
    [_middleImage setContentMode:UIViewContentModeScaleAspectFill];
    [_middleImage setClipsToBounds:YES];
    [_rightImage setContentMode:UIViewContentModeScaleAspectFill];
    [_rightImage setClipsToBounds:YES];
    [_scrollView addSubview:_leftImage];
    [_scrollView addSubview:_middleImage];
    [_scrollView addSubview:_rightImage];
    [self setCorner];
    _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0.0f);//使中间页可见
}

- (void)setCorner
{
    [_middleImage.layer setMasksToBounds:YES];
    [_middleImage.layer setBorderWidth:0.5f];
    [_middleImage.layer setBorderColor:RGBColor(194.0f, 194.0f, 194.0f, 0.0f).CGColor];
    [_middleImage.layer setCornerRadius:0];
    [_leftImage.layer setMasksToBounds:YES];
    [_leftImage.layer setBorderWidth:0.5f];
    [_leftImage.layer setBorderColor:RGBColor(194.0f, 194.0f, 194.0f, 0.0f).CGColor];
    [_leftImage.layer setCornerRadius:0];
    [_rightImage.layer setMasksToBounds:YES];
    [_rightImage.layer setBorderWidth:0.5f];
    [_rightImage.layer setBorderColor:RGBColor(194.0f, 194.0f, 194.0f, 0.0f).CGColor];
    [_rightImage.layer setCornerRadius:0];
}

- (void)addTitles
{
    _titleLabelQ = [[UILabel alloc] initWithFrame:CGRectMake(5.0f + (self.bounds.size.width - self.frame.size.width)/2, self.frame.size.height - 38.0f, self.frame.size.width - 10.0f, 25.0f)];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width + 5.0f + (self.bounds.size.width - self.frame.size.width)/2, self.frame.size.height - 38.0f, self.frame.size.width - 10.0f, 25.0f)];
    _titleLabelH = [[UILabel alloc] initWithFrame:CGRectMake(2 * self.frame.size.width + 5.0f + (self.bounds.size.width - self.frame.size.width)/2, self.frame.size.height - 38.0f, self.frame.size.width - 10.0f, 25.0f)];
    [_titleLabelQ setText:self.title[_pageCtrl.numberOfPages - 1]];
    [_titleLabel setText:self.title[0]];
    [_titleLabelH setText:self.title[1]];
    [_titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
    [_titleLabel setBackgroundColor:RGBColor(1.0f, 1.0f, 1.0f, 0.0f)];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [_titleLabelQ setFont:[UIFont systemFontOfSize:20.0f]];
    [_titleLabelQ setBackgroundColor:RGBColor(1.0f, 1.0f, 1.0f, 0.0f)];
    [_titleLabelQ setTextColor:[UIColor whiteColor]];
    [_titleLabelH setFont:[UIFont systemFontOfSize:20.0f]];
    [_titleLabelH setBackgroundColor:RGBColor(1.0f, 1.0f, 1.0f, 0.0f)];
    [_titleLabelH setTextColor:[UIColor whiteColor]];
    [_scrollView addSubview:_titleLabel];
    [_scrollView addSubview:_titleLabelQ];
    [_scrollView addSubview:_titleLabelH];
}

- (void)setTitle:(NSArray *)title
{
    _title = title;
    [self addTitles];
}

-(void)scrollTimer{
    timeCount ++;
    if (timeCount == _pageCtrl.numberOfPages) {
        timeCount = 0;
    }
    
//    [scrollView scrollRectToVisible:CGRectMake(timeCount * 320.0, 65.0, 320.0, 218.0) animated:YES];
//    scrollView.contentOffset = CGPointMake(640.0f, 0.0f);

    
    if (_pageCtrl.currentPage < _pageCtrl.numberOfPages - 1)//如果滑动前的当前页不是倒数第一页
    {
        _pageCtrl.currentPage++;
        _leftImageIndex = _pageCtrl.currentPage - 1;      //加载当前页前一页的图片
        _middleImageIndex = _pageCtrl.currentPage;        //加载当前页的图片
        _rightImageIndex = _pageCtrl.currentPage == (ImagesCount - 1) ? 0 : _pageCtrl.currentPage + 1; //如果滑动完当前页是最后一页，那么当前页下一张图片是第一张图片
        [_titleLabel setText:self.title[_pageCtrl.currentPage]];
        [_titleLabelQ setText:self.title[_pageCtrl.currentPage - 1]];
        [_titleLabelH setText:self.title[_pageCtrl.currentPage == (ImagesCount - 1) ? 0 : _pageCtrl.currentPage + 1]];
    }
    else//如果滑动前的当前页是倒数第一页
    {
        _pageCtrl.currentPage = 0;                      //设置当前页为0
       _leftImageIndex   = _pageCtrl.numberOfPages - 1; //加载当前页前一页的图片
       _middleImageIndex = 0;                           //加载当前页的图片
        _rightImageIndex = _pageCtrl.currentPage + 1;   //加载当前页下一页的图片
        [_titleLabel setText:self.title[0]];
        [_titleLabelQ setText:self.title[_pageCtrl.numberOfPages - 1]];
        [_titleLabelH setText:self.title[_pageCtrl.currentPage + 1]];
    }
    
    [UIView animateWithDuration:1 animations:^{
        [_scrollView setContentOffset:CGPointMake(_scrollView.contentSize.width / 3 * 2, 0)];
    } completion:^(BOOL finished) {
        [self setImages];
        [_scrollView setContentOffset:CGPointMake(_scrollView.contentSize.width / 3, 0)];
    }];
    
    
}

- (void)setImageURLs:(NSArray *)imageURLs {
    _imageURLs = imageURLs;
    [self addImages];
    [self addPageControll];
}

- (void)setImagePaths:(NSArray *)imagePaths {
    _imagePaths = imagePaths;
    [self addImages];
    [self addPageControll];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    NSLog(@"%@", _scrollView);
    [self pauseTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 0)];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_scrollView.contentOffset.x > self.frame.size.width)//如果是向右滑动
    {
        if (_pageCtrl.currentPage < _pageCtrl.numberOfPages - 1)//如果滑动前的当前页不是倒数第一页
        {
            _pageCtrl.currentPage++;//当前页自增
            _leftImageIndex = _pageCtrl.currentPage - 1;    //objectAtIndex:pageControl.currentPage -1];//加载当前页前一页的图片
            _middleImageIndex = _pageCtrl.currentPage;//加载当前页的图片
            _rightImageIndex = _pageCtrl.currentPage == (ImagesCount - 1) ? 0 : _pageCtrl.currentPage + 1; //如果滑动完当前页是最后一页，那么当前页下一张图片是第一张图片
            [_titleLabel setText:self.title[_pageCtrl.currentPage]];
            [_titleLabelQ setText:self.title[_pageCtrl.currentPage - 1]];
            [_titleLabelH setText:self.title[_pageCtrl.currentPage == (ImagesCount - 1) ? 0 : _pageCtrl.currentPage + 1]];
        }
        else//如果滑动前的当前页是倒数第一页
        {
            _pageCtrl.currentPage = 0;//设置当前页为0
            _leftImageIndex =  _pageCtrl.numberOfPages - 1;//加载当前页前一页的图片
            _middleImageIndex = 0;//加载当前页的图片
            _rightImageIndex = _pageCtrl.currentPage + 1;//加载当前页下一页的图片
            [_titleLabel setText:self.title[0]];
            [_titleLabelQ setText:self.title[_pageCtrl.numberOfPages - 1]];
            [_titleLabelH setText:self.title[_pageCtrl.currentPage + 1]];
        }
    }
    else if (_scrollView.contentOffset.x < self.frame.size.width)//如果是向左滑动
    {
        if (_pageCtrl.currentPage > 0 )//如果滑动前当前页不是第一页
        {
            _pageCtrl.currentPage--;//当前页自减
            //如果滑动完当前页是第一页，那么当前页的前一张图片是最后一张图片
            _leftImageIndex =_pageCtrl.currentPage == 0 ? _pageCtrl.numberOfPages - 1 : _pageCtrl.currentPage - 1;
            _middleImageIndex = _pageCtrl.currentPage;//加载当前页的图片
            _rightImageIndex = _pageCtrl.currentPage + 1;//加载当前页下一页的图片
            [_titleLabel setText:self.title[_pageCtrl.currentPage]];
            [_titleLabelQ setText:self.title[_pageCtrl.currentPage == 0 ? _pageCtrl.numberOfPages - 1 : _pageCtrl.currentPage - 1]];
            [_titleLabelH setText:self.title[_pageCtrl.currentPage + 1]];
        }
        else
        {
            _pageCtrl.currentPage = _pageCtrl.numberOfPages - 1;
            _leftImageIndex = _pageCtrl.numberOfPages - 2;//加载当前页前一页的图片
            _middleImageIndex = _pageCtrl.numberOfPages - 1;//加载当前页的图片
            _rightImageIndex = 0;//加载当前页下一页的图片
            [_titleLabel setText:self.title[_pageCtrl.currentPage]];
            [_titleLabelQ setText:self.title[_pageCtrl.currentPage - 1]];
            [_titleLabelH setText:self.title[0]];
        }
    }
    _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0.0f);//设置中间图片为可见
    [self setImages];
    if (_isPlay) {
        [self startTimer];
    }
    
    NSLog(@"%@", _scrollView);
}

- (void)addPageControll
{
    if (!_pageCtrl) {
         _pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(5.0f, self.frame.size.height - 10.0f, self.frame.size.width - 10.0f, 5.0f)];
    }
    _pageCtrl.numberOfPages = ImagesCount;
    _pageCtrl.currentPage = 0;
    [self addSubview:_pageCtrl];
}

- (void)setImages {
    if (_imageURLs.count > 0) {
        if (self.imageURLs) {
            [_leftImage sd_setImageWithURL:_imageURLs[_leftImageIndex]];
            [_middleImage sd_setImageWithURL:_imageURLs[_middleImageIndex]];
            [_rightImage sd_setImageWithURL:_imageURLs[_rightImageIndex]];
        }
        else {
            [_leftImage setImage:_imagePaths[_leftImageIndex]];
            [_middleImage setImage:_imagePaths[_middleImageIndex]];
            [_rightImage setImage:_imagePaths[_rightImageIndex]];
        }
    }
}

- (void)startTimer
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:5
                                                   target:self
                                                 selector:@selector(processTimer:)
                                                 userInfo:nil
                                                  repeats:YES];
        
    }
    _timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
}

- (void)pauseTimer
{
    if (_timer && _timer.isValid) {
        _timer.fireDate = [NSDate distantFuture];
    }
}

- (void)stopTimer
{
    if (_timer && _timer.isValid) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)processTimer:(NSTimer *)timer
{
    [self scrollTimer];
}

@end
