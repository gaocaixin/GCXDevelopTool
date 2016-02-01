//
//  UIImage+GCXDevelop.m
//  LOCO
//
//  Created by 高才新 on 16/1/21.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import "UIImage+GCXDevelop.h"

@implementation UIImage (GCXDevelop)
+ (UIImage*)gcxImageWithColor:(UIColor*)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    path.lineWidth = 0;
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    [path fill];
    [path stroke];
    [path addClip];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
