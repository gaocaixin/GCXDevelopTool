//
//  UILabel+GXDevelop.h
//  LOCO
//
//  Created by 高才新 on 15/12/17.
//  Copyright © 2015年 IU-Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface UILabel (GXDevelop)
/**
 *快速设置属性
 */
- (void)gxSetTextAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor text:(NSString *)text ;

@end
