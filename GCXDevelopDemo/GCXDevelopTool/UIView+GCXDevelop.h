//
//  UIView+GCXDevelop.h
//  LOCO
//
//  Created by 高才新 on 16/1/28.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface UIView (GCXDevelop)

@property (nonatomic, assign) CGFloat gcxMinX;
@property (nonatomic, assign) CGFloat gcxMinY;
@property (nonatomic, assign) CGFloat gcxMaxX;
@property (nonatomic, assign) CGFloat gcxMaxY;
@property (nonatomic, assign) CGFloat gcxMidX;
@property (nonatomic, assign) CGFloat gcxMidY;

@property (nonatomic, assign) CGFloat gcxWidth;
@property (nonatomic, assign) CGFloat gcxHeight;
@property (nonatomic, assign) CGFloat gcxWidthHalf;
@property (nonatomic, assign) CGFloat gcxHeightHalf;

@property (nonatomic, assign) CGPoint gcxCenter;
@property (nonatomic, assign) CGSize  gcxSize;
/**
 *获取 view的 layer 上某点的颜色
 */
- (UIColor *)gcxGetColorFromPoint:(CGPoint)point;
@end
