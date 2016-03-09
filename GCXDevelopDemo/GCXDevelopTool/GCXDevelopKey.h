//
//  GCXDevelopKey.h
//  LOCO
//
//  Created by 高才新 on 16/1/28.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#ifndef GCXDevelopKey_h
#define GCXDevelopKey_h

// 系统单例
#define GCXUserDefaults [NSUserDefaults standardUserDefaults]
#define GCXNotificationCenter [NSNotificationCenter defaultCenter]

#define GCXRectW(rect) rect.size.width
#define GCXRectH(rect) rect.size.height
#define GCXRectX(rect) rect.origin.x
#define GCXRectY(rect) rect.origin.y

/**
 *屏幕宽度
 */
#define GCXScreenWidth [UIScreen mainScreen].bounds.size.width
/**
 *屏幕高度
 */
#define GCXScreenHeight  [UIScreen mainScreen].bounds.size.height

/**
 *如果需要适配 frame 将用到以下宏  需要将GCXDesignSize的 key 值改成设计原稿机型的尺寸. CGSizeMake(375.f, 667.f) 是 iphone6的尺寸.
 */
#define GCXDesignSize                  CGSizeMake(375.f,667.f)              //设计原稿机型的尺寸
#define GCXScreenWidthRatio            GCXScreenWidth/GCXDesignSize.width   // 当前屏宽/设计原稿的比例
#define GCXScreenHeightRatio           GCXScreenHeight/GCXDesignSize.height // 当前屏高/设计原稿的比例

#define  GCXWidthFitValueFloat(value)  ((value)*GCXScreenWidthRatio)        // 宽度转化成适配后的float值
#define  GCXWidthFitValueCeil(value)   (ceil((value)*GCXScreenWidthRatio))  // 宽度转化成适配后的ceil值(不小于float的最小整数)
#define  GCXWidthFitValueFloor(value)  (floor((value)*GCXScreenWidthRatio)) // 宽度转化成适配后的floor值(不大于float的最大整数)

#define  GCXHeightFitValueFloat(value) ((value)*GCXScreenHeightRatio)       // 高度转化成适配后的float值
#define  GCXHeightFitValueCeil(value)  (ceil((value)*GCXScreenHeightRatio)) // 高度转化成适配后的ceil值(不小于float的最小整数)
#define  GCXHeightFitValueFloor(value) (floor((value)*GCXScreenHeightRatio))// 高度转化成适配后的floor值(不大于float的最大整数)

// 颜色
#define GCXColorFromRGBA(R,G,B,A) [UIColor colorWithRed:R/256.f green:G/256.f blue:B/256.f alpha:A]
/**
 *    GCXColorFromRGBhueA(0x000000(16进制颜色), 0);
 */
#define GCXColorFromRGBhueA(RGBhue, A) [UIColor colorWithRed:((float)((RGBhue & 0xFF0000) >> 16))/255.0 green:((float)((RGBhue & 0x00FF00) >> 8))/255.0 blue:((float)(RGBhue & 0x0000FF))/255.0 alpha:A]

/**
 *自定义log (发布版本不打印任何信息)
 */
#ifdef DEBUG
#define GCXLog(...) NSLog(__VA_ARGS__)
#else
#define GCXLog(...)
#endif
/**
 *打印函数名及函数的调用者 (测试使用:如-[MyViewController dealloc])
 */
#define GCXLogFunc         GCXLog(@"%s",__func__);
#define GCXLogFuncMsg(msg) GCXLog(@"%s-%@",__func__,msg);





#endif /* GCXDevelopKey_h */
