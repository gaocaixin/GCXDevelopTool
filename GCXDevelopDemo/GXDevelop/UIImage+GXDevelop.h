//
//  UIImage+GXDevelop.h
//  LOCO
//
//  Created by 高才新 on 16/1/21.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class AVURLAsset;

@interface UIImage (GXDevelop)

/**
 *将图片的颜色更改  用于小图标绘制
 */
- (UIImage *)gxImageWithTintColor:(UIColor *)tintColor;
/**
 *中心点拉伸
 */
- (UIImage *) gxStretch;
/**
 *缩放
 */
-(UIImage*)gxScaleToSize:(NSInteger)size;
/**
 *添加渐变
 */
- (UIImage *) gxImageWithGradientTintColor:(UIColor *)tintColor;
/**
 *添加边框
 */
- (UIImage *) gxImageWithBorderColor:(UIColor *)borderColor width:(CGFloat)width;
/**
 *缩放至newSize
 */
- (UIImage *) gxImageWithScaledToSize:(CGSize)newSize;
/**
 *旋转90度
 */
- (UIImage *) gxRotate90Clockwise;
/**
 *横向翻转
 */
- (UIImage *) gxFlipHorizontal;
/**
 *竖向翻转
 */
- (UIImage *) gxFixOrientation;
- (CGFloat)gxWidth;
- (CGFloat)gxHeight;
/**
 *横向镜像
 */
- (UIImage *)gxMirrorHorizon;
/**
 *竖向镜像
 */
- (UIImage *)gxMirrorVertical;
/**
 *模糊图片blur0-1  (可能效率最高)
 */
- (UIImage *)gxBlurryImageWithBlurLevel:(CGFloat)blur;

/**
 *  深拷贝 image
 */
+ (UIImage *)gxImageDeepCopy:(UIImage *)imageToCopy;
/**
 *从 view 生成一张 image
 */
+ (UIImage *)gxImageWithView:(UIView *)view;
/**
 *从新生成一张size的 image-fill
 */
+ (UIImage *) gxGetAspectFillImage:(UIImage *)imageToCopy targetSize:(CGSize)size isOpaque:(BOOL)isOpaque;
/**
 *从新生成一张size的 image-fit
 */
+ (UIImage *) gxGetScaleFitImage:  (UIImage *)imageToCopy targetSize:(CGSize)size;
/**
 *联合两张 image
 */
+ (UIImage *)gxImageByCombiningImage:(UIImage*)firstImage withImage:(UIImage*)secondImage;
/**
 *返回一张带有颜色尺寸带圆角的 image
 */
+ (UIImage*)gxImageWithColor:(UIColor*)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius ;
/**
 *返回一张的图片 带有指定颜色
 */
+ (UIImage *)gxImageName:(NSString *)name tintColor:(UIColor *)color;


/**
 *  高斯模糊
 */
- (UIImage *)gximageGaussianBlur:(CGFloat)blur;

@end
