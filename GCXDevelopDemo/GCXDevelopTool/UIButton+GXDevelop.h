//
//  UIButton+GXDevelop.h
//  LOCO
//
//  Created by 高才新 on 15/12/16.
//  Copyright © 2015年 IU-Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface UIButton (GXDevelop)

// 快速设置属性
/**
 * 属性的各种数组NHDS 是数组各种状态的开头大写字母 如 :
 Btn.gxNHDImages = @[image1];会自动设置UIControlStateNormal图片.
Btn.gxNHDImages = @[image1, image2];会自动设置UIControlStateNormal和UIControlStateHighlighted的图片.
 Btn.gxNHDImages = @[image1, image2,image3];会自动设置UIControlStateNormal、UIControlStateHighlighted和UIControlStateDisabled的图片.
 */
@property (nonatomic, strong) NSArray * gxNHDImages;
@property (nonatomic, strong) NSArray * gxNHDTitles;
@property (nonatomic, strong) NSArray * gxNHDTitleColors;
@property (nonatomic, strong) NSArray * gxNSDImages;



- (void)gxSetNHDWithImages:(NSArray *)gxNHDImages colors:(NSArray *)gxNHDTitleColors titles:(NSArray *)gxNHDTitles ;
- (void)gxSetNHDWithFont:(UIFont *)font colors:(NSArray *)gxNHDTitleColors titles:(NSArray *)gxNHDTitles;

/**
 *给按钮添加一个点击出现波纹的效果 内部会设置self.layer.masksToBounds = NO; scaleMaxValue是波纹最大延展半径相对于本身半径的倍数
 */
- (void)gxAddTapRippleEffectWithColor:(UIColor *)color scaleMaxValue:(CGFloat)value duration:(CGFloat)duration;

@end
