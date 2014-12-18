//
//  moto_BannerView.h
//  Moto
//
//  Created by KthRee on 13-12-4.
//  Copyright (c) 2013年 agile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATBannerView : UIView <UIScrollViewDelegate>

@property (nonatomic, strong)NSArray *imageURLs;
@property (nonatomic, strong)NSArray *imagePaths;
@property (nonatomic, retain)NSArray *title;
@property (nonatomic, strong)UIPageControl *pageCtrl;
@property (nonatomic, assign)int second;
@property (nonatomic, assign)BOOL isPlay;

- (void)reloadImages;

- (void)setPageIndicatorTintColor:(UIColor *)indicatorColor currentPageIndicatorTintColor:(UIColor *)currentPageColor;

- (void)stopTimer;

@end
