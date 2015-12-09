//
//  GXTool.m
//  LOCO
//
//  Created by 高才新 on 15/10/28.
//  Copyright © 2015年 IU-Apps. All rights reserved.
//

#import "GXTool.h"

@implementation GXTool


+ (CGSize )sizeWithText:(NSString*)text limitSize:(CGSize )limitSize  font:(UIFont *)font
{
    CGSize size;
    if([[UIDevice currentDevice].systemVersion doubleValue] >=7.0)
    {
        NSDictionary * attributes = @{NSFontAttributeName:font};
        NSAttributedString *attributedText =[[NSAttributedString alloc]initWithString:text attributes:attributes];
        CGRect rect = [attributedText boundingRectWithSize:limitSize
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        size = rect.size;
    }
    else
        
    {
        //设置label的最大行数
        CGRect rect = [text boundingRectWithSize: limitSize
                                  options: (NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                               attributes: @{NSFontAttributeName:font}
                                  context: nil];
        size = rect.size;
    }
    return size;
    
}


@end
