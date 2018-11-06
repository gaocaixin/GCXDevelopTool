//
//  UIColor+GXDevelop.m
//  GIFY
//
//  Created by 小新 on 16/7/8.
//  Copyright © 2016年 Steven.C. All rights reserved.
//

#import "UIColor+GXDevelop.h"
#import "GXDevelopKey.h"

@implementation UIColor (GXDevelop)

- (NSUInteger)gxRGBAValue{
    CGFloat red, green, blue, alpha;
    NSInteger r,g,b,a;
    
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    r = red*255;
    g = green*255;
    b = blue*255;
    a = alpha*255;
    
    NSUInteger value =  ((r & 0xFF) << 24) | ((g & 0xFF) << 16) | ((b & 0xFF) << 8) | ((a & 0xFF) << 0);
    return value;
}

+ (UIColor *)gxColorWithRGBAValue:(NSUInteger)rgbaValue{
    
    CGFloat red, green, blue, alpha;
    NSInteger r,g,b,a;
    r = (rgbaValue & 0xFF000000) >> 24;
    g = (rgbaValue & 0xFF0000) >> 16;
    b = (rgbaValue & 0xFF00) >> 8;
    a = (rgbaValue & 0xFF) >> 0;
    
    red = r / 255.0;
    green = g / 255.0;
    blue = b / 255.0;
    alpha = a / 255.0;
    return [UIColor colorWithRed:red
                           green:green
                            blue:blue
                           alpha:alpha];
}


- (NSString *)gxRGBHexString{
    CGFloat red, green, blue, alpha;
    unsigned int r,g,b,a;
    
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    r = red*255;
    g = green*255;
    b = blue*255;
    a = alpha*255;
    
    unsigned int value =  ((r & 0xFF) << 16) | ((g & 0xFF) << 8) | ((b & 0xFF) << 0) | ((a & 0xFF) << 24);
    
    NSString *str = [NSString stringWithFormat:@"#%08X", value];
    return str;
}
+ (UIColor *)gxColorWithoutAlpha:(UIColor *)color{
    if(color == nil){
        return nil;
    }
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    UIColor *newColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    return newColor;
}


+ (UIColor *)gxColorWithString:(NSString *)str{
    NSArray *arr = [str componentsSeparatedByString:@","];// "255,255,255"
    if (arr.count == 3){
        NSInteger red = [arr[0] integerValue];
        NSInteger green = [arr[1] integerValue];
        NSInteger blue = [arr[2] integerValue];
        return GXColorFromRGBA(red, green, blue,1);
    }else if (arr.count == 4){
        CGFloat alpha = MAX(MIN([arr[0] floatValue], 1.0), 0.0);
        NSInteger red = [arr[1] integerValue];
        NSInteger green = [arr[2] integerValue];
        NSInteger blue = [arr[3] integerValue];
        return GXColorFromRGBA(red, green, blue, alpha);
    } else  {
        if ([str hasPrefix:@"#"]) { // "#AARRGGBB" or "#RRGGBB"
            str = [str substringFromIndex:1];
        }
        // "AARRGGBB" or "RRGGBB"
            if (!str || [str isEqualToString:@"none"] || !(str.length == 3 || str.length == 4 || str.length == 6 || str.length == 8))
            return nil;
            
            if (str.length == 3) { // "fff"
                str = [NSString stringWithFormat:@"FF%@%@%@%@%@%@", [NSString stringWithFormat:@"%C", [str characterAtIndex:0]],
                       [NSString stringWithFormat:@"%C", [str characterAtIndex:0]],
                       [NSString stringWithFormat:@"%C", [str characterAtIndex:1]],
                       [NSString stringWithFormat:@"%C", [str characterAtIndex:1]],
                       [NSString stringWithFormat:@"%C", [str characterAtIndex:2]],
                       [NSString stringWithFormat:@"%C", [str characterAtIndex:2]]];
            }
            else if (str.length == 4) {// "ffff"
                str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@", [NSString stringWithFormat:@"%C", [str characterAtIndex:0]],
                       [NSString stringWithFormat:@"%C", [str characterAtIndex:0]],
                       [NSString stringWithFormat:@"%C", [str characterAtIndex:1]],
                       [NSString stringWithFormat:@"%C", [str characterAtIndex:1]],
                       [NSString stringWithFormat:@"%C", [str characterAtIndex:2]],
                       [NSString stringWithFormat:@"%C", [str characterAtIndex:2]],
                       [NSString stringWithFormat:@"%C", [str characterAtIndex:3]],
                       [NSString stringWithFormat:@"%C", [str characterAtIndex:3]]];
            }else if (str.length == 6) {//"ffffff"
                str = [NSString stringWithFormat:@"FF%@", str];
            } else if (str.length == 8) {//"ffffff"
                str = str;
            } else { //未识别的格式
                return  nil;
            }
        
            // "ffffffff"
            unsigned int rgbValue = 0;
            NSScanner *scanner = [NSScanner scannerWithString:str];
            [scanner scanHexInt:&rgbValue];
            
            return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0
                                   green:((rgbValue & 0xFF00) >> 8)/255.0
                                    blue:(rgbValue & 0xFF)/255.0
                                   alpha:((rgbValue & 0xFF000000) >> 24)/255.0];

    }
    return nil;
    
}

+ (UIColor *)colorWithString:(NSString *)str{
    if ([str hasPrefix:@"#"]) { // AARRGGBB or RRGGBB
        str = [str substringFromIndex:1];
        
        if (!str || [str isEqualToString:@"none"] || !(str.length == 3 || str.length == 4 || str.length == 6 || str.length == 8))
            return nil;
        
        if (str.length == 3) {
            str = [NSString stringWithFormat:@"FF%@%@%@%@%@%@", [NSString stringWithFormat:@"%C", [str characterAtIndex:0]],
                   [NSString stringWithFormat:@"%C", [str characterAtIndex:0]],
                   [NSString stringWithFormat:@"%C", [str characterAtIndex:1]],
                   [NSString stringWithFormat:@"%C", [str characterAtIndex:1]],
                   [NSString stringWithFormat:@"%C", [str characterAtIndex:2]],
                   [NSString stringWithFormat:@"%C", [str characterAtIndex:2]]];
        }
        else if (str.length == 4) {
            str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@", [NSString stringWithFormat:@"%C", [str characterAtIndex:0]],
                   [NSString stringWithFormat:@"%C", [str characterAtIndex:0]],
                   [NSString stringWithFormat:@"%C", [str characterAtIndex:1]],
                   [NSString stringWithFormat:@"%C", [str characterAtIndex:1]],
                   [NSString stringWithFormat:@"%C", [str characterAtIndex:2]],
                   [NSString stringWithFormat:@"%C", [str characterAtIndex:2]],
                   [NSString stringWithFormat:@"%C", [str characterAtIndex:3]],
                   [NSString stringWithFormat:@"%C", [str characterAtIndex:3]]];
        }else if (str.length == 6)
            str = [NSString stringWithFormat:@"FF%@", str];
        
        
        unsigned int rgbValue = 0;
        NSScanner *scanner = [NSScanner scannerWithString:str];
        [scanner scanHexInt:&rgbValue];
        
        return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0
                               green:((rgbValue & 0xFF00) >> 8)/255.0
                                blue:(rgbValue & 0xFF)/255.0
                               alpha:((rgbValue & 0xFF000000) >> 24)/255.0];
        
    }else{
        NSArray *arr = [str componentsSeparatedByString:@","];
        if (arr.count == 3){
            NSInteger red = [arr[0] integerValue];
            NSInteger green = [arr[1] integerValue];
            NSInteger blue = [arr[2] integerValue];
            return GXColorFromRGBA(red, green, blue,1);
        }else if (arr.count == 4){
            CGFloat alpha = MAX(MIN([arr[0] floatValue], 1.0), 0.0);
            NSInteger red = [arr[1] integerValue];
            NSInteger green = [arr[2] integerValue];
            NSInteger blue = [arr[3] integerValue];
            return GXColorFromRGBA(red, green, blue,alpha);
        }
        return nil;
    }
}

+ (UIColor *)colorWithRGBAValue:(NSUInteger)rgbaValue{
    
    CGFloat red, green, blue, alpha;
    NSInteger r,g,b,a;
    r = (rgbaValue & 0xFF000000) >> 24;
    g = (rgbaValue & 0xFF0000) >> 16;
    b = (rgbaValue & 0xFF00) >> 8;
    a = (rgbaValue & 0xFF) >> 0;
    
    red = r / 255.0;
    green = g / 255.0;
    blue = b / 255.0;
    alpha = a / 255.0;
    return [UIColor colorWithRed:red
                           green:green
                            blue:blue
                           alpha:alpha];
}
- (NSUInteger)RGBAValue{
    CGFloat red, green, blue, alpha;
    NSInteger r,g,b,a;
    
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    r = red*255;
    g = green*255;
    b = blue*255;
    a = alpha*255;
    
    NSUInteger value =  ((r & 0xFF) << 24) | ((g & 0xFF) << 16) | ((b & 0xFF) << 8) | ((a & 0xFF) << 0);
    return value;
}

- (NSString *)RGBHexString{
    CGFloat red, green, blue, alpha;
    unsigned int r,g,b,a;
    
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    r = red*255;
    g = green*255;
    b = blue*255;
    a = alpha*255;
    
    unsigned int value =  ((r & 0xFF) << 16) | ((g & 0xFF) << 8) | ((b & 0xFF) << 0) | ((a & 0xFF) << 24);
    
    NSString *str = [NSString stringWithFormat:@"#%08X", value];
    return str;
}
+ (UIColor *)gxColorWith:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}
+ (UIColor *)gxColorWith:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}
+ (UIColor *)gxColorPercent:(CGFloat)percent from:(UIColor *)fromColor to:(UIColor *)toColor{
    percent = MAX(0.0, MIN(percent, 1.0));
    if (!fromColor)
        fromColor = [UIColor whiteColor];
    if (!toColor)
        toColor = [UIColor whiteColor];
    
    CGFloat r, g, b, a, r2, g2, b2, a2;
    [fromColor getRed:&r green:&g blue:&b alpha:&a];
    [toColor getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
    return [UIColor colorWithRed:(r+percent*(r2-r))
                           green:(g+percent*(g2-g))
                            blue:(b+percent*(b2-b))
                           alpha:(a+percent*(a2-a))];
}
+ (NSMutableArray *)gxColorGetRGBAfromUicolor:(UIColor*)color{
    NSMutableArray *arr = [NSMutableArray new];
    CGColorRef CGolor = [color CGColor];
//    NSInteger numComponents = CGColorGetNumberOfComponents(CGolor);
    CGFloat R, G, B, A;
    const CGFloat *components = CGColorGetComponents(CGolor);
    R = components[0];
    G = components[1];
    B = components[2];
    A = components[3];
    [arr addObjectsFromArray:@[@(R),@(G),@(B),@(A)]];
    return  arr;
}
- (UIColor *)gxChangeColorAlpha:(CGFloat)alpha{
    NSDictionary *colorDic = [self gxGetRGBDictionaryByColor];
    CGFloat R, G, B, A;
    R = [colorDic[@"R"] floatValue];
    G = [colorDic[@"G"] floatValue];
    B = [colorDic[@"B"] floatValue];
    A = alpha;
    UIColor *comColor = [UIColor colorWithRed:R green:G blue:B alpha:A];
    return comColor;
}

- (NSDictionary *)gxGetRGBDictionaryByColor
{
    CGFloat r=0,g=0,b=0,a=0;
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self getRed:&r green:&g blue:&b alpha:&a];
    }
    else {
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }
    
    return @{@"R":@(r),
             @"G":@(g),
             @"B":@(b),
             @"A":@(a)};
}

+ (UIColor *)gxGirlyBaseColor {
    return [self gxColorWith:255 green:74 blue:100];
}
@end
