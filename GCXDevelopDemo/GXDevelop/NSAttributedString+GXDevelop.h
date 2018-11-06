//
//  NSAttributedString+GXDevelop.h
//  LOCO
//
//  Created by 高才新 on 16/1/19.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface NSAttributedString (GXDevelop)

@property (nonatomic, assign, readonly)CGSize gxSize;
/**
 *计算 size
 */
- (CGSize )gxSizeWithLimitSize:(CGSize )limitSize;

- (CGSize)gxPrefersizeWith:(CGSize)size;

- (CGSize)gxBoundingRectWithSize:(CGSize)size;

//- (CGSize)gxPrefersizeWith:(CGSize)size withLastLine:(CGRect *)rect;
//- (CGSize)gxPrefersizeWith:(CGSize)size;

- (CGSize)gxPrefersizeWith:(CGSize)size withLastLine:(CGRect *)rect;

+ (NSMutableAttributedString *)gxAttributeStringWith:(NSString *)str font:(UIFont *)font  color:(UIColor *)fontColor spacing:(CGFloat)spacing lineSpacing:(CGFloat)linespacing alignment:(NSTextAlignment)alignment;

@end
