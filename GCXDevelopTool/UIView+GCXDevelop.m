//
//  UIView+GCXDevelop.m
//  LOCO
//
//  Created by 高才新 on 16/1/28.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import "UIView+GCXDevelop.h"

@implementation UIView (GCXDevelop)

- (CGFloat)gcxMinX
{
    return CGRectGetMinX(self.frame);
}
- (CGFloat)gcxMinY
{
    return CGRectGetMinY(self.frame);
}
- (CGFloat)gcxMaxX
{
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)gcxMaxY
{
    return CGRectGetMaxY(self.frame);
}
- (CGFloat)gcxMidX
{
    return CGRectGetMidX(self.frame);
}
- (CGFloat)gcxMidY
{
    return CGRectGetMidY(self.frame);
}
- (CGFloat)gcxWidth
{
    return CGRectGetWidth(self.frame);
}
- (CGFloat)gcxWidthHalf
{
    return CGRectGetWidth(self.frame)/2.0;
}
- (CGFloat)gcxHeight
{
    return CGRectGetHeight(self.frame);
}
- (CGFloat)gcxHeightHalf
{
    return CGRectGetHeight(self.frame)/2.0;
}

- (void)setGcxMinX:(CGFloat)gcxMinX
{
    CGRect frame = self.frame;
    frame.origin.x = gcxMinX;
    self.frame = frame;
}
- (void)setGcxMinY:(CGFloat)gcxMinY
{
    CGRect frame = self.frame;
    frame.origin.y = gcxMinY;
    self.frame = frame;
}
- (void)setGcxMaxX:(CGFloat)gcxMaxX
{
    CGRect frame = self.frame;
    frame.origin.x = gcxMaxX-self.gcxWidth;
    self.frame = frame;
}
- (void)setGcxMaxY:(CGFloat)gcxMaxY
{
    CGRect frame = self.frame;
    frame.origin.y = gcxMaxY-self.gcxHeight;
    self.frame = frame;
}
- (void)setGcxMidX:(CGFloat)gcxMidX
{
    CGRect frame = self.frame;
    frame.origin.x = gcxMidX-self.gcxWidthHalf;
    self.frame = frame;
}
- (void)setGcxMidY:(CGFloat)gcxMidY
{
    CGRect frame = self.frame;
    frame.origin.y = gcxMidY - self.gcxHeightHalf;
    self.frame = frame;
}
- (void)setGcxHeight:(CGFloat)gcxHeight
{
    CGRect frame = self.frame;
    frame.size.height = gcxHeight;
    self.frame = frame;
}
- (void)setGcxWidth:(CGFloat)gcxWidth
{
    CGRect frame = self.frame;
    frame.size.width = gcxWidth;
    self.frame = frame;
}
- (void)setGcxHeightHalf:(CGFloat)gcxHeightHalf
{
    CGRect frame = self.frame;
    frame.size.height = gcxHeightHalf*2;
    self.frame = frame;
}
- (void)setGcxWidthHalf:(CGFloat)gcxWidthHalf
{
    CGRect frame = self.frame;
    frame.size.width = gcxWidthHalf*2;
    self.frame = frame;
}

- (CGSize)gcxSize
{
    return self.frame.size;
}
- (CGPoint)gcxCenter
{
    return self.center;
}
- (void)setGcxSize:(CGSize)gcxSize
{
    CGRect frame = self.frame;
    frame.size = gcxSize;
    self.frame = frame;
}
- (void)setGcxCenter:(CGPoint)gcxCenter
{
    self.center = gcxCenter;
}

- (UIColor *)gcxGetColorFromPoint:(CGPoint)point
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
