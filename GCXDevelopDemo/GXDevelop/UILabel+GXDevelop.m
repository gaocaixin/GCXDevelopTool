//
//  UILabel+GXDevelop.m
//  LOCO
//
//  Created by 高才新 on 15/12/17.
//  Copyright © 2015年 IU-Apps. All rights reserved.
//

#import "UILabel+GXDevelop.h"
#import "NSString+GXDevelop.h"
#import "NSAttributedString+GXDevelop.h"

@implementation UILabel (GXDevelop)

- (void)gxSetTextAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor text:(NSString *)text {
    self.font = font;
    self.text = text;
    self.textColor = textColor;
    self.textAlignment = textAlignment;
    if (!bgColor) {
        bgColor = [UIColor clearColor];
    }
    self.backgroundColor = bgColor;
}

+ (UILabel *)gxSetTextAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    [label gxSetTextAlignment:textAlignment font:font textColor:textColor bgColor:bgColor text:text];
    return label;
}

- (CGSize)gxGetTextSize
{
    if (self.attributedText.length > 0) {
        return [self.attributedText gxPrefersizeWith:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    }
    if (self.text.length > 0) {
        return [self.text gxSizeWithLimitSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) font:self.font];
    }
    return CGSizeZero;
}

@end
