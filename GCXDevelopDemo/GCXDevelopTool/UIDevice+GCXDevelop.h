//
//  UIDevice+GCXDevelop.h
//  LOCO
//
//  Created by 高才新 on 16/3/2.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (GCXDevelop)

/**
 *获取设备可用内存 (MB)
 */
+ (double)gcxGetAvailableMemory;


/**
 *获取设备当前任务所占用的内存（单位：MB）
 */
+ (double)gcxGetUsedMemory;
/**
 *强制旋转设备方向  (审he 能 通guo)
 */
+ (void)gcxSetDeviceOrientation:(UIInterfaceOrientation)orientation;

+ (BOOL)gcxCanAuthenticateTouchIdWithError:(NSError *)error;
+ (void)gcxAuthenticateTouchIdWithLocalizedReason:(NSString *)localizedReason completion:(void (^)(BOOL success, NSError * authenticationError))authenticateCompletion;



+ (BOOL) gcxIsRunningOn3GS;
+ (BOOL) gcxIsRunningOn4S;
+ (BOOL) gcxIsRunningOn_3_5_Inch; //iPhone 4
+ (BOOL) gcxIsRunningOn_4_0_Inch; //iPhone 5
+ (BOOL) gcxIsRunningOn_4_7_Inch; //iPhone 6
+ (BOOL) gcxIsRunningOn_5_5_Inch; //iPhone 6 Plus
+ (BOOL) gcxIsRunningOniPad;      //iPad
+ (BOOL) gcxIsRunningOniPod;      //iPod
+ (CGFloat)gcxGetSystemVersion;

@end
