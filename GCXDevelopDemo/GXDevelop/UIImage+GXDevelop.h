//
//  UIImage+GXDevelop.h
//  LOCO
//
//  Created by 高才新 on 16/1/21.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface UIImage (GXDevelop)
/**
 *返回一张带有颜色尺寸带圆角的 image
 */
+ (UIImage*)gxImageWithColor:(UIColor*)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius ;

/**
 *返回一张的图片 带有指定颜色
 */
+ (UIImage *)gxImageName:(NSString *)name tintColor:(UIColor *)color;

/**
 *将图片的颜色更改  用于小图标绘制
 */
- (UIImage *)gxImageWithTintColor:(UIColor *)tintColor;

@end
