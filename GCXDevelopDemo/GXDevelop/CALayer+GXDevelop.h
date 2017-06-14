//
//  CALayer+GXDevelop.h
//  LOCO
//
//  Created by 高才新 on 15/12/16.
//  Copyright © 2015年 IU-Apps. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface CALayer (GXDevelop)

// frame
@property (nonatomic, assign) CGPoint gxOrigin;
@property (nonatomic, assign) CGFloat gxX;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat gxY;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat gxMaxX;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat gxMaxY;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGSize  gxSize;
@property (nonatomic, assign) CGFloat gxWidth;
@property (nonatomic, assign) CGFloat gxHeight;
@property (nonatomic, assign) CGFloat gxWidthHalf;
@property (nonatomic, assign) CGFloat gxHeightHalf;
// bounds
@property (nonatomic, assign) CGPoint gxBorigin;
@property (nonatomic, assign) CGFloat gxBx;
@property (nonatomic, assign) CGFloat gxBy;
@property (nonatomic, assign) CGSize  gxBsize;
@property (nonatomic, assign) CGFloat gxBwidth;
@property (nonatomic, assign) CGFloat gxBheight;
@property (nonatomic, assign) CGFloat gxBwidthHalf;
@property (nonatomic, assign) CGFloat gxBheightHalf;

// 中心点
@property (nonatomic, assign) CGPoint gxCenter;
@property (nonatomic, assign, readonly) CGPoint gxCenterIn;
@property (nonatomic, assign) CGFloat gxCenterX;
@property (nonatomic, assign) CGFloat gxCenterY;
@property (nonatomic, assign, readonly) CGFloat gxCenterInX;
@property (nonatomic, assign, readonly) CGFloat gxCenterInY;

/**
 *获取 layer 上某点的颜色
 */
- (UIColor *)gxGetColorFromPoint:(CGPoint)point;

/**
 *  给layer添加阴影
 *
 *  @param color   颜色
 *  @param blur    blur radius
 *  @param opacity 透明
 *  @param rect    shadowPath
 */
- (void)gxAddShadowWithShadowColor:(CGColorRef)color shadowRadius:(CGFloat)blur shadowOpacity:(CGFloat)opacity shadowPath:(CGRect)rect;

/**
 *  设置圆角
 */
- (void)gxSetRoundRect;

- (void)gxSetCornerRadius:(CGFloat)radius;


@end
