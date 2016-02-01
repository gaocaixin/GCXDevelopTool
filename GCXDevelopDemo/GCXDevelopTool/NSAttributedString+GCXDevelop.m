//
//  NSAttributedString+GCXDevelop.m
//  LOCO
//
//  Created by 高才新 on 16/1/19.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import "NSAttributedString+GCXDevelop.h"

@implementation NSAttributedString (GCXDevelop)
- (CGSize )gcxSizeWithLimitSize:(CGSize )limitSize
{
    CGRect rect = [self boundingRectWithSize:limitSize
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    return rect.size;
}
@end
