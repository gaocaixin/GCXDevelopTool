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


#import <sys/stat.h>
#import <dlfcn.h>

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

+ (void)gxGetAudioAuthorizationCompletion:(void (^)(BOOL allow, NSError * authenticationError))authenticateCompletion
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
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

+ (NSString *)gxOsVersionBuild {
    int mib[2] = {CTL_KERN, KERN_OSVERSION};
    size_t size = 0;
    // Get the size for the buffer
    sysctl(mib, 2, NULL, &size, NULL, 0);
    char *answer = malloc(size);
    sysctl(mib, 2, answer, &size, NULL, 0);
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    free(answer);
    return results;  
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


+ (void)gxShowAllFilters
{
    
    NSArray *filterNames=[CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    
     for (NSString *filterName in filterNames) {
        
         CIFilter *filter=[CIFilter filterWithName:filterName];
        
         GXLog(@"AllFilters--name:%@ attributes:%@",filterName,[filter attributes]);
     }
}
+ (void)gxLogDocumentPath {
    GXLog([[NSString alloc] initWithFormat:@"NSHomeDirectory:%@", NSHomeDirectory()]);
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

+ (void)gxGetAppUpdated:(void (^)(NSString *perVersion, NSString *curVersion , BOOL install,BOOL update))complete
{
    NSString *perVersion = [GXUserDefaults stringForKey:@"gxGetAppUpdated"];
    NSString *curVersion = GXSharedApp.gxAppVersion;
    if (perVersion == nil) {
        if (complete) {
            complete(perVersion,curVersion, YES,YES);
        }
    } else if ([perVersion isEqualToString:curVersion]) {
        if (complete) {
            complete(perVersion,curVersion,NO,NO);
        }
    } else {
        if (complete) {
            complete(perVersion,curVersion,NO,YES);
        }
    }
    [GXUserDefaults setObject:curVersion forKey:@"gxGetAppUpdated"];
    [GXUserDefaults synchronize];
}

+ (BOOL) gxIsIphoneX
{
    if ([self gxIsiPad]) {
        return false;
    }
    CGSize size = [UIScreen mainScreen].bounds.size;
    if (CGSizeEqualToSize(size, CGSizeMake(375,812 )) || [self gxIsIphoneXMax]) {
        return true;
    }
    return  false;
}

+ (BOOL) gxIsIphoneXMax
{
    if ([self gxIsiPad]) {
        return false;
    }
    CGSize size = [UIScreen mainScreen].bounds.size;
    if (CGSizeEqualToSize(size, CGSizeMake(414, 896))) {
        return true;
    }
    return  false;
}

+ (NSString*)deviceModelName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,1"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,4"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,3"])   return @"iPhone_X";
    if ([deviceModel isEqualToString:@"iPhone10,6"])   return @"iPhone_X";
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    if ([deviceModel isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
    if ([deviceModel isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";
    
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceModel;
}


+ (BOOL) gxIsiPad
{
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if([deviceType isEqualToString:@"iPhone"]) {
        //iPhone
        return NO;
    }
    else if([deviceType isEqualToString:@"iPod touch"]) {
        //iPod Touch
        return NO;
    }
    else if([deviceType isEqualToString:@"iPad"]) {
        //iPad
        return YES;
    }
    return NO;
}

+ (BOOL)gxIsPrisonBreak
{
    if ([self checkPath] ||[self checkCydia] ||[self checkEnv] ||[self checkCydiasys]) {
        return YES;
    }
    return NO;
}
+ (BOOL)checkPath
{
    BOOL jailBroken = NO;
    NSString * cydiaPath = @"/Applications/Cydia.app";
    NSString * aptPath = @"/private/var/lib/apt";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        jailBroken = YES;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        jailBroken = YES;
    }
    return jailBroken;
}
+ (BOOL)checkCydia
{
    struct stat stat_info;
    if (0 == stat("/Applications/Cydia.app", &stat_info)) {
        NSLog(@"Device is jailbroken");
        return YES;
    }
    return NO;
}
+ (BOOL)checkEnv
{
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    NSLog(@"%s", env);
    if (env) {
        return YES;
    }
    return NO;
}
+ (BOOL)checkCydiasys
{
    int ret;
    Dl_info dylib_info;
    int (*func_stat)(const char *,struct stat *) = stat;
    if ((ret = dladdr(func_stat, &dylib_info))) {
        if (strcmp(dylib_info.dli_fname,"/usr/lib/system/libsystem_kernel.dylib") != 0) {
            return YES;
        }
    }
    return NO;
}


@end
