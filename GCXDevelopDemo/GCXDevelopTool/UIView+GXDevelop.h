//
//  UIView+GXDevelop.h
//  LOCO
//
//  Created by 高才新 on 16/1/28.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface UIView (GXDevelop)

@property (nonatomic, assign) CGFloat gxMinX;
@property (nonatomic, assign) CGFloat gxMinY;
@property (nonatomic, assign) CGFloat gxMaxX;
@property (nonatomic, assign) CGFloat gxMaxY;
@property (nonatomic, assign) CGFloat gxMidX;
@property (nonatomic, assign) CGFloat gxMidY;

@property (nonatomic, assign) CGFloat gxWidth;
@property (nonatomic, assign) CGFloat gxHeight;
@property (nonatomic, assign) CGFloat gxWidthHalf;
@property (nonatomic, assign) CGFloat gxHeightHalf;

@property (nonatomic, assign) CGPoint gxCenter;
@property (nonatomic, assign) CGSize  gxSize;
/**
 *获取 view的 layer 上某点的颜色
 */
- (UIColor *)gxGetColorFromPoint:(CGPoint)point;
@end
