//
//  UIImage+GCXDevelop.h
//  LOCO
//
//  Created by 高才新 on 16/1/21.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface UIImage (GCXDevelop)
/**
 *返回一张带有颜色尺寸带圆角的 image
 */
+ (UIImage*)gcxImageWithColor:(UIColor*)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius ;


@end
