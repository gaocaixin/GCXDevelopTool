//
//  UIBezierPath+GXDevelop.h
//  GXDevelopDemo
//
//  Created by 高才新 on 16/3/31.
//  Copyright © 2016年 高才新. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *渐变的方向
 */
typedef enum : NSUInteger {
    GXBezierPathRemoveSemicircularDirectionTop,
    GXBezierPathRemoveSemicircularDirectionDown,
    GXBezierPathRemoveSemicircularDirectionLeft,
    GXBezierPathRemoveSemicircularDirectionRight
} GXBezierPathRemoveSemicircularDirectionOption;

@interface UIBezierPath (GXDevelop)

/**
 *放回一个UIBezierPath. 矩形去掉莫一边半圆的 path   用于绘制图形
 */
+ (UIBezierPath *)gxBezierPathRectRemoveSemicircular:(CGRect)rect directionOption:(GXBezierPathRemoveSemicircularDirectionOption)directionOption;
+ (CGFloat)getAnglesWithThreePoint:(CGPoint)pointA pointB:(CGPoint)pointB pointC:(CGPoint)pointC;

/**
 *根据点 返回一个近似的曲线 带控制点
 */

+(UIBezierPath *)gxInterpolateCGPointsWithCatmullRom:(NSArray *)pointsAsNSValues closed:(BOOL)closed alpha:(float)alpha;
+(UIBezierPath *)gxInterpolateCGPointsWithHermite:(NSArray *)pointsAsNSValues closed:(BOOL)closed;

/*
 *获取给定点的直线拟合曲线 算法Catmull-Rom 实用性高 特点: 经过控制点  granularity值越高 拟合度越高 point 个数必须>=4
 */
+ (UIBezierPath*)gxSmoothedPathWithPoints:(NSArray *)pathpoints Granularity:(NSInteger)granularity;
// 改良后直接获取点
+ ( NSArray*)gxSmoothedPointsWithPoints:(NSArray *)pathpoints Granularity:(NSInteger)granularity;


@end
