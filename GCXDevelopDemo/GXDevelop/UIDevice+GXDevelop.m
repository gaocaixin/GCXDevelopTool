//
//  UIDevice+GXDevelop.m
//  LOCO
//
//  Created by 高才新 on 16/3/2.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import "UIDevice+GXDevelop.h"
#import "UIApplication+GXDevelop.h"
#import <sys/sysctl.h>
#import <mach/mach.h>

#import <sys/utsname.h>
#import <LocalAuthentication/LAContext.h>
#import "GXDevelopKey.h"
#import <Photos/Photos.h>

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
+ (BOOL)gxCanCamera
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

+ (void)gxGetCameraAuthorizationCompletion:(void (^)(BOOL allow, NSError * authenticationError))authenticateCompletion
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusNotDetermined:{
            // 许可对话没有出现，发起授权许可
            
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                
                if (granted) {
                    //第一次用户接受
                    authenticateCompletion(YES, nil);
                }else{
                    //用户拒绝
                    authenticateCompletion(NO, nil);
                }
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized:{
            // 已经开启授权，可继续
            authenticateCompletion(YES, nil);
            break;
        }
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
            // 用户明确地拒绝授权，或者相机设备无法访问
            authenticateCompletion(NO, nil);
            break;
        default:
            break;
    }
}
+ (void)gxGetPhotoAuthorizationCompletion:(void (^)(BOOL allow, NSError * authenticationError))authenticateCompletion {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    switch (status) {
        case PHAuthorizationStatusNotDetermined:{
            // 许可对话没有出现，发起授权许可
            
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                
                switch (status) {
                    case PHAuthorizationStatusNotDetermined:{
                        // 许可对话没有出现，发起授权许可
                        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                            
                        }];
                        break;
                    }
                    case PHAuthorizationStatusAuthorized:{
                        // 已经开启授权，可继续
                        authenticateCompletion(YES, nil);
                        break;
                    }
                    case PHAuthorizationStatusDenied:
                    case PHAuthorizationStatusRestricted:
                        // 用户明确地拒绝授权，或者相机设备无法访问
                        authenticateCompletion(NO, nil);
                        break;
                    default:
                        break;
                }
            }];
            break;
        }
        case PHAuthorizationStatusAuthorized:{
            // 已经开启授权，可继续
            authenticateCompletion(YES, nil);
            break;
        }
        case PHAuthorizationStatusDenied:
        case PHAuthorizationStatusRestricted:
            // 用户明确地拒绝授权，或者相机设备无法访问
            authenticateCompletion(NO, nil);
            break;
        default:
            break;
    }
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

+ (void)gxLogDeviceFont
{
    NSArray *familyNames = [UIFont familyNames];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableArray *arr = [NSMutableArray array];

    for(NSString *familyName in familyNames)
    {
        [arr removeAllObjects];
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for(NSString *fontName in fontNames)
        {
            [arr addObject:fontName];
        }
        dict[familyName] = [arr copy];
    }
    GXLog(@"font-- %@", dict);
}

+ (void)gxOpenURL:(NSString*)url fromViewController:(UIViewController *)vc
{
    UIResponder* responder = vc;
    while ((responder = [responder nextResponder]) != nil) {
        NSLog(@"responder = %@", responder);
        if ([responder respondsToSelector:@selector(openURL:)] == YES) {
            [responder performSelector:@selector(openURL:)
                            withObject:[NSURL URLWithString:url]];
        }
    }
}

+ (NSString *)gxGetAppItunesURLString:(NSString *)appid
{
    return [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%@",appid];
}

// AppItunesURL
+ (NSURL *)gxGetAppItunesURL:(NSString *)appid
{
    return [NSURL URLWithString:[self gxGetAppItunesURLString:appid]];
}

//+ (NSURL *)gxGetAppItunesCommentURLString:(NSString *)appid
//{
//    return [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%@",appid]];
//}

+ (NSURL *)gxGetAppSettingsURLString
{
     return  [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//    if ([[UIApplication sharedApplication] canOpenURL:url]) {
//        [[UIApplication sharedApplication] openURL:url];
//    }
}

+ (NSURL *)gxGetSettingsWith:(NSInteger)idx
{
    NSArray *arr = @[
                           @{@"关于本机":@"prefs:root=General&path=About"},
                           @{@"软件升级":@"prefs:root=General&path=SOFTWARE_UPDATE_LINK"},
                           @{@"日期时间":@"prefs:root=General&path=DATE_AND_TIME"},
                           @{@"Accessibility":@"prefs:root=General&path=ACCESSIBILITY"},
                           @{@"键盘设置":@"prefs:root=General&path=Keyboard"},
                           @{@"VPN":@"prefs:root=General&path=VPN"},
                           @{@"壁纸设置":@"prefs:root=Wallpaper"},
                           @{@"声音设置":@"prefs:root=Sounds"},
                           @{@"隐私设置":@"prefs:root=privacy"},
                           @{@"APP Store":@"prefs:root=STORE"},
                           @{@"还原设置":@"prefs:root=General&path=Reset"},
                           @{@"应用通知":@"prefs:root=NOTIFICATIONS_ID&path=应用的boundleId"}
                           ];
    NSURL * url = nil;
    if (idx < arr.count) {
        url = [NSURL URLWithString:[arr[idx] allValues].firstObject];
    }
    return url;
}

+ (void)gxShowAllFilters
{
    
    NSArray *filterNames=[CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    
     for (NSString *filterName in filterNames) {
        
         CIFilter *filter=[CIFilter filterWithName:filterName];
        
         GXLog(@"AllFilters--name:%@ attributes:%@",filterName,[filter attributes]);
     }
}

+ (void)gxShareItems:(NSArray *)items controller:(UIViewController *)controller {
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        activityViewController.popoverPresentationController.sourceView = controller.view;
    }
    
    [controller presentViewController:activityViewController animated:YES completion:^{
        
    }];
}

+(AVCaptureDevice *)gxGetFrontFacingCameraIfAvailable {
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice *captureDevice = nil;
    for (AVCaptureDevice *device in videoDevices) {
        if (device.position == AVCaptureDevicePositionFront) {
            captureDevice = device;
            break;
        }
    }
    //  couldn't find one on the front, so just get the default video device.
    if (!captureDevice) {
        captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return captureDevice;
}

// 偷拍
+(void)gxGetCameraCapture:(void(^)(UIImage *))handler {
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    
    if ([session canSetSessionPreset:AVCaptureSessionPreset640x480])
        session.sessionPreset = AVCaptureSessionPreset640x480; //Sales-Check: Invader's Photo Quality Adjust
    
    NSError *error = nil;
    AVCaptureDevice  * captureDevice = [UIDevice gxGetFrontFacingCameraIfAvailable];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input && error != nil) {
        NSLog(@"ERROR: trying to open camera: %@", error.localizedDescription);
        return;
    }
    
    if ([session canAddInput:input]) {
        [session addInput:input];
    }
    
//    dispatch_queue_t sessionQueue = dispatch_queue_create("com.iu.camera.capture", DISPATCH_QUEUE_SERIAL);
//    dispatch_async(sessionQueue, ^{
//        [session startRunning];
//    });
        [session startRunning];
    
    if ([captureDevice lockForConfiguration:&error]) {
        // locked successfully, go on with configuration
        AVCaptureFocusMode focusMode = AVCaptureFocusModeAutoFocus;
        if ([captureDevice isFocusModeSupported:focusMode])
            captureDevice.focusMode = focusMode;
        
        AVCaptureExposureMode exposureMode = AVCaptureExposureModeAutoExpose;
        if ([captureDevice isExposureModeSupported: exposureMode])
            captureDevice.exposureMode = exposureMode;
        
        // iOS8+
        if (([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending))
            [captureDevice setExposureTargetBias:(captureDevice.maxExposureTargetBias + captureDevice.minExposureTargetBias)/2.f completionHandler:^(CMTime syncTime) {
                NSLog(@"setExposureTargetBias Done");
            }];
        
        AVCaptureWhiteBalanceMode whiteBalanceMode = AVCaptureWhiteBalanceModeAutoWhiteBalance;
        if ([captureDevice isWhiteBalanceModeSupported: whiteBalanceMode])
            captureDevice.whiteBalanceMode = whiteBalanceMode;
        
        [captureDevice unlockForConfiguration];
    } else {
        // something went wrong, the device was probably already locked
        NSLog(@"ERROR: trying to lockForConfiguration camera: %@", error.localizedDescription);
        return;
    }
    
    AVCaptureStillImageOutput *stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    //stillImageOutput.capturingStillImage = YES;
    NSDictionary *outputSettings = @{AVVideoCodecKey : AVVideoCodecJPEG};
    [stillImageOutput setOutputSettings:outputSettings];
    if ([session canAddOutput:stillImageOutput]) {
        [session addOutput:stillImageOutput];
    }
    
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in stillImageOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) {break;}
    }
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2f * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        [stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
            [session stopRunning];
            if (imageDataSampleBuffer != NULL && error == nil) {
                NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
                UIImage *capturedImage = [UIImage imageWithData:imageData];
                if (captureDevice == [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo].lastObject) {
                    capturedImage = [[UIImage alloc] initWithCGImage:capturedImage.CGImage scale:1.0f orientation:
                                     UIImageOrientationUp];
                }
                if (handler)
                    handler(capturedImage);
            }
        }];
        
    });
}

+ (void)gxGetAppUpdated:(void (^)(BOOL update))complete
{
    NSString *perVersion = [GXUserDefaults stringForKey:@"gxGetAppUpdated"];
    NSString *curVersion = GXSharedApp.gxAppVersion;
    if ([perVersion isEqualToString:curVersion]) {
        if (complete) {
            complete(NO);
        }
    } else {
        if (complete) {
            complete(YES);
        }
    }
    [GXUserDefaults setObject:curVersion forKey:@"gxGetAppUpdated"];
    [GXUserDefaults synchronize];
}

@end
