//
//  NSLocale+GXDevelop.m
//  EarthSpirit
//
//  Created by 小新 on 2017/11/2.
//  Copyright © 2017年 KarlSW. All rights reserved.
//

#import "NSLocale+GXDevelop.h"

@implementation NSLocale (GXDevelop)

+ (BOOL)gxIsChina{
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    if ([[countryCode uppercaseString] isEqualToString:@"CN"]) {
        return YES;
    }
    return NO;
}

+ (BOOL)gxisAsia{
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    NSString *upercaseString = countryCode.uppercaseString;
    if ([upercaseString isEqualToString:@"CN"] || [upercaseString isEqualToString:@"JP"] || [upercaseString isEqualToString:@"KR"] || [upercaseString isEqualToString:@"TW"] || [upercaseString isEqualToString:@"MO"] || [upercaseString isEqualToString:@"HK"]) {
        return YES;
    }
    return NO;
}

@end
