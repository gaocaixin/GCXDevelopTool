//
//  UIView+GXDevelop.m
//  LOCO
//
//  Created by 高才新 on 16/1/28.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import "UIView+GXDevelop.h"

@implementation UIView (GXDevelop)

- (CGFloat)gxMinX
{
    return CGRectGetMinX(self.frame);
}
- (CGFloat)gxMinY
{
    return CGRectGetMinY(self.frame);
}
- (CGFloat)gxMaxX
{
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)gxMaxY
{
    return CGRectGetMaxY(self.frame);
}
- (CGFloat)gxMidX
{
    return CGRectGetMidX(self.frame);
}
- (CGFloat)gxMidY
{
    return CGRectGetMidY(self.frame);
}
- (CGFloat)gxWidth
{
    return CGRectGetWidth(self.frame);
}
- (CGFloat)gxWidthHalf
{
    return CGRectGetWidth(self.frame)/2.0;
}
- (CGFloat)gxHeight
{
    return CGRectGetHeight(self.frame);
}
- (CGFloat)gxHeightHalf
{
    return CGRectGetHeight(self.frame)/2.0;
}

- (void)setGxMinX:(CGFloat)gxMinX
{
    CGRect frame = self.frame;
    frame.origin.x = gxMinX;
    self.frame = frame;
}
- (void)setGxMinY:(CGFloat)gxMinY
{
    CGRect frame = self.frame;
    frame.origin.y = gxMinY;
    self.frame = frame;
}
- (void)setGxMaxX:(CGFloat)gxMaxX
{
    CGRect frame = self.frame;
    frame.origin.x = gxMaxX-self.gxWidth;
    self.frame = frame;
}
- (void)setGxMaxY:(CGFloat)gxMaxY
{
    CGRect frame = self.frame;
    frame.origin.y = gxMaxY-self.gxHeight;
    self.frame = frame;
}
- (void)setGxMidX:(CGFloat)gxMidX
{
    CGRect frame = self.frame;
    frame.origin.x = gxMidX-self.gxWidthHalf;
    self.frame = frame;
}
- (void)setGxMidY:(CGFloat)gxMidY
{
    CGRect frame = self.frame;
    frame.origin.y = gxMidY - self.gxHeightHalf;
    self.frame = frame;
}
- (void)setGxHeight:(CGFloat)gxHeight
{
    CGRect frame = self.frame;
    frame.size.height = gxHeight;
    self.frame = frame;
}
- (void)setGxWidth:(CGFloat)gxWidth
{
    CGRect frame = self.frame;
    frame.size.width = gxWidth;
    self.frame = frame;
}
- (void)setGxHeightHalf:(CGFloat)gxHeightHalf
{
    CGRect frame = self.frame;
    frame.size.height = gxHeightHalf*2;
    self.frame = frame;
}
- (void)setGxWidthHalf:(CGFloat)gxWidthHalf
{
    CGRect frame = self.frame;
    frame.size.width = gxWidthHalf*2;
    self.frame = frame;
}

- (CGSize)gxSize
{
    return self.frame.size;
}
- (CGPoint)gxCenter
{
    return self.center;
}
- (void)setGxSize:(CGSize)gxSize
{
    CGRect frame = self.frame;
    frame.size = gxSize;
    self.frame = frame;
}
- (void)setGxCenter:(CGPoint)gxCenter
{
    self.center = gxCenter;
}

- (UIColor *)gxGetColorFromPoint:(CGPoint)point
{
    unsigned char pixel[4] = {0};
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    //NSLog(@"pixel: %d %d %d %d", pixel[0], pixel[1], pixel[2], pixel[3]);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color;
}

@end
