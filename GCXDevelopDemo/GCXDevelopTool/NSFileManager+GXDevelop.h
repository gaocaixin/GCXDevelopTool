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
@property (copy, nonatomic, readonly) NSString *gxHomePath;//沙盒路径
@property (copy, nonatomic, readonly) NSString *gxDocumentsPath;// doc 路径
@property (copy, nonatomic, readonly) NSString *gxtmpPath;// 临时文件路径
@property (copy, nonatomic, readonly) NSString *gxLibraryPath;// lib 路径
@property (copy, nonatomic, readonly) NSString *gxLibraryCachesPath;// 缓存路径
@property (copy, nonatomic, readonly) NSString *gxLibraryPreferencesPath;//偏好设置路径



@end
