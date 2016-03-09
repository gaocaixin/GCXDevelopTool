//
//  UIButton+GCXDevelop.m
//  LOCO
//
//  Created by 高才新 on 15/12/16.
//  Copyright © 2015年 IU-Apps. All rights reserved.
//

#import "UIButton+GCXDevelop.h"
#import <objc/runtime.h>
#define kGcxAddTapRippleEffectColor  @"kGcxAddTapRippleEffectColor"
#define kGcxAddTapRippleEffectDuration  @"kGcxAddTapRippleEffectDuration"

@interface UIButton ()
@property (assign, nonatomic) CGFloat gcxRippleScaleMaxValue;
@end

@implementation UIButton (GCXDevelop)

@dynamic gcxNHDImages;
@dynamic gcxNHDTitles;
@dynamic gcxNHDTitleColors;
@dynamic gcxNSDImages;

static char gcxRippleColor;
static char gcxRippleDuration;
static char RippleScaleMaxValue;




- (void)gcxSetRippleColor:(UIColor *)rippleColor
{
    objc_setAssociatedObject(self, &gcxRippleColor, rippleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIColor *)gcxGetRippleColor
{
    return objc_getAssociatedObject(self, &gcxRippleColor);
}
- (void)gcxSetRippleDuration:(CGFloat)rippleDuration
{
    objc_setAssociatedObject(self, &gcxRippleDuration, @(rippleDuration), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)gcxGetRippleDuration
{
    return [objc_getAssociatedObject(self, &gcxRippleDuration) floatValue];
}

- (void)setGcxRippleScaleMaxValue:(CGFloat)gcxRippleScaleMaxValue
{
    objc_setAssociatedObject(self, &RippleScaleMaxValue, @(gcxRippleScaleMaxValue), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)gcxRippleScaleMaxValue
{
    return [objc_getAssociatedObject(self, &RippleScaleMaxValue) floatValue];
}

- (void)setGcxNHDTitles:(NSArray *)gcxNHDTitles
{
    [self gcxEnumerateArray:gcxNHDTitles UsingBlock:^(id obj, NSUInteger idx, BOOL *stop, UIControlState buttonState) {
        [self setTitle:obj forState:buttonState];
    }];
}
- (void)setGcxNHDImages:(NSArray *)gcxNHDImages
{
    [self gcxEnumerateArray:gcxNHDImages UsingBlock:^(id obj, NSUInteger idx, BOOL *stop, UIControlState buttonState) {
        [self setImage:obj forState:buttonState];
    }];
}
- (void)setGcxNHDTitleColors:(NSArray *)gcxNHDTitleColors
{
    [self gcxEnumerateArray:gcxNHDTitleColors UsingBlock:^(id obj, NSUInteger idx, BOOL *stop, UIControlState buttonState) {
        [self setTitleColor:obj forState:buttonState];
    }];
}

- (void)setGcxNSDImages:(NSArray *)gcxNSDImages
{
    [self gcxEnumerateNSDArray:gcxNSDImages UsingBlock:^(id obj, NSUInteger idx, BOOL *stop, UIControlState buttonState) {
        [self setImage:obj forState:buttonState];
    }];
}
- (void)gcxEnumerateNSDArray:(NSArray *)array UsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop, UIControlState buttonState))block
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

- (void)gcxEnumerateArray:(NSArray *)array UsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop, UIControlState buttonState))block
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

- (void)gcxSetNHDWithImages:(NSArray *)gcxNHDImages colors:(NSArray *)gcxNHDTitleColors titles:(NSArray *)gcxNHDTitles {
    self.gcxNHDImages = gcxNHDImages;
    self.gcxNHDTitles = gcxNHDTitles;
    self.gcxNHDTitleColors = gcxNHDTitleColors;
}

- (void)gcxSetNHDWithFont:(UIFont *)font colors:(NSArray *)gcxNHDTitleColors titles:(NSArray *)gcxNHDTitles {
    self.gcxNHDTitles = gcxNHDTitles;
    self.gcxNHDTitleColors = gcxNHDTitleColors;
    self.titleLabel.font = font;
}




- (void)gcxAddTapRippleEffectWithColor:(UIColor *)color scaleMaxValue:(CGFloat)value duration:(CGFloat)duration
{
    [self gcxSetRippleColor:color];
    [self gcxSetRippleDuration:duration];
    self.gcxRippleScaleMaxValue = value;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRipple)];
    [self addGestureRecognizer:tap];
}
- (void)tapRipple {

    
//    NSLog(@"%@", self.layer.sublayers);
    UIColor *effectColor = [self gcxGetRippleColor];
    CGFloat animationDurtion = [self gcxGetRippleDuration];
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
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(self.gcxRippleScaleMaxValue, self.gcxRippleScaleMaxValue, 1)];
    
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
