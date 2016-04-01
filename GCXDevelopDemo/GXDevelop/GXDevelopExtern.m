//
//  GXDevelopExtern.m
//  GXDevelopDemo
//
//  Created by 高才新 on 16/3/29.
//  Copyright © 2016年 高才新. All rights reserved.
//

#import "GXDevelopExtern.h"
#import "GXDevelopKey.h"

@implementation GXDevelopExtern

//@dynamic gxScreenWidth;

+ (instancetype)sharedExtern
{
    static GXDevelopExtern *sharedExtern = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedExtern = [[self alloc] init];
    });
    return sharedExtern;
}

- (CGFloat)gxScreenWidth
{
    [self refreshDataIfNeed];
    return _gxScreenWidth;
}
- (CGFloat)gxScreenHeight
{
    [self refreshDataIfNeed];
    return _gxScreenHeight;
}
- (CGFloat)gxScreenWidthRatio
{
    [self refreshDataIfNeed];
    return _gxScreenWidthRatio;
}
- (CGFloat)gxScreenHeightRatio
{
    [self refreshDataIfNeed];
    return _gxScreenHeightRatio;
}
- (CGFloat)gxScreenMinRatio
{
    [self refreshDataIfNeed];
    return _gxScreenMinRatio;
}
- (CGFloat)gxScreenMaxRatio
{
    [self refreshDataIfNeed];
    return _gxScreenMaxRatio;
}

- (void)refreshDataIfNeed
{
    if (_gxScreenWidth == 0) {
        [self refreshData];
    }
}

- (void)refreshData
{
    
    _gxScreenWidth = [UIScreen mainScreen].bounds.size.width;
    _gxScreenHeight = [UIScreen mainScreen].bounds.size.height;
    if (_gxScreenHeight > _gxScreenWidth) { // 竖屏
        _gxScreenWidthRatio = _gxScreenWidth/GXDesignSize.width;
        _gxScreenHeightRatio = _gxScreenHeight/GXDesignSize.height;
    } else { // 横屏
        _gxScreenWidthRatio = _gxScreenWidth/GXDesignSize.height;
        _gxScreenHeightRatio = _gxScreenHeight/GXDesignSize.width;
    }
    _gxScreenMinRatio = MIN(_gxScreenWidthRatio, _gxScreenHeightRatio);
    _gxScreenMaxRatio = MAX(_gxScreenWidthRatio, _gxScreenHeightRatio);
}

@end
