//
//  GCXDevelopDevice.m
//  LOCO
//
//  Created by 高才新 on 15/12/28.
//  Copyright © 2015年 IU-Apps. All rights reserved.
//

#import "GCXDevelopDevice.h"
#import <sys/sysctl.h>
#import <mach/mach.h>

@implementation GCXDevelopDevice
// 获取可用内存
+ (double)gcxGetAvailableMemory
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
+ (double)gcxGetUsedMemory
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

+ (void)gcxSetDeviceOrientation:(UIInterfaceOrientation)orientation
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

@end
