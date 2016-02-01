//
//  UILabel+GCXDevelop.m
//  LOCO
//
//  Created by 高才新 on 15/12/17.
//  Copyright © 2015年 IU-Apps. All rights reserved.
//

#import "UILabel+GCXDevelop.h"

@implementation UILabel (GCXDevelop)

- (void)gcxSetTextAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor text:(NSString *)text {
    self.font = font;
    self.text = text;
    self.textColor = textColor;
    self.textAlignment = textAlignment;
    if (!bgColor) {
        bgColor = [UIColor clearColor];
    }
    self.backgroundColor = bgColor;
}

@end
