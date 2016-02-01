//
//  UIView+GCXDevelopAnimation.m
//  LOCO
//
//  Created by 高才新 on 15/12/24.
//  Copyright © 2015年 IU-Apps. All rights reserved.
//

#import "UIView+GCXDevelopAnimation.h"

@implementation UIView (GCXDevelopAnimation)


- (void)gcxAddNotStopRotateAnimationDuration:(CGFloat)duration key:(NSString *)key{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = @(0);
    rotationAnimation.toValue = @(M_PI * 2.0);
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = CGFLOAT_MAX;
    [self.layer addAnimation:rotationAnimation forKey:key];
}


- (CAAnimation *)gcxShakeAnimationWithShakeValue:(CGFloat)value duration:(CGFloat)duration {
    
    CAKeyframeAnimation * shake = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    [shake setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [shake setDuration:value];
    [shake setValues:@[ @(-duration), @(duration), @(-duration), @(duration), @(-duration/2), @(duration/2), @(-duration/4), @(duration/4), @(0) ]];
    return shake;
}

@end
