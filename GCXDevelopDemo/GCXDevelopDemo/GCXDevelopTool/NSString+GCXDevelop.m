//
//  NSString+GCXString.m
//  LOCO
//
//  Created by 高才新 on 15/12/16.
//  Copyright © 2015年 IU-Apps. All rights reserved.
//

#import "NSString+GCXDevelop.h"
#import <CommonCrypto/CommonDigest.h>
#import <CoreText/CoreText.h>
#import "NSAttributedString+GCXDevelop.h"

@implementation NSString (GCXDevelop)

- (BOOL)gcxValidateWithRegexStr:(NSString *)regexStr {
    NSString *emailRegex = regexStr;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
    
}
- (CGSize )gcxSizeWithLimitSize:(CGSize )limitSize  font:(UIFont *)font {
    CGSize size;
    if([[UIDevice currentDevice].systemVersion doubleValue] >=7.0)
    {
        NSDictionary * attributes = @{NSFontAttributeName:font};
        NSAttributedString *attributedText =[[NSAttributedString alloc]initWithString:self attributes:attributes];
        return [attributedText gcxSizeWithLimitSize:limitSize];
    }
    else
    {
        CGRect rect = [self boundingRectWithSize: limitSize
                                         options: (NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                      attributes: @{NSFontAttributeName:font}
                                         context: nil];
        size = rect.size;
    }
    return size;
}
- (NSString *)gcxMd5 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

/**
 * 添加文字间距
 */
- (NSMutableAttributedString *) gcxAttributeStringWithFont:(UIFont *)font color:(UIColor *)fontColor spacing:(long)spacing
{
    NSMutableAttributedString *strAttri = [[NSMutableAttributedString alloc] initWithString:self];

    [strAttri addAttribute:NSFontAttributeName
                         value:font
                         range:NSMakeRange(0, [strAttri length])];
    
    [strAttri addAttribute:NSForegroundColorAttributeName
                     value:fontColor
                     range:NSMakeRange(0, [strAttri length])];
    
    long number = spacing;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [strAttri addAttribute:(id)kCTKernAttributeName
                     value:(__bridge id)num
                     range:NSMakeRange(0, [strAttri length])];
    CFRelease(num);
    return strAttri;
}
/**
 * 添加文字间距 行间距
 */
- (NSMutableAttributedString *)gcxAttributeStringWithFont:(UIFont *)font  color:(UIColor *)fontColor spacing:(long)spacing lineSpacing:(CGFloat)linespacing alignment:(NSTextAlignment)alignment
{
    NSMutableAttributedString *attr = [self gcxAttributeStringWithFont:font color:fontColor spacing:spacing];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = linespacing;
    paragraphStyle.alignment = alignment;
    [attr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attr length])];
    return attr;
}

- (UIColor *) gcxHexStringTransformUIColorWithAlpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"] || [cString hasPrefix:@"0x"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

@end
