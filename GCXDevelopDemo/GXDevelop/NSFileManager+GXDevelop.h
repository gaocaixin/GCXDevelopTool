//
//  NSFileManager+GXDevelop.h
//  LOCO
//
//  Created by 高才新 on 16/3/16.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSFileManager (GXDevelop)
/**
 *获取各类路径
 */

/**
 *沙盒路径
 */
@property (copy, nonatomic, readonly) NSString *gxHomePath;
/**
 *doc 路径
 */
@property (copy, nonatomic, readonly) NSString *gxDocumentsPath;
/**
 *临时文件路径
 */
@property (copy, nonatomic, readonly) NSString *gxtmpPath;
/**
 * lib 路径
 */
@property (copy, nonatomic, readonly) NSString *gxLibraryPath;
/**
 *缓存路径
 */
@property (copy, nonatomic, readonly) NSString *gxLibraryCachesPath;

/**
 *偏好设置路径
 */
@property (copy, nonatomic, readonly) NSString *gxLibraryPreferencesPath;



@end
