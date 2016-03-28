//
//  GXFrameInButton.m
//  LOCO
//
//  Created by 高才新 on 16/2/26.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import "GXFrameInButton.h"

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


@end
