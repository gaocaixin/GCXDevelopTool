//
//  UIView+GCXDevelopAnimation.m
//  LOCO
//
//  Created by 高才新 on 15/12/24.
//  Copyright © 2015年 IU-Apps. All rights reserved.
//

#import "UIView+GCXDevelopAnimation.h"

@implementation UIView (GCXDevelopAnimation)


- (CABasicAnimation *)gcxAddNotStopRotateAnimationDuration:(CGFloat)duration key:(NSString *)key
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = @(0);
    rotationAnimation.toValue = @(M_PI * 2.0);
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = CGFLOAT_MAX;
    [self.layer addAnimation:rotationAnimation forKey:key];
    return rotationAnimation;
}


- (CAAnimation *)gcxShakeAnimationWithShakeValue:(CGFloat)value duration:(CGFloat)duration key:(NSString *)key
{
    
    CAKeyframeAnimation * shake = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    [shake setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [shake setDuration:duration];
    [shake setValues:@[ @(-value), @(value), @(-value), @(value), @(-value/2), @(value/2), @(-value/4), @(value/4), @(0) ]];
    [self.layer addAnimation:shake forKey:key];
    return shake;
}

@end
