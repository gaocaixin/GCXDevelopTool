//
//  GCXFrameInButton.m
//  LOCO
//
//  Created by 高才新 on 16/2/26.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import "GCXFrameInButton.h"

@implementation GCXFrameInButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _gcxTitleLabelFrame  = CGRectZero;
        _gcxImageViewFrame = CGRectZero;

    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if ([NSStringFromCGRect(_gcxTitleLabelFrame) isEqualToString:NSStringFromCGRect(CGRectZero)]) {
        return [super titleRectForContentRect:contentRect];
    } else {
        return _gcxTitleLabelFrame;
    }
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if ([NSStringFromCGRect(_gcxImageViewFrame) isEqualToString:NSStringFromCGRect(CGRectZero)]) {
        return [super imageRectForContentRect:contentRect];
    } else {
        return _gcxImageViewFrame;
    }
}


@end
