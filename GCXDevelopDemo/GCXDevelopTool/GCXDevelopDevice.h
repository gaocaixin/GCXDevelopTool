//
//  GCXDevelopDevice.h
//  LOCO
//
//  Created by 高才新 on 15/12/28.
//  Copyright © 2015年 IU-Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface GCXDevelopDevice : NSObject

/**
 *获取设备可用内存 (MB)
 */
+ (double)gcxGetAvailableMemory;


/**
 *获取设备当前任务所占用的内存（单位：MB）
 */
+ (double)gcxGetUsedMemory;
/**
 *强制旋转设备方向  (方法经过处理)
 */
+ (void)gcxSetDeviceOrientation:(UIInterfaceOrientation)orientation;
@end
