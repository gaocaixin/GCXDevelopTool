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
/**
 *获取 view 上莫一点的颜色
 */
- (UIColor *)gcxGetColorFromPoint:(CGPoint)point;
@end
