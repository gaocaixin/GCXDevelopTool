//
//  PHAsset+GXDevelop.h
//  EarthSpirit
//
//  Created by 小新 on 2017/5/31.
//  Copyright © 2017年 KarlSW. All rights reserved.
//

#import <Photos/Photos.h>

@interface PHAsset (GXDevelop)
- (void)gxGetImageWithSize:(CGSize)size contentMode:(PHImageContentMode)mode networkAllowed:(BOOL)networkAllowed onComplete:(void (^)( PHAsset*asset, UIImage * img,  NSDictionary *info))complete;
- (UIImage *)gxGetImageWithSize:(CGSize)size contentMode:(PHImageContentMode)mode networkAllowed:(BOOL)networkAllowed;
@end
