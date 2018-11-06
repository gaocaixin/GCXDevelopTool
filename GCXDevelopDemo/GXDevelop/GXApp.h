//
//  GXApp.h
//  EarthSpirit
//
//  Created by 小新 on 2017/8/24.
//  Copyright © 2017年 KarlSW. All rights reserved.
//

// 用来获取 app 信息
#import <Foundation/Foundation.h>

@interface GXApp : NSObject

+ (NSString *)gxGetVersionUniqueNum;

+ (NSURL *)gxGetUrlOfReview;


@end
