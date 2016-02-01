//
//  UIPageControl+GCXDevelop.m
//  LOCO
//
//  Created by 高才新 on 15/12/18.
//  Copyright © 2015年 IU-Apps. All rights reserved.
//

#import "UIPageControl+GCXDevelop.h"

@implementation UIPageControl (GCXDevelop)

- (void)gcxSetWithFrame:(CGRect)frame totalPages:(NSUInteger)totalPages curPage:(NSUInteger)curPage pageColor:(UIColor *)pageColor curPageColor:(UIColor *)curPageColor bgColor:(UIColor *)bgColor {
    self.numberOfPages = totalPages;
    self.currentPage = curPage;
    self.backgroundColor = bgColor;
    self.pageIndicatorTintColor = pageColor;
    self.currentPageIndicatorTintColor = curPageColor;
    self.frame = frame;
}


+ (UIPageControl *)gcxPagetWithFrame:(CGRect)frame totalPages:(NSUInteger)totalPages curPage:(NSUInteger)curPage pageColor:(UIColor *)pageColor curPageColor:(UIColor *)curPageColor bgColor:(UIColor *)bgColor {
    UIPageControl *page = [[UIPageControl alloc] init];
    [page gcxSetWithFrame:frame totalPages:totalPages curPage:curPage pageColor:pageColor curPageColor:curPageColor bgColor:bgColor];
    return page;
}

@end
