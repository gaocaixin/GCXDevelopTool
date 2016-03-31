//
//  UIView+GXDevelop.m
//  LOCO
//
//  Created by 高才新 on 16/1/28.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import "UIView+GXDevelop.h"
#import <objc/runtime.h>

@interface UIView ()

@property (strong, nonatomic) CAGradientLayer *slideHighlightLayer;
@property (nonatomic) NSNumber * slideHighlightedDurtion;
@property (nonatomic) NSNumber * slideHighlightedScale;
@property (nonatomic) NSNumber * slideHighlightedInterval;
@property (nonatomic) NSNumber * slideHighlightedRepeatCount;

@end

@implementation UIView (GXDevelop)



- (CGFloat)gxX
{
    return CGRectGetMinX(self.frame);
}
- (CGFloat)gxY
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
//- (CGFloat)gxMidX
//{
//    return CGRectGetMidX(self.frame);
//}
//- (CGFloat)gxMidY
//{
//    return CGRectGetMidY(self.frame);
//}
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

- (void)setGxX:(CGFloat)gxX
{
    CGRect frame = self.frame;
    frame.origin.x = gxX;
    self.frame = frame;
}
- (void)setGxY:(CGFloat)gxY
{
    CGRect frame = self.frame;
    frame.origin.y = gxY;
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
-(CGFloat)gxCenterX
{
    return self.center.x;
}
- (CGFloat)gxCenterY
{
    return self.center.y;
}
- (void)setGxCenterX:(CGFloat)gxCenterX
{
    CGPoint center = self.center;
    center.x = gxCenterX;
    self.center = center;
}
- (void)setGxCenterY:(CGFloat)gxCenterY
{
    CGPoint center = self.center;
    center.y = gxCenterY;
    self.center = center;
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
    
    [self.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    //NSLog(@"pixel: %d %d %d %d", pixel[0], pixel[1], pixel[2], pixel[3]);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color;
}

// 添加高光
- (CAGradientLayer *)slideHighlightLayer
{
    return objc_getAssociatedObject(self, @selector(slideHighlightLayer));
}
- (void)setSlideHighlightLayer:(CAGradientLayer *)slideHighlightLayer
{
    objc_setAssociatedObject(self, @selector(slideHighlightLayer), slideHighlightLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSNumber *)slideHighlightedDurtion
{
    return objc_getAssociatedObject(self, @selector(slideHighlightedDurtion));
}
- (void)setSlideHighlightedDurtion:(NSNumber *)slideHighlightedDurtion
{
    objc_setAssociatedObject(self, @selector(slideHighlightedDurtion), slideHighlightedDurtion, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSNumber *)slideHighlightedInterval
{
    return objc_getAssociatedObject(self, @selector(slideHighlightedInterval));
}
- (void)setSlideHighlightedInterval:(NSNumber *)slideHighlightedInterval
{
    objc_setAssociatedObject(self, @selector(slideHighlightedInterval), slideHighlightedInterval, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSNumber *)slideHighlightedRepeatCount
{
    return objc_getAssociatedObject(self, @selector(slideHighlightedRepeatCount));
}
- (void)setSlideHighlightedRepeatCount:(NSNumber *)slideHighlightedRepeatCount
{
    objc_setAssociatedObject(self, @selector(slideHighlightedRepeatCount), slideHighlightedRepeatCount, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSNumber *)slideHighlightedScale
{
    return objc_getAssociatedObject(self, @selector(slideHighlightedScale));
}
- (void)setSlideHighlightedScale:(NSNumber *)slideHighlightedScale
{
    objc_setAssociatedObject(self, @selector(slideHighlightedScale), slideHighlightedScale, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAGradientLayer *)gxAddSlideHighlightedEffectWithHighlightedColor:(UIColor *)highlightColor lowlightColor:(UIColor *)lowlightColor scale:(CGFloat)scale animDuration:(CGFloat)duration animInterval:(CGFloat)interval animRepeatCount:(NSInteger)repeatCount
{
    if (!highlightColor) {
        highlightColor = [UIColor whiteColor];
    }
    if (!lowlightColor) {
        lowlightColor = [UIColor blackColor];
    }
    if (!scale) {
        scale = 0.25;
    }
    if (!duration) {
        duration = 2.2;
    }
    if (!interval) {
        interval = 1;
    }
    if (!repeatCount) {
        repeatCount = MAXFLOAT;
    }
    self.slideHighlightedDurtion = @(duration);
    self.slideHighlightedInterval = @(interval);
    self.slideHighlightedRepeatCount = @(repeatCount);
    self.slideHighlightedScale = @(scale);
    
    CAGradientLayer *layerGr = [[CAGradientLayer alloc] init];
    layerGr.frame = self.frame;
    [self.superview.layer addSublayer:layerGr];
    self.slideHighlightLayer = layerGr;
    layerGr.colors = @[(__bridge id)lowlightColor.CGColor ,(__bridge id)highlightColor.CGColor ,(__bridge id)lowlightColor.CGColor];
    layerGr.locations = @[@(-scale*2), @(-scale), @(0)];
    layerGr.startPoint = CGPointMake(0, 0);
    layerGr.endPoint = CGPointMake(1, 0);
    
    layerGr.mask = self.layer;
    self.frame = layerGr.bounds;
    
    [self slideHighlightedEffectAnimation];
    
    return layerGr;
}

- (void)slideHighlightedEffectAnimation
{
    CABasicAnimation* fadeAnim = [CABasicAnimation animationWithKeyPath:@"locations"];
    fadeAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    fadeAnim.removedOnCompletion = NO;
    fadeAnim.repeatCount = self.slideHighlightedRepeatCount.integerValue ;
    //    fadeAnim.repeatCount = 1;
    fadeAnim.beginTime = CACurrentMediaTime()+ self.slideHighlightedInterval.floatValue;
    CGFloat scale = self.slideHighlightedScale.floatValue;
    fadeAnim.fromValue = @[@(-scale*2), @(-scale), @(0)];
    fadeAnim.toValue   = @[@(1.0), @(1+scale), @(1+scale*2)];
    fadeAnim.duration  = self.slideHighlightedDurtion.floatValue;
    fadeAnim.delegate = self;
    [self.slideHighlightLayer addAnimation:fadeAnim forKey:@"slideHighlightedEffectAnimation"];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
//    if (self.slideHighlightedRepeatCount.intValue > 0) {
//        [self slideHighlightedEffectAnimation];
//        int count  = self.slideHighlightedRepeatCount.intValue;
//        self.slideHighlightedRepeatCount = @(count-1);
//    }
}
- (void)gxAddSlideHighlightedEffect
{
    [self gxAddSlideHighlightedEffectWithHighlightedColor:nil lowlightColor:nil scale:0 animDuration:0 animInterval:0 animRepeatCount:0];
}
@end
