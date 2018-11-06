//
//  GXApp.m
//  EarthSpirit
//
//  Created by 小新 on 2017/8/24.
//  Copyright © 2017年 KarlSW. All rights reserved.
//

#import "GXApp.h"
#import "GXDevelopCustom.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation GXApp


+ (NSString *)gxGetVersionUniqueNum{
    NSString *str = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSArray *arr = [str componentsSeparatedByString:@"."];
    NSInteger version = 0;
    for (int i=0; i<3; i++) {
        NSInteger v = 0;
        if (i<arr.count)
            v = [[arr objectAtIndex:i] integerValue];
        version = version*100+v;
    }
    return [NSString stringWithFormat:@"%ld",version];
}

+ (NSURL *)gxGetUrlOfReview{
    //    itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=APP_ID
    //    @"itms-apps://itunes.apple.com/app/idAPP_ID"

    NSURL *deepURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/itunes-u/id%@?action=write-review",GXAPPID]];
    
    if ([[UIApplication sharedApplication] canOpenURL:deepURL])
        return deepURL;
    return [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", GXAPPID]];
}

@end
