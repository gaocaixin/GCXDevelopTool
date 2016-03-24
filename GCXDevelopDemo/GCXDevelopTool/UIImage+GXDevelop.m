//
//  UIImage+GXDevelop.m
//  LOCO
//
//  Created by 高才新 on 16/1/21.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import "UIImage+GXDevelop.h"
#import <UIKit/UIKit.h>

@implementation UIImage (GXDevelop)
+ (UIImage*)gxImageWithColor:(UIColor*)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius{
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

+ (UIImage *)gxImageName:(NSString *)name tintColor:(UIColor *)color
{
    UIImage *image = [UIImage imageNamed:name];
    image = [image gxImageWithTintColor:color];
    return image;
}

- (UIImage *)gxImageWithTintColor:(UIColor *)tintColor {
    return [self gxImageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *)gxImageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode {
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

@end
