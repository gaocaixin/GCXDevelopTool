//
//  BezierPath.m
//  GXDevelopDemo
//
//  Created by 高才新 on 16/3/31.
//  Copyright © 2016年 高才新. All rights reserved.
//

#import "BezierPath.h"
#import "GXDevelop.h"

@implementation BezierPath

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect
{
    [[UIColor redColor] set];
    UIBezierPath *path = [UIBezierPath gxBezierPathRectRemoveSemicircular:rect directionOption:GXBezierPathRemoveSemicircularDirectionTop];
//    [path moveToPoint:CGPointMake(0, 0)];
//    [path addCurveToPoint:CGPointMake(rect.size.width/2., rect.size.height) controlPoint1:CGPointMake(0, rect.size.height/2.) controlPoint2:CGPointMake(rect.size.width/4., rect.size.height)];
//    [path addCurveToPoint:CGPointMake(rect.size.width, 0) controlPoint1:CGPointMake(rect.size.width/4.*3, rect.size.height) controlPoint2:CGPointMake(rect.size.width, rect.size.height/2.)];
//    [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
//    [path addLineToPoint:CGPointMake(0, rect.size.height)];
//    [path closePath];
    path.lineWidth = 1;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    [path fill];

}

@end
