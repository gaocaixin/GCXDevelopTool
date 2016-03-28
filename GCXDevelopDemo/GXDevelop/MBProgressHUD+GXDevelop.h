//
//  MBProgressHUD+GXDevelop.h
//  LOCO
//
//  Created by 高才新 on 16/1/7.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//
/**
 *这是对MBProgressHUD的一层包装
 */

#import "MBProgressHUD.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface MBProgressHUD (GXDevelop)

/**
 *快速显示一个hud 信息   default view = window;
 */
+ (void)gxShowNotiInView:(UIView *)view duration:(CGFloat)duration image:(UIImage *)image text:(NSString *)text ;
+ (void)gxShowNotiInDebugInView:(UIView *)view duration:(CGFloat)duration image:(UIImage *)image text:(NSString *)text ;

@end
