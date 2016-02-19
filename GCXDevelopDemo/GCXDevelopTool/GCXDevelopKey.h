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
#define GCXLogFunc GCXLog(@"%s", __func__)

#define GCXRectW(rect)              rect.size.width
#define GCXRectH(rect)               rect.size.height
#define GCXRectX(rect)               rect.origin.x
#define GCXRectY(rect)               rect.origin.y

#define GCXScreenW [UIScreen mainScreen].bounds.size.width
#define GCXScreenH  [UIScreen mainScreen].bounds.size.height



#endif /* GCXDevelopKey_h */
