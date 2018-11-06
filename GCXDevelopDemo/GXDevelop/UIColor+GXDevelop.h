//
//  UIColor+GXDevelop.h
//  GIFY
//
//  Created by 小新 on 16/7/8.
//  Copyright © 2016年 Steven.C. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (GXDevelop)

- (NSUInteger)gxRGBAValue;
+ (UIColor *)gxColorWithRGBAValue:(NSUInteger)rgbaValue;


- (NSString *)gxRGBHexString;
+ (UIColor *)gxColorWithString:(NSString *)str;
+ (UIColor *)gxColorWithoutAlpha:(UIColor *)color;

+ (UIColor *)gxGirlyBaseColor;


+ (UIColor *)gxColorWith:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
+ (UIColor *)gxColorWith:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+ (UIColor *)gxColorPercent:(CGFloat)percent from:(UIColor *)fromColor to:(UIColor *)toColor;
- (UIColor *)gxChangeColorAlpha:(CGFloat)alpha;
@end
