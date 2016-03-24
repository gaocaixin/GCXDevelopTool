//
//  NSFileManager+GXDevelop.m
//  LOCO
//
//  Created by 高才新 on 16/3/16.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import "NSFileManager+GXDevelop.h"

@implementation NSFileManager (GXDevelop)


- (NSArray *)gxGetPathsWithPath:(NSSearchPathDirectory)path
{
    return NSSearchPathForDirectoriesInDomains(path, NSUserDomainMask, YES);
}

- (NSString *)gxHomePath
{
    return NSHomeDirectory();
}
- (NSString *)gxDocumentsPath
{
    return [self gxGetPathsWithPath:NSDocumentDirectory][0];
}
- (NSString *)gxLibraryPath
{
    return [self gxGetPathsWithPath:NSLibraryDirectory][0];
}
- (NSString *)gxtmpPath
{
    return  NSTemporaryDirectory();
}
- (NSString *)gxLibraryCachesPath
{
    return [self gxGetPathsWithPath:NSCachesDirectory][0];
}
-(NSString *)gxLibraryPreferencesPath
{
    NSString *cache = self.gxLibraryCachesPath;
    cache = [cache stringByDeletingLastPathComponent];
    cache = [cache stringByAppendingPathComponent:@"Preferences"];
    return cache;
}
@end
