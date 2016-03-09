//
//  UIButton+GCXDevelop.h
//  LOCO
//
//  Created by 高才新 on 15/12/16.
//  Copyright © 2015年 IU-Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface UIButton (GCXDevelop)

// 快速设置属性
/**
 * 属性的各种数组NHDS 是数组各种状态的开头大写字母 如 :
 Btn.gcxNHDImages = @[image1];会自动设置UIControlStateNormal图片.
Btn.gcxNHDImages = @[image1, image2];会自动设置UIControlStateNormal和UIControlStateHighlighted的图片.
 Btn.gcxNHDImages = @[image1, image2,image3];会自动设置UIControlStateNormal、UIControlStateHighlighted和UIControlStateDisabled的图片.
 */
@property (nonatomic, strong) NSArray * gcxNHDImages;
@property (nonatomic, strong) NSArray * gcxNHDTitles;
@property (nonatomic, strong) NSArray * gcxNHDTitleColors;
@property (nonatomic, strong) NSArray * gcxNSDImages;



- (void)gcxSetNHDWithImages:(NSArray *)gcxNHDImages colors:(NSArray *)gcxNHDTitleColors titles:(NSArray *)gcxNHDTitles ;
- (void)gcxSetNHDWithFont:(UIFont *)font colors:(NSArray *)gcxNHDTitleColors titles:(NSArray *)gcxNHDTitles;

/**
 *给按钮添加一个点击出现波纹的效果 内部会设置self.layer.masksToBounds = NO; scaleMaxValue是波纹最大延展半径相对于本身半径的倍数
 */
- (void)gcxAddTapRippleEffectWithColor:(UIColor *)color scaleMaxValue:(CGFloat)value duration:(CGFloat)duration;

@end
