//
//  CALayer+GXDevelop.m
//  LOCO
//
//  Created by 高才新 on 15/12/16.
//  Copyright © 2015年 IU-Apps. All rights reserved.
//

#import "CALayer+GXDevelop.h"

@implementation CALayer (GXDevelop)

- (CGFloat)gxX
{
    return CGRectGetMinX(self.frame);
}
- (void)setGxX:(CGFloat)gxX
{
    CGRect frame = self.frame;
    frame.origin.x = gxX;
    self.frame = frame;
}
- (CGFloat)left{
    return self.gxX;
}
- (void)setLeft:(CGFloat)left{
    [self setGxX:left];
}

- (CGFloat)gxY
{
    return CGRectGetMinY(self.frame);
}
- (void)setGxY:(CGFloat)gxY
{
    CGRect frame = self.frame;
    frame.origin.y = gxY;
    self.frame = frame;
}
- (CGFloat)top{
    return self.gxY;
}
- (void)setTop:(CGFloat)top{
    [self setGxY:top];
}
- (CGFloat)gxMaxX
{
    return CGRectGetMaxX(self.frame);
}
- (void)setGxMaxX:(CGFloat)gxMaxX
{
    CGRect frame = self.frame;
    frame.origin.x = gxMaxX-self.gxWidth;
    self.frame = frame;
}
- (CGFloat)right{
    return self.gxMaxX;
}
- (void)setRight:(CGFloat)right{
    [self setGxMaxX:right];
}

- (CGFloat)gxMaxY
{
    return CGRectGetMaxY(self.frame);
}
- (void)setGxMaxY:(CGFloat)gxMaxY
{
    CGRect frame = self.frame;
    frame.origin.y = gxMaxY-self.gxHeight;
    self.frame = frame;
}
- (CGFloat)bottom{
    return self.gxMaxY;
}
- (void)setBottom:(CGFloat)bottom{
    [self setGxMaxY:bottom];
}

- (CGPoint)gxOrigin
{
    return self.frame.origin;
}
- (void)setGxOrigin:(CGPoint)gxOrigin
{
    CGRect frame = self.frame;
    frame.origin = gxOrigin;
    self.frame = frame;
}

//- (CGFloat)gxMidX
//{
//    return CGRectGetMidX(self.frame);
//}
//- (CGFloat)gxMidY
//{
//    return CGRectGetMidY(self.frame);
//}
- (CGSize)gxSize
{
    return self.frame.size;
}
- (void)setGxSize:(CGSize)gxSize
{
    CGRect frame = self.frame;
    frame.size = gxSize;
    self.frame = frame;
}

- (CGFloat)gxWidth
{
    return CGRectGetWidth(self.frame);
}
- (void)setGxWidth:(CGFloat)gxWidth
{
    CGRect frame = self.frame;
    frame.size.width = gxWidth;
    self.frame = frame;
}

- (CGFloat)gxWidthHalf
{
    return CGRectGetWidth(self.frame)/2.0;
}
- (void)setGxWidthHalf:(CGFloat)gxWidthHalf
{
    CGRect frame = self.frame;
    frame.size.width = gxWidthHalf*2;
    self.frame = frame;
}

- (CGFloat)gxHeight
{
    return CGRectGetHeight(self.frame);
}
- (void)setGxHeight:(CGFloat)gxHeight
{
    CGRect frame = self.frame;
    frame.size.height = gxHeight;
    self.frame = frame;
}

- (CGFloat)gxHeightHalf
{
    return CGRectGetHeight(self.frame)/2.0;
}
- (void)setGxHeightHalf:(CGFloat)gxHeightHalf
{
    CGRect frame = self.frame;
    frame.size.height = gxHeightHalf*2;
    self.frame = frame;
}


- (CGFloat)gxBx
{
    return self.bounds.origin.x;
}
- (void)setGxBx:(CGFloat)gxBx
{
    CGRect frame = self.bounds;
    frame.origin.x = gxBx;
    self.bounds = frame;
}
- (CGFloat)gxBy
{
    return self.bounds.origin.y;
}
- (void)setGxBy:(CGFloat)gxBy
{
    CGRect frame = self.bounds;
    frame.origin.y = gxBy;
    self.bounds = frame;
}
- (CGPoint)gxBorigin
{
    return self.bounds.origin;
}
- (void)setGxBorigin:(CGPoint)gxBorigin
{
    CGRect frame = self.bounds;
    frame.origin = gxBorigin;
    self.bounds = frame;
}
- (CGSize)gxBsize
{
    return self.bounds.size;
}
- (void)setGxBsize:(CGSize)gxBsize
{
    CGRect frame = self.bounds;
    frame.size = gxBsize;
    self.bounds = frame;
}

- (CGFloat)gxBwidth
{
    return CGRectGetWidth(self.bounds);
}
- (void)setGxBwidth:(CGFloat)gxBwidth
{
    CGRect frame = self.bounds;
    frame.size.width = gxBwidth;
    self.bounds = frame;
}

- (CGFloat)gxBwidthHalf
{
    return CGRectGetWidth(self.bounds)/2.0;
}
- (void)setGxBwidthHalf:(CGFloat)gxBwidthHalf
{
    CGRect frame = self.bounds;
    frame.size.width = gxBwidthHalf*2;
    self.bounds = frame;
}

- (CGFloat)gxBheight
{
    return CGRectGetHeight(self.bounds);
}
- (void)setGxBheight:(CGFloat)gxBheight
{
    CGRect frame = self.bounds;
    frame.size.height = gxBheight;
    self.bounds = frame;
}

- (CGFloat)gxBheightHalf
{
    return CGRectGetHeight(self.bounds)/2.0;
}
- (void)setGxBheightHalf:(CGFloat)gxBheightHalf
{
    CGRect frame = self.bounds;
    frame.size.height = gxBheightHalf*2;
    self.bounds = frame;
}











- (CGPoint)gxCenter
{
    return CGPointMake(self.gxX+self.gxWidthHalf, self.gxY+self.gxHeightHalf);
}
- (void)setGxCenter:(CGPoint)gxCenter
{
    self.gxOrigin = CGPointMake(gxCenter.x - self.gxWidthHalf, gxCenter.y - self.gxHeightHalf);
}

- (CGPoint)gxCenterIn
{
    return CGPointMake(self.gxWidthHalf, self.gxHeightHalf);
}




-(CGFloat)gxCenterX
{
    return self.gxX+self.gxWidthHalf;
}
- (void)setGxCenterX:(CGFloat)gxCenterX
{
    CGPoint center = self.gxCenter;
    center.x = gxCenterX;
    self.gxCenter = center;
}

- (CGFloat)gxCenterY
{
    return self.gxY+self.gxHeightHalf;
}
- (void)setGxCenterY:(CGFloat)gxCenterY
{
    CGPoint center = self.gxCenter;
    center.y = gxCenterY;
    self.gxCenter = center;
}

- (CGFloat)gxCenterInX
{
    return self.frame.size.width/2.;
}
- (CGFloat)gxCenterInY
{
    return self.frame.size.height/2.;
}

- (UIColor *)gxGetColorFromPoint:(CGPoint)point
{
    unsigned char pixel[4] = {0};
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    //NSLog(@"pixel: %d %d %d %d", pixel[0], pixel[1], pixel[2], pixel[3]);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color;
}

/**
 *  给layer添加阴影
 *
 *  @param color   颜色
 *  @param offset  偏移量
 *  @param blur    blur radius
 *  @param opacity 透明
 *  @param rect    shadowPath
 */
- (void)gxAddShadowWithShadowColor:(CGColorRef)color shadowRadius:(CGFloat)blur shadowOpacity:(CGFloat)opacity shadowPath:(CGRect)rect
{
    self.shadowColor = color;
    self.shadowRadius = blur;
    self.shadowOpacity = opacity;
    self.shadowPath = [UIBezierPath bezierPathWithRect:rect].CGPath;
}

- (void)gxSetRoundRect
{
    self.cornerRadius = self.bounds.size.height * 0.5;
    self.masksToBounds = YES;
}
- (void)gxSetCornerRadius:(CGFloat)radius
{
    self.cornerRadius = radius;
    self.masksToBounds = YES;
}


@end
