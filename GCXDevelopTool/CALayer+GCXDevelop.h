//
//  CALayer+GCXDevelop.h
//  LOCO
//
//  Created by 高才新 on 15/12/16.
//  Copyright © 2015年 IU-Apps. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
/**
 *渐变的方向
 */
typedef enum : NSUInteger {
    GCXGradientLayerDirectionTopToDown,
    GCXGradientLayerDirectionLeftToRight,
    GCXGradientLayerDirectionTopLeftToDownRight,
    GCXGradientLayerDirectionTopRightToDownLeft,
    GCXGradientLayerDirectionOther
} GCXGradientLayerDirectionOption;

@interface CALayer (GCXDevelop)
/**
 *     给 layer 添加一个渐变 layer
 [layer gcxSetGradientLayerWithColors:@[ (__bridge id)UIColorFromRGBA_hex(0x006AFF, 1).CGColor,(__bridge id)UIColorFromRGBA_hex(0x00A8FF, 1).CGColor] layerFrame:frame direction:GCXGradientLayerDirectionTopToDown];

 */
- (CAGradientLayer *)gcxSetGradientLayerWithColors:(NSArray *)colors layerFrame:(CGRect)frame direction:(GCXGradientLayerDirectionOption)direction;


/**
 *获取 layer 上某点的颜色
 */
- (UIColor *)gcxGetColorFromPoint:(CGPoint)point;
@end
