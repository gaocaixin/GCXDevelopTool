//
//  UIBezierPath+GXDevelop.m
//  GXDevelopDemo
//
//  Created by 高才新 on 16/3/31.
//  Copyright © 2016年 高才新. All rights reserved.
//

#import "UIBezierPath+GXDevelop.h"
#import "GXDevelopKey.h"

@implementation UIBezierPath (GXDevelop)

+ (UIBezierPath *)gxBezierPathRectRemoveSemicircular:(CGRect)rect directionOption:(GXBezierPathRemoveSemicircularDirectionOption)directionOption
{
    CGPoint pathPoint0;
    CGPoint pathPoint1;
    CGPoint pathPoint2;
    CGPoint pathPoint3;
    CGPoint pathPoint4;
    
    CGPoint controlPoint0;
    CGPoint controlPoint1;
    CGPoint controlPoint2;
    CGPoint controlPoint3;
    
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
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



@end
