//
//  NSAttributedString+GXDevelop.m
//  LOCO
//
//  Created by 高才新 on 16/1/19.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import "NSAttributedString+GXDevelop.h"
#import <CoreText/CoreText.h>

@implementation NSAttributedString (GXDevelop)
- (CGSize )gxSizeWithLimitSize:(CGSize )limitSize
{
    CGRect rect = [self boundingRectWithSize:limitSize
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    return rect.size;
}


- (CGSize)gxPrefersizeWith:(CGSize)size{
    CGFloat width = size.width;
    CGFloat height = size.height;
    if (width == 0)
        width = CGFLOAT_MAX;
    
    if (height == 0)
        height = CGFLOAT_MAX;
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self);
    CGSize textSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0,0), NULL, CGSizeMake(width, height), NULL);
    CFRelease(framesetter);
    return textSize;
}
@end
