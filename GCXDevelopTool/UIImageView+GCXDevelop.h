//
//  UIImageView+GCXDevelop.h
//  LOCO
//
//  Created by 高才新 on 15/12/16.
//  Copyright © 2015年 IU-Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface UIImageView (GCXDevelop)
/**
 *快速设置属性
 */
- (void)gcxSetFrame:(CGRect)frame contentMode:(UIViewContentMode)contentMode backgroundColor:(UIColor *)backgroundColor image:(UIImage *)image;
+ (UIImageView *)gcxImageViewFrame:(CGRect)frame contentMode:(UIViewContentMode)contentMode backgroundColor:(UIColor *)backgroundColor image:(UIImage *)image;

@end
