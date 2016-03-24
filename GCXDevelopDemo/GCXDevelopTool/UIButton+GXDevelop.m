//
//  UIButton+GXDevelop.m
//  LOCO
//
//  Created by 高才新 on 15/12/16.
//  Copyright © 2015年 IU-Apps. All rights reserved.
//

#import "UIButton+GXDevelop.h"
#import <objc/runtime.h>
#define kGcxAddTapRippleEffectColor  @"kGcxAddTapRippleEffectColor"
#define kGcxAddTapRippleEffectDuration  @"kGcxAddTapRippleEffectDuration"

@interface UIButton ()
@property (assign, nonatomic) CGFloat gxRippleScaleMaxValue;
@end

@implementation UIButton (GXDevelop)

@dynamic gxNHDImages;
@dynamic gxNHDTitles;
@dynamic gxNHDTitleColors;
@dynamic gxNSDImages;

static char gxRippleColor;
static char gxRippleDuration;
static char RippleScaleMaxValue;




- (void)gxSetRippleColor:(UIColor *)rippleColor
{
    objc_setAssociatedObject(self, &gxRippleColor, rippleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIColor *)gxGetRippleColor
{
    return objc_getAssociatedObject(self, &gxRippleColor);
}
- (void)gxSetRippleDuration:(CGFloat)rippleDuration
{
    objc_setAssociatedObject(self, &gxRippleDuration, @(rippleDuration), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)gxGetRippleDuration
{
    return [objc_getAssociatedObject(self, &gxRippleDuration) floatValue];
}

- (void)setGcxRippleScaleMaxValue:(CGFloat)gxRippleScaleMaxValue
{
    objc_setAssociatedObject(self, &RippleScaleMaxValue, @(gxRippleScaleMaxValue), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)gxRippleScaleMaxValue
{
    return [objc_getAssociatedObject(self, &RippleScaleMaxValue) floatValue];
}

- (void)setGcxNHDTitles:(NSArray *)gxNHDTitles
{
    [self gxEnumerateArray:gxNHDTitles UsingBlock:^(id obj, NSUInteger idx, BOOL *stop, UIControlState buttonState) {
        [self setTitle:obj forState:buttonState];
    }];
}
- (void)setGcxNHDImages:(NSArray *)gxNHDImages
{
    [self gxEnumerateArray:gxNHDImages UsingBlock:^(id obj, NSUInteger idx, BOOL *stop, UIControlState buttonState) {
        if ([obj  isEqual: @(0)]) {
            obj = nil;
        }
        [self setImage:obj forState:buttonState];
    }];
}
- (void)setGcxNHDTitleColors:(NSArray *)gxNHDTitleColors
{
    [self gxEnumerateArray:gxNHDTitleColors UsingBlock:^(id obj, NSUInteger idx, BOOL *stop, UIControlState buttonState) {
        [self setTitleColor:obj forState:buttonState];
    }];
}

- (void)setGcxNSDImages:(NSArray *)gxNSDImages
{
    [self gxEnumerateNSDArray:gxNSDImages UsingBlock:^(id obj, NSUInteger idx, BOOL *stop, UIControlState buttonState) {
        [self setImage:obj forState:buttonState];
    }];
}
- (void)gxEnumerateNSDArray:(NSArray *)array UsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop, UIControlState buttonState))block
{
    __block UIControlState state = 0;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            state = UIControlStateNormal;
        } else if (idx == 1) {
            state = UIControlStateSelected;
        }else if (idx == 2) {
            state = UIControlStateDisabled;
        }else if(idx == 3) {
            //            state = UIControlStateDisabled;
        }
        if (block) {
            block(obj, idx, stop, state);
        }
    }];
}

- (void)gxEnumerateArray:(NSArray *)array UsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop, UIControlState buttonState))block
{
    __block UIControlState state = 0;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            state = UIControlStateNormal;
        } else if (idx == 1) {
            state = UIControlStateHighlighted;
        }else if (idx == 2) {
            state = UIControlStateDisabled;
        }else if(idx == 3) {
//            state = UIControlStateDisabled;
        }
        if (block) {
            block(obj, idx, stop, state);
        }
    }];
}

- (void)gxSetNHDWithImages:(NSArray *)gxNHDImages colors:(NSArray *)gxNHDTitleColors titles:(NSArray *)gxNHDTitles {
    self.gxNHDImages = gxNHDImages;
    self.gxNHDTitles = gxNHDTitles;
    self.gxNHDTitleColors = gxNHDTitleColors;
}

- (void)gxSetNHDWithFont:(UIFont *)font colors:(NSArray *)gxNHDTitleColors titles:(NSArray *)gxNHDTitles {
    self.gxNHDTitles = gxNHDTitles;
    self.gxNHDTitleColors = gxNHDTitleColors;
    self.titleLabel.font = font;
}




- (void)gxAddTapRippleEffectWithColor:(UIColor *)color scaleMaxValue:(CGFloat)value duration:(CGFloat)duration
{
    [self gxSetRippleColor:color];
    [self gxSetRippleDuration:duration];
    self.gxRippleScaleMaxValue = value;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRipple)];
    [self addGestureRecognizer:tap];
}
- (void)tapRipple {

    
//    NSLog(@"%@", self.layer.sublayers);
    UIColor *effectColor = [self gxGetRippleColor];
    CGFloat animationDurtion = [self gxGetRippleDuration];
    // 圆圈动画
    UIColor *stroke = effectColor?effectColor:[UIColor colorWithWhite:0.8 alpha:0.8];

    CGRect pathFrame = CGRectMake(-CGRectGetMidX(self.bounds), -CGRectGetMidY(self.bounds), self.bounds.size.width, self.bounds.size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:self.layer.cornerRadius];
    
    CGPoint shapePosition = [self convertPoint:self.center fromView:nil];
    
    CAShapeLayer *circleShape = [CAShapeLayer layer];
    circleShape.path = path.CGPath;
    circleShape.position = shapePosition;
    circleShape.fillColor = [UIColor clearColor].CGColor;
    circleShape.opacity = 0;
    circleShape.strokeColor = stroke.CGColor;
    circleShape.lineWidth = 3;
    
//    [self.layer addSublayer:circleShape];
    [self.layer insertSublayer:circleShape atIndex:0];
    
    self.layer.masksToBounds = NO;
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(self.gxRippleScaleMaxValue, self.gxRippleScaleMaxValue, 1)];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue = @0;
    
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = @[scaleAnimation, alphaAnimation];
    animation.duration = animationDurtion;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.delegate = self;
    [circleShape addAnimation:animation forKey:@"tapRipple"];
    
    // tap 事件覆盖 control 事件  需要手动执行control 事件
    id target = [self.allTargets anyObject];
    UIControlEvents event = self.allControlEvents;
    NSArray *actions = [self actionsForTarget:target forControlEvent:event];
    NSString * actionStr = [actions lastObject];
    SEL action = NSSelectorFromString(actionStr);
    if ([target respondsToSelector:action]) {
        [target performSelectorOnMainThread:action withObject:self waitUntilDone:NO];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.layer.sublayers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CAShapeLayer class]]) {
            [obj removeFromSuperlayer];
            *stop = YES;
        }
    }];
}




@end
