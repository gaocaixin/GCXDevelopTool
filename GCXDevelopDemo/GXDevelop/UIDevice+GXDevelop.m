//
//  UIDevice+GXDevelop.m
//  LOCO
//
//  Created by 高才新 on 16/3/2.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import "UIDevice+GXDevelop.h"
#import <sys/sysctl.h>
#import <mach/mach.h>

#import <sys/utsname.h>
#import <LocalAuthentication/LAContext.h>

#define IPHONE_3GS_NAMESTRING @"iPhone2,1"
#define IPHONE_4S_NAMESTRING @"iPhone4,1"

#define IPOD_TAG_NAMESTRING @"iPod"

@implementation UIDevice (GXDevelop)

// 获取可用内存
+ (double)gxGetAvailableMemory
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
}

// 获取当前任务所占用的内存（单位：MB）
+ (double)gxGetUsedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    
    return taskInfo.resident_size / 1024.0 / 1024.0;
}

+ (void)gxSetDeviceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        NSArray *arr = @[@"s", @"e", @"t", @"O", @"r", @"i", @"e", @"n", @"t", @"a", @"t", @"i", @"o", @"n",@":"];
        NSString *str = [arr componentsJoinedByString:@""];
        //        SEL selector = NSSelectorFromString(@"setOrientation:");
        SEL selector = NSSelectorFromString(str);
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

+ (NSString*) machineName {
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine
                              encoding:NSUTF8StringEncoding];
}

/**
 *  device type serial
 *
 *  @return TRUE or FALSE
 */
+ (BOOL)gxIsRunningOn3GS {
    NSString * machineName = [self machineName];
    return [machineName isEqualToString:IPHONE_3GS_NAMESTRING];
}

+ (BOOL)gxIsRunningOn4S {
    NSString * machineName = [self machineName];
    return [machineName isEqualToString:IPHONE_4S_NAMESTRING];
}

+ (BOOL)gxIsRunningOniPod {
    NSString * machineName = [self machineName];
    return [machineName containsString: IPOD_TAG_NAMESTRING];
}

/**
 *  device capbility: Touch Id support
 *
 *  @return TRUE or FALSE
 */
+ (BOOL)gxCanAuthenticateTouchIdWithError:(NSError *)error {
    if ([LAContext class]) {
        return [[[LAContext alloc] init] canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    }
    return NO;
}
+ (void)gxAuthenticateTouchIdWithLocalizedReason:(NSString *)localizedReason completion:(void (^)(BOOL success, NSError * authenticationError))authenticateCompletion
{
    LAContext * context = [[LAContext alloc] init];
    NSError *error = nil;
    // check if the policy can be evaluated
    if ([self gxCanAuthenticateTouchIdWithError:error]) {
        // evaluate
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:localizedReason
                          reply:^(BOOL success, NSError * authenticationError) {
                              if (authenticateCompletion) {
                                  authenticateCompletion(success,authenticationError);
                              }
                          }];
    } else {
        NSLog(@"LAContext::Policy Error : %@", [error localizedDescription]);
    }
}

/**
 *  Screen Size serial
 *
 *  @return TRUE or FALSE
 */
#define SCREEN_3_5_INCH (CGSizeMake( 640, 960))
#define SCREEN_4_0_INCH (CGSizeMake( 640,1136))
#define SCREEN_4_7_INCH (CGSizeMake( 750,1334))
#define SCREEN_5_5_INCH (CGSizeMake(1242,2208))

+ (BOOL)gxIsRunningOn_3_5_Inch {
    return [self isSizeEqual:SCREEN_3_5_INCH];
}

+ (BOOL)gxIsRunningOn_4_0_Inch {
    return [self isSizeEqual:SCREEN_4_0_INCH];
}

+ (BOOL)gxIsRunningOn_4_7_Inch {
    return [self isSizeEqual:SCREEN_4_7_INCH];
}

+ (BOOL)gxIsRunningOn_5_5_Inch {
    return [self isSizeEqual:SCREEN_5_5_INCH];
}

+ (BOOL)gxIsRunningOniPad {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

+ (BOOL)isSizeEqual: (CGSize)screenSize {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(screenSize, [[UIScreen mainScreen] currentMode].size) : NO);
}

+ (CGFloat)gxGetSystemVersion
{
    return [[UIDevice currentDevice].systemVersion floatValue];
}
@end
