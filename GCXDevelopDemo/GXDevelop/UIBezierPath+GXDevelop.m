//
//  UIBezierPath+GXDevelop.m
//  GXDevelopDemo
//
//  Created by 高才新 on 16/3/31.
//  Copyright © 2016年 高才新. All rights reserved.
//

#import "UIBezierPath+GXDevelop.h"
#import "GXDevelopKey.h"
#import "CGPointExtension.h"

#define UIBezierPathkEPSILON 1.0e-5

@implementation UIBezierPath (GXDevelop)

+ (UIBezierPath *)gxBezierPathRectRemoveSemicircular:(CGRect)rect directionOption:(GXBezierPathRemoveSemicircularDirectionOption)directionOption
{
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    
    CGPoint pathPoint0 = CGPointMake(0, 0);;
    CGPoint pathPoint1 = CGPointMake(w/2., w/2.);
    CGPoint pathPoint2 = CGPointMake(w, 0);
    CGPoint pathPoint3 = CGPointMake(w, h);
    CGPoint pathPoint4 = CGPointMake(0, h);
    
    CGPoint controlPoint0 = CGPointMake(0, w/4.);
    CGPoint controlPoint1 = CGPointMake(w/4., w/2.);
    CGPoint controlPoint2 = CGPointMake(w/4.*3, w/2.);
    CGPoint controlPoint3 = CGPointMake(w, w/4.);
    

    switch (directionOption) {
        case GXBezierPathRemoveSemicircularDirectionTop:
        {
            pathPoint0 = CGPointMake(0, 0);
            pathPoint1 = CGPointMake(w/2., w/2.);
            pathPoint2 = CGPointMake(w, 0);
            pathPoint3 = CGPointMake(w, h);
            pathPoint4 = CGPointMake(0, h);
            
            controlPoint0 = CGPointMake(0, w/4.);
            controlPoint1 = CGPointMake(w/4., w/2.);
            controlPoint2 = CGPointMake(w/4.*3, w/2.);
            controlPoint3 = CGPointMake(w, w/4.);
        }
            break;
        case GXBezierPathRemoveSemicircularDirectionDown:
        {
            
        }
            break;
        case GXBezierPathRemoveSemicircularDirectionLeft:
        {
            
        }
            break;
        case GXBezierPathRemoveSemicircularDirectionRight:
        {
            
        }
            break;
        default:
            break;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:pathPoint0];
    [path addCurveToPoint:pathPoint1 controlPoint1:controlPoint0 controlPoint2:controlPoint1];
    [path addCurveToPoint:pathPoint2 controlPoint1:controlPoint2 controlPoint2:controlPoint3];
    [path addLineToPoint:pathPoint3];
    [path addLineToPoint:pathPoint4];
    [path closePath];
    return path;
}
+ (CGFloat)getAnglesWithThreePoint:(CGPoint)pointA pointB:(CGPoint)pointB pointC:(CGPoint)pointC {
    
    CGFloat x1 = pointA.x - pointB.x;
    CGFloat y1 = pointA.y - pointB.y;
    CGFloat x2 = pointC.x - pointB.x;
    CGFloat y2 = pointC.y - pointB.y;
    
    CGFloat x = x1 * x2 + y1 * y2;
    CGFloat y = x1 * y2 - x2 * y1;
    
    CGFloat angle = acos(x/sqrt(x*x+y*y));
    
    return angle;
}
#define VALUE(_INDEX_) [NSValue valueWithCGPoint:points[_INDEX_]]
#define POINT(_INDEX_) [(NSValue *)[points objectAtIndex:_INDEX_] CGPointValue]
/*
 *获取给定点的曲线 算法Catmull-Rom 实用性高 特点: 经过控制点  granularity值越高 拟合度越高 point 个数必须>=4
 */
+ (UIBezierPath*)gxSmoothedPathWithPoints:(NSArray *)pathpoints Granularity:(NSInteger)granularity
{
    NSMutableArray *points = [pathpoints mutableCopy];
    
    if (points.count < 4) return nil;
    
    // Add control points to make the math make sense
    [points insertObject:[points objectAtIndex:0] atIndex:0];
    [points addObject:[points lastObject]];
    
    UIBezierPath *smoothedPath = [self bezierPath];
    [smoothedPath removeAllPoints];
    
    [smoothedPath moveToPoint:POINT(0)];
    
    for (NSUInteger index = 1; index < points.count - 2; index++)
    {
        CGPoint p0 = POINT(index - 1);
        CGPoint p1 = POINT(index);
        CGPoint p2 = POINT(index + 1);
        CGPoint p3 = POINT(index + 2);
        
        // now add n points starting at p1 + dx/dy up until p2 using Catmull-Rom splines
        for (int i = 1; i < granularity; i++)
        {
            float t = (float) i * (1.0f / (float) granularity);
            float tt = t * t;
            float ttt = tt * t;
            
            CGPoint pi; // intermediate point
            pi.x = 0.5 * (2*p1.x+(p2.x-p0.x)*t + (2*p0.x-5*p1.x+4*p2.x-p3.x)*tt + (3*p1.x-p0.x-3*p2.x+p3.x)*ttt);
            pi.y = 0.5 * (2*p1.y+(p2.y-p0.y)*t + (2*p0.y-5*p1.y+4*p2.y-p3.y)*tt + (3*p1.y-p0.y-3*p2.y+p3.y)*ttt);
            [smoothedPath addLineToPoint:pi];
        }
        
        // Now add p2
        [smoothedPath addLineToPoint:p2];
    }
    
    // finish by adding the last point
    [smoothedPath addLineToPoint:POINT(points.count - 1)];
    
    return smoothedPath;
}

// 上面的算法改造 只获取点
+ ( NSArray*)gxSmoothedPointsWithPoints:(NSArray *)pathpoints Granularity:(NSInteger)granularity
{
    NSMutableArray *points = [pathpoints mutableCopy];
    
    if (points.count < 4) return nil;
    
    // Add control points to make the math make sense
    [points insertObject:[points objectAtIndex:0] atIndex:0];
    [points addObject:[points lastObject]];
    
    NSMutableArray *smoothedPoints = [NSMutableArray array];
    
//    UIBezierPath *smoothedPath = [self bezierPath];
//    [smoothedPath removeAllPoints];
    
    [smoothedPoints addObject:points[0]];
//    [smoothedPath moveToPoint:POINT(0)];
    
    for (NSUInteger index = 1; index < points.count - 2; index++)
    {
        CGPoint p0 = POINT(index - 1);
        CGPoint p1 = POINT(index);
        CGPoint p2 = POINT(index + 1);
        CGPoint p3 = POINT(index + 2);
        
        // now add n points starting at p1 + dx/dy up until p2 using Catmull-Rom splines
        for (int i = 1; i < granularity; i++)
        {
            float t = (float) i * (1.0f / (float) granularity);
            float tt = t * t;
            float ttt = tt * t;
            
            CGPoint pi; // intermediate point
            pi.x = 0.5 * (2*p1.x+(p2.x-p0.x)*t + (2*p0.x-5*p1.x+4*p2.x-p3.x)*tt + (3*p1.x-p0.x-3*p2.x+p3.x)*ttt);
            pi.y = 0.5 * (2*p1.y+(p2.y-p0.y)*t + (2*p0.y-5*p1.y+4*p2.y-p3.y)*tt + (3*p1.y-p0.y-3*p2.y+p3.y)*ttt);
            [smoothedPoints addObject:[NSValue valueWithCGPoint:(pi)]];
//            [smoothedPath addLineToPoint:pi];
        }
        
        // Now add p2
        [smoothedPoints addObject:[NSValue valueWithCGPoint:(p2)]];

//        [smoothedPath addLineToPoint:p2];
    }
    
    // finish by adding the last point
    [smoothedPoints addObject:points[points.count - 1]];
//    [smoothedPath addLineToPoint:POINT(points.count - 1)];
    return smoothedPoints;
//    return smoothedPath;
}


// 以下是带曲线控制点的
+(UIBezierPath *)gxInterpolateCGPointsWithCatmullRom:(NSArray *)pointsAsNSValues closed:(BOOL)closed alpha:(float)alpha {
    if ([pointsAsNSValues count] < 4)
    return nil;
    
    NSInteger endIndex = (closed ? [pointsAsNSValues count] : [pointsAsNSValues count]-2);
    NSAssert(alpha >= 0.0 && alpha <= 1.0, @"alpha value is between 0.0 and 1.0, inclusive");
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    NSInteger startIndex = (closed ? 0 : 1);
    for (NSInteger ii=startIndex; ii < endIndex; ++ii) {
        CGPoint p0, p1, p2, p3;
        NSInteger nextii      = (ii+1)%[pointsAsNSValues count];
        NSInteger nextnextii  = (nextii+1)%[pointsAsNSValues count];
        NSInteger previi      = (ii-1 < 0 ? [pointsAsNSValues count]-1 : ii-1);
        
        [pointsAsNSValues[ii] getValue:&p1];
        [pointsAsNSValues[previi] getValue:&p0];
        [pointsAsNSValues[nextii] getValue:&p2];
        [pointsAsNSValues[nextnextii] getValue:&p3];
        
        CGFloat d1 = ccpLength(ccpSub(p1, p0));
        CGFloat d2 = ccpLength(ccpSub(p2, p1));
        CGFloat d3 = ccpLength(ccpSub(p3, p2));
        
        CGPoint b1, b2;
        if (fabs(d1) < UIBezierPathkEPSILON) {
            b1 = p1;
        }
        else {
            b1 = ccpMult(p2, powf(d1, 2*alpha));
            b1 = ccpSub(b1, ccpMult(p0, powf(d2, 2*alpha)));
            b1 = ccpAdd(b1, ccpMult(p1,(2*powf(d1, 2*alpha) + 3*powf(d1, alpha)*powf(d2, alpha) + powf(d2, 2*alpha))));
            b1 = ccpMult(b1, 1.0 / (3*powf(d1, alpha)*(powf(d1, alpha)+powf(d2, alpha))));
        }
        
        if (fabs(d3) < UIBezierPathkEPSILON) {
            b2 = p2;
        }
        else {
            b2 = ccpMult(p1, powf(d3, 2*alpha));
            b2 = ccpSub(b2, ccpMult(p3, powf(d2, 2*alpha)));
            b2 = ccpAdd(b2, ccpMult(p2,(2*powf(d3, 2*alpha) + 3*powf(d3, alpha)*powf(d2, alpha) + powf(d2, 2*alpha))));
            b2 = ccpMult(b2, 1.0 / (3*powf(d3, alpha)*(powf(d3, alpha)+powf(d2, alpha))));
        }
        
        if (ii==startIndex)
        [path moveToPoint:p1];
        
        [path addCurveToPoint:p2 controlPoint1:b1 controlPoint2:b2];
    }
    
    if (closed)
    [path closePath];
    
    return path;
}

+(UIBezierPath *)gxInterpolateCGPointsWithHermite:(NSArray *)pointsAsNSValues closed:(BOOL)closed {
    if ([pointsAsNSValues count] < 2)
    return nil;
    
    NSInteger nCurves = (closed ? [pointsAsNSValues count] : [pointsAsNSValues count]-1);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (NSInteger ii=0; ii < nCurves; ++ii) {
        NSValue *value  = pointsAsNSValues[ii];
        
        CGPoint curPt, prevPt, nextPt, endPt;
        [value getValue:&curPt];
        if (ii==0)
        [path moveToPoint:curPt];
        
        NSInteger nextii = (ii+1)%[pointsAsNSValues count];
        NSInteger previi = (ii-1 < 0 ? [pointsAsNSValues count]-1 : ii-1);
        
        [pointsAsNSValues[previi] getValue:&prevPt];
        [pointsAsNSValues[nextii] getValue:&nextPt];
        endPt = nextPt;
        
        CGFloat mx, my;
        if (closed || ii > 0) {
            mx = (nextPt.x - curPt.x)*0.5 + (curPt.x - prevPt.x)*0.5;
            my = (nextPt.y - curPt.y)*0.5 + (curPt.y - prevPt.y)*0.5;
        }
        else {
            mx = (nextPt.x - curPt.x)*0.5;
            my = (nextPt.y - curPt.y)*0.5;
        }
        
        CGPoint ctrlPt1;
        ctrlPt1.x = curPt.x + mx / 3.0;
        ctrlPt1.y = curPt.y + my / 3.0;
        
        [pointsAsNSValues[nextii] getValue:&curPt];
        
        nextii = (nextii+1)%[pointsAsNSValues count];
        previi = ii;
        
        [pointsAsNSValues[previi] getValue:&prevPt];
        [pointsAsNSValues[nextii] getValue:&nextPt];
        
        if (closed || ii < nCurves-1) {
            mx = (nextPt.x - curPt.x)*0.5 + (curPt.x - prevPt.x)*0.5;
            my = (nextPt.y - curPt.y)*0.5 + (curPt.y - prevPt.y)*0.5;
        }
        else {
            mx = (curPt.x - prevPt.x)*0.5;
            my = (curPt.y - prevPt.y)*0.5;
        }
        
        CGPoint ctrlPt2;
        ctrlPt2.x = curPt.x - mx / 3.0;
        ctrlPt2.y = curPt.y - my / 3.0;
        
        [path addCurveToPoint:endPt controlPoint1:ctrlPt1 controlPoint2:ctrlPt2];
    }
    
    if (closed)
    [path closePath];
    
    return path;
}



@end
