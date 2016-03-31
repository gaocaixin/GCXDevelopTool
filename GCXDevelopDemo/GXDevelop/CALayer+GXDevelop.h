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

/**
 *获取 layer 上某点的颜色
 */
- (UIColor *)gxGetColorFromPoint:(CGPoint)point;
@end
