//
//  UIScrollView+GXDevelop.m
//  LiPix
//
//  Created by 小新 on 16/12/5.
//  Copyright © 2016年 Alpha Mobile. All rights reserved.
//

#import "UIScrollView+GXDevelop.h"
#import "UIView+GXDevelop.h"

@implementation UIScrollView (GXDevelop)

- (void)gxScrollToCenterPoint:(CGPoint)point animation:(CGFloat)animationtime isNeedEmpty:(BOOL)empty 
{
    CGFloat centery = point.y;
    CGFloat scrollY = centery - self.gxHeight /2.;
    if (!empty) {
        scrollY = MIN(scrollY, self.contentSize.height-self.gxHeight);
        scrollY = MAX(0, scrollY);
    }
    
    CGFloat centerx = point.x;
    CGFloat scrollx = centerx - self.gxWidth /2.;
    if (!empty) {
        scrollx = MIN(scrollx, self.contentSize.width-self.gxWidth);
        scrollx = MAX(0, scrollx);
    }

    [UIView animateWithDuration:animationtime animations:^{
        self.contentOffset = CGPointMake(scrollx, scrollY);
    }];
}

@end
