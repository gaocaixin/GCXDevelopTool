//
//  PHAsset+GXDevelop.m
//  EarthSpirit
//
//  Created by 小新 on 2017/5/31.
//  Copyright © 2017年 KarlSW. All rights reserved.
//

#import "PHAsset+GXDevelop.h"
#import "UIImage+GXDevelop.h"
#import "GXDevelopKey.h"

@implementation PHAsset (GXDevelop)
- (void)gxGetImageWithSize:(CGSize)size contentMode:(PHImageContentMode)mode networkAllowed:(BOOL)networkAllowed onComplete:(void (^)( PHAsset*asset, UIImage * img,  NSDictionary *info))complete
{
    PHAsset *passet = self;
    GXWeakSelf(weakSelf)
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    options.synchronous = NO;
    options.networkAccessAllowed = networkAllowed;
    [[PHImageManager defaultManager] requestImageForAsset:passet
                                               targetSize:size
                                              contentMode:mode
                                                  options:options
                                            resultHandler:^(UIImage * result, NSDictionary *info) {
                                                if (!result) {
                                                    if (complete)
                                                        complete(weakSelf, result, info);
                                                }else{
                                                    result = [result gxFixOrientation];
                                                    if (complete)
                                                        complete(weakSelf, result, info);
                                                }
                                            }];
}

- (UIImage *)gxGetImageWithSize:(CGSize)size contentMode:(PHImageContentMode)mode networkAllowed:(BOOL)networkAllowed{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    options.synchronous = YES;
    options.networkAccessAllowed = networkAllowed;
    UIImage __block * image = nil;
    [[PHImageManager defaultManager] requestImageForAsset:self
                                               targetSize:size
                                              contentMode:mode
                                                  options:options
                                            resultHandler:^(UIImage * result, NSDictionary *info) {
                                                image = result;
                                            }];
    return image;
}
@end

