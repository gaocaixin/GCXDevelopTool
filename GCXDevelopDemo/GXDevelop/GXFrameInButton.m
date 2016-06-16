//
//  GXFrameInButton.m
//  LOCO
//
//  Created by 高才新 on 16/2/26.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import "GXFrameInButton.h"
#import "UIButton+GXDevelop.h"

@implementation GXFrameInButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _gxTitleLabelFrame  = CGRectZero;
        _gxImageViewFrame = CGRectZero;

    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if ([NSStringFromCGRect(_gxTitleLabelFrame) isEqualToString:NSStringFromCGRect(CGRectZero)]) {
        return [super titleRectForContentRect:contentRect];
    } else {
        return _gxTitleLabelFrame;
    }
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if ([NSStringFromCGRect(_gxImageViewFrame) isEqualToString:NSStringFromCGRect(CGRectZero)]) {
        return [super imageRectForContentRect:contentRect];
    } else {
        return _gxImageViewFrame;
    }
}

- (void)setGxTitleLabelFrame:(CGRect)gxTitleLabelFrame
{
    _gxTitleLabelFrame = gxTitleLabelFrame;
    [self setNeedsDisplay];
}
- (void)setGxImageViewFrame:(CGRect)gxImageViewFrame
{
    _gxImageViewFrame = gxImageViewFrame;
    [self setNeedsDisplay];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    if (_isExchangePosition) {
        [self gxExchangePositionLableAndImageWithInterval:5];
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (_isAnimationClick) {
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            if (highlighted) {
                self.transform = CGAffineTransformMakeScale(0.9, 0.9);
            } else {
                self.transform = CGAffineTransformIdentity;
            }
        } completion:^(BOOL finished) {
            
        }];
    }
}

@end
