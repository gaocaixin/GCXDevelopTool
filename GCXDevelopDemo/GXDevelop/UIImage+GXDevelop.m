//
//  UIImage+GXDevelop.m
//  LOCO
//
//  Created by 高才新 on 16/1/21.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import "UIImage+GXDevelop.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <float.h>
#include <ImageIO/ImageIO.h>
#import <Accelerate/Accelerate.h>
#import <MobileCoreServices/MobileCoreServices.h>

@implementation UIImage (GXDevelop)
+ (UIImage*)gxImageWithColor:(UIColor*)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    path.lineWidth = 0;
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    [path fill];
    [path stroke];
    [path addClip];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)gxImageName:(NSString *)name tintColor:(UIColor *)color
{
    UIImage *image = [UIImage imageNamed:name];
    image = [image gxImageWithTintColor:color];
    return image;
}

- (UIImage *)gxImageWithTintColor:(UIColor *)tintColor {
    return [self gxImageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *)gxImageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode {
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

+ (NSMutableArray *)gxParseGifDataToImageArray:(NSData *)data;
{
//    NSMutableArray *frames = [[NSMutableArray alloc] init];
//    CGImageSourceRef src = CGImageSourceCreateWithData((CFDataRef)data, NULL);
//    CGFloat animationTime = 0.f;
//    if (src) {
//        size_t l = CGImageSourceGetCount(src);
//        frames = [NSMutableArray arrayWithCapacity:l];
//        for (size_t i = 0; i < l; i++) {
//            CGImageRef img = CGImageSourceCreateImageAtIndex(src, i, NULL);
//            NSDictionary *properties = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(src, i, NULL));
//            NSDictionary *frameProperties = [properties objectForKey:(NSString *)kCGImagePropertyGIFDictionary];
//            NSNumber *delayTime = [frameProperties objectForKey:(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
//            animationTime += [delayTime floatValue];
//            if (img) {
//                [frames addObject:[UIImage imageWithCGImage:img]];
//                CGImageRelease(img);
//            }
//        }
//        CFRelease(src);
//    }
//    return frames;
    
    
    //通过data获取image的数据源
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    //获取帧数
    size_t count = CGImageSourceGetCount(source);
    
    NSMutableArray* tmpArray = [NSMutableArray array];
    for (size_t i = 0; i < count; i++)
    {
        //获取图像
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, i, NULL);
        
        //生成image
        UIImage *image = [UIImage imageWithCGImage:imageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
        
        [tmpArray addObject:image];
        
        CGImageRelease(imageRef);
    }
    CFRelease(source);
    
    return tmpArray;
}

+ (void)gxImgsToGifWithImgs:(NSArray *)imgs path:(NSString *)path intervalTime:(CGFloat)time;
{
//    NSMutableArray *imgs = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"], nil];
    
    //图像目标
    CGImageDestinationRef destination;
    
    //创建输出路径
//    NSArray *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentStr = [document objectAtIndex:0];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *textDirectory = [documentStr stringByAppendingPathComponent:@"gif"];
//    [fileManager createDirectoryAtPath:textDirectory withIntermediateDirectories:YES attributes:nil error:nil];
//    NSString *path = [textDirectory stringByAppendingPathComponent:@"test101.gif"];
//    NSLog(@"%@",path);
    
    //创建CFURL对象
    /*
     CFURLCreateWithFileSystemPath(CFAllocatorRef allocator, CFStringRef filePath, CFURLPathStyle pathStyle, Boolean isDirectory)
     
     allocator : 分配器,通常使用kCFAllocatorDefault
     filePath : 路径
     pathStyle : 路径风格,我们就填写kCFURLPOSIXPathStyle 更多请打问号自己进去帮助看
     isDirectory : 一个布尔值,用于指定是否filePath被当作一个目录路径解决时相对路径组件
     */
    CFURLRef url = CFURLCreateWithFileSystemPath (
                                                  kCFAllocatorDefault,
                                                  (CFStringRef)path,
                                                  kCFURLPOSIXPathStyle,
                                                  false);
    
    //通过一个url返回图像目标
    destination = CGImageDestinationCreateWithURL(url, kUTTypeGIF, imgs.count, NULL);
    
    //设置gif的信息,播放间隔时间,基本数据,和delay时间
    NSDictionary *frameProperties = [NSDictionary
                                     dictionaryWithObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:time], (NSString *)kCGImagePropertyGIFDelayTime, nil]
                                     forKey:(NSString *)kCGImagePropertyGIFDictionary];
    
    //设置gif信息
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
    
    [dict setObject:[NSNumber numberWithBool:YES] forKey:(NSString*)kCGImagePropertyGIFHasGlobalColorMap];
    
    [dict setObject:(NSString *)kCGImagePropertyColorModelRGB forKey:(NSString *)kCGImagePropertyColorModel];
    
    [dict setObject:[NSNumber numberWithInt:8] forKey:(NSString*)kCGImagePropertyDepth];
    
    [dict setObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount];
    NSDictionary *gifProperties = [NSDictionary dictionaryWithObject:dict
                                                              forKey:(NSString *)kCGImagePropertyGIFDictionary];
    //合成gif
    for (UIImage* dImg in imgs)
    {
        CGImageDestinationAddImage(destination, dImg.CGImage, (__bridge CFDictionaryRef)frameProperties);
    }
    CGImageDestinationSetProperties(destination, (__bridge CFDictionaryRef)gifProperties);
    CGImageDestinationFinalize(destination);
    CFRelease(destination);

}


+ (UIImage *)gxGetImageWithVideoURL:(NSURL *)videoURL curTime:(CGFloat)curTime

{
    
    // 根据视频的URL创建AVURLAsset
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    
   return  [UIImage gxGetImageWithVideoAsset:asset curTime:curTime];
}

+ (UIImage *)gxGetImageWithVideoAsset:(AVURLAsset *)asset curTime:(CGFloat)curTime

{
    // 根据AVURLAsset创建AVAssetImageGenerator对象
    
    AVAssetImageGenerator* gen = [[AVAssetImageGenerator alloc] initWithAsset: asset];
    // 精确定位时间 否则系统优化会选择临近的时间点返回图片
    gen.requestedTimeToleranceBefore= kCMTimeZero;
    gen.requestedTimeToleranceAfter= kCMTimeZero;
    
    gen.appliesPreferredTrackTransform = YES;
    
    // 定义获取0帧处的视频截图
    
    CMTime time = CMTimeMakeWithSeconds(curTime, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    // 获取time处的视频截图
    
    CGImageRef  image = [gen  copyCGImageAtTime: time actualTime: &actualTime error:&error];
    
    // 将CGImageRef转换为UIImage
    
    UIImage *thumb = [[UIImage alloc] initWithCGImage: image];
    
    CGImageRelease(image);
    
    return  thumb;
}

+ (UIImage *)gxGetImageWithVideoAsset:(AVURLAsset *)asset curTime:(CGFloat)curTime targetSize:(CGSize)size

{
    // 根据AVURLAsset创建AVAssetImageGenerator对象
    
    AVAssetImageGenerator* gen = [[AVAssetImageGenerator alloc] initWithAsset: asset];
    // 精确定位时间 否则系统优化会选择临近的时间点返回图片
    gen.requestedTimeToleranceBefore= kCMTimeZero;
    gen.requestedTimeToleranceAfter= kCMTimeZero;
    
    gen.appliesPreferredTrackTransform = YES;
    
    // 定义获取0帧处的视频截图
    
    CMTime time = CMTimeMakeWithSeconds(curTime, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    // 获取time处的视频截图
    
    CGImageRef  image = [gen  copyCGImageAtTime: time actualTime: &actualTime error:&error];
    
    // 将CGImageRef转换为UIImage
    
    UIImage *thumb = [[UIImage alloc] initWithCGImage: image];
    
    UIImage *imageTarget = [UIImage gxGetAspectFillImage:[thumb copy] targetSize:size isOpaque:NO];
    
    CGImageRelease(image);
    
    return  imageTarget;
}


+ (NSMutableArray *)gxGetImagesWithAsset:(AVURLAsset *)asset minTime:(CGFloat)minTime maxTime:(CGFloat)maxTime imageCount:(NSInteger )imageCount
{
    CGFloat timePadding = (maxTime - minTime)/imageCount;
    UIImage *image = nil;
    NSMutableArray *imageArr = [NSMutableArray array];
    for (CGFloat time = minTime; time <= maxTime; time+=timePadding) {
        @autoreleasepool {
            image = [UIImage gxGetImageWithVideoAsset:asset curTime:time];
            [imageArr addObject:[image copy]];
            image = nil;
        }
    }
    return imageArr;
}
+ (NSMutableArray *)gxGetImagesWithAsset:(AVURLAsset *)asset minTime:(CGFloat)minTime maxTime:(CGFloat)maxTime imageCount:(NSInteger )imageCount targetSize:(CGSize)size
{
    CGFloat timePadding = (maxTime - minTime)/imageCount;
    UIImage *image = nil;
    NSMutableArray *imageArr = [NSMutableArray array];
    for (CGFloat time = minTime+timePadding/2.; time < maxTime; time+=timePadding) {
        @autoreleasepool {
            image = [UIImage gxGetImageWithVideoAsset:asset curTime:time targetSize:size];
            [imageArr addObject:[image copy]];
            image = nil;
        }
    }
    return imageArr;
}


//   other code
- (UIImage *)gxStretch{
    return [self stretchableImageWithLeftCapWidth:self.size.width/2 topCapHeight:self.size.height/2];
}
-(UIImage*)gxScaleToSize:(NSInteger)size {
    NSInteger kMaxResolution = size; // Or whatever
    
    CGImageRef imgRef = self.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = self.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}



- (UIImage *) gxImageWithGradientTintColor:(UIColor *)tintColor {
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode {
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

- (UIImage *) gxImageWithBorderColor:(UIColor *)borderColor width:(CGFloat) width{
    CGSize size = [self size];
    //UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [self drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0];
    
    CGFloat red = 0.0f;
    CGFloat green = 0.0f;
    CGFloat blue = 0.0f;
    CGFloat alpha = 0.0f;
    //    ASSERT([borderColor getRed:&red green:&green blue:&blue alpha:&alpha]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, red, green, blue, alpha);
    CGContextSetLineWidth(context, width);
    CGContextStrokeRect(context, rect);
    UIImage *returnImage =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnImage;
}

- (UIImage *)gxImageWithScaledToSize:(CGSize)newSize {
    if (CGSizeEqualToSize(self.size, newSize))
        return self;
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnImage;
}

/*
 * @brief rotate image 90 with Clockwise
 */
- (UIImage*)gxRotate90Clockwise {
    UIImage *image = nil;
    
    switch (self.imageOrientation) {
        case UIImageOrientationUp:
            image = [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationRight];
            break;
        case UIImageOrientationDown:
            image = [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationLeft];
            break;
        case UIImageOrientationLeft:
            image = [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationUp];
            break;
        case UIImageOrientationRight:
            image = [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationDown];
            break;
        case UIImageOrientationUpMirrored:
            image = [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationLeftMirrored];
            break;
        case UIImageOrientationDownMirrored:
            image = [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationRightMirrored];
            break;
        case UIImageOrientationLeftMirrored:
            image = [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationDownMirrored];
            break;
        case UIImageOrientationRightMirrored:
            image = [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationUpMirrored];
            break;
        default:
            break;
    }
    
    return image;
}

/*
 * @brief flip horizontal
 */
- (UIImage*)gxFlipHorizontal {
    UIImage *image = nil;
    
    switch (self.imageOrientation) {
        case UIImageOrientationUp:
            image = [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationUpMirrored];
            break;
        case UIImageOrientationDown:
            image = [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationDownMirrored];
            break;
        case UIImageOrientationLeft:
            image = [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationRightMirrored];
            break;
        case UIImageOrientationRight:
            image = [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationLeftMirrored];
            break;
        case UIImageOrientationUpMirrored:
            image = [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationUp];
            break;
        case UIImageOrientationDownMirrored:
            image = [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationDown];
            break;
        case UIImageOrientationLeftMirrored:
            image = [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationRight];
            break;
        case UIImageOrientationRightMirrored:
            image = [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationLeft];
            break;
        default:
            break;
    }
    
    return image;
}

- (UIImage *)gxFixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+ (UIImage*) gxImageDeepCopy: (UIImage *)imageToCopy {
    UIGraphicsBeginImageContextWithOptions(imageToCopy.size, YES, [imageToCopy scale]);
    [imageToCopy drawInRect:CGRectMake(0, 0, imageToCopy.size.width, imageToCopy.size.height)];
    UIImage *copiedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return copiedImage;
}

- (CGFloat)gxWidth{
    return self.size.width;
}
- (CGFloat)gxHeight{
    return self.size.height;
}
- (UIImage *)gxMirrorVertical{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef contex = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(contex, self.gxWidth, 0);
    CGContextScaleCTM(contex, -1.0, 1.0);
    CGContextDrawImage(contex, CGRectMake(0, 0, self.gxWidth, self.gxHeight), self.CGImage);
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnImage;
}

- (UIImage *)gxMirrorHorizon{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef contex = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(contex, self.gxWidth, self.gxHeight);
    CGContextScaleCTM(contex, -1.0, -1.0);
    CGContextDrawImage(contex, CGRectMake(0, 0, self.gxWidth, self.gxHeight), self.CGImage);
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnImage;
}


- (void)blurredImageAsyncWithRadius:(CGFloat)radius saturationDeltaFactor:(CGFloat)factor tintColor:(UIColor *)tintColor onComplete:(void(^)(UIImage *img))complete{
    if (!complete)
        return;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        UIImage *img = [self applyBlurWithRadius:radius tintColor:tintColor saturationDeltaFactor:factor maskImage:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete(img);
            }
        });
    });
    
}

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage {
    return [self applyBlurWithRadius:blurRadius tintColor:tintColor saturationDeltaFactor:saturationDeltaFactor maskImage:maskImage alpha:NO];
}
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage alpha:(BOOL)isAlpah
{
    // Check pre-conditions.
    if (self.size.width < 1 || self.size.height < 1) {
        NSLog (@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
        return nil;
    }
    if (!self.CGImage) {
        NSLog (@"*** error: image must be backed by a CGImage: %@", self);
        return nil;
    }
    if (maskImage && !maskImage.CGImage) {
        NSLog (@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    
    CGRect imageRect = { CGPointZero, self.size };
    UIImage *effectImage = self;
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
            //
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            CGFloat inputRadius = blurRadius * self.scale;
            uint32_t radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    // Set up output context.
    UIGraphicsBeginImageContextWithOptions(self.size, !isAlpah, self.scale);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    
    // Draw effect image.
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // Add in color tint.
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}


+ (UIImage *) gxImageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return img;
}

+ (CGSize) gxGetAspectFillSize:(CGSize) size targetSize:(CGSize)dest {
    CGFloat scale = MAX(dest.width*1.f/size.width, dest.height*1.f/size.height);
    return CGSizeMake((size.width*scale),(size.height*scale));
}

+ (UIImage *) gxGetAspectFillImage:(UIImage *)imageToCopy targetSize:(CGSize)size isOpaque:(BOOL)isOpaque {
    CGSize image_size = imageToCopy.size;
    
    CGSize draw_size = [UIImage gxGetAspectFillSize:image_size targetSize:size];
    CGRect rect = CGRectMake((size.width-draw_size.width)/2.f, (size.height-draw_size.height)/2.f, draw_size.width, draw_size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, isOpaque, [[UIScreen mainScreen] scale]);
    
    CGContextRef _cgctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(_cgctx);
    CGContextSetInterpolationQuality(_cgctx, kCGInterpolationHigh);
    CGContextSetAllowsAntialiasing(_cgctx, YES);
    CGContextSetShouldAntialias(_cgctx, YES);
    [imageToCopy drawInRect:rect];
    CGContextRestoreGState(_cgctx);
    UIImage *copiedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return copiedImage;
}

// aspect fit for dest ( but the size can cover the dest) aka: the smallest size for performance with kept ratio
+ (UIImage*) gxGetScaleFitImage:(UIImage *) imageToCopy  targetSize:(CGSize)size {
    CGSize image_size = imageToCopy.size;
    
    CGSize draw_size = [UIImage gxGetAspectFillSize:image_size targetSize:size];
    
    CGRect rect = CGRectMake(0, 0, draw_size.width, draw_size.height);
    
    UIGraphicsBeginImageContextWithOptions(draw_size, YES, [[UIScreen mainScreen] scale]);
    
    CGContextRef _cgctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(_cgctx);
    CGContextSetInterpolationQuality(_cgctx, kCGInterpolationHigh);
    CGContextSetAllowsAntialiasing(_cgctx, YES);
    CGContextSetShouldAntialias(_cgctx, YES);
    [imageToCopy drawInRect:rect];
    CGContextRestoreGState(_cgctx);
    UIImage *copiedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return copiedImage;
}


+ (UIImage*)gxImageByCombiningImage:(UIImage*)firstImage withImage:(UIImage*)secondImage {
    UIImage *image = nil;
    
    CGSize newImageSize = CGSizeMake(MAX(firstImage.size.width, secondImage.size.width), MAX(firstImage.size.height, secondImage.size.height));
    
    UIGraphicsBeginImageContextWithOptions(newImageSize, NO, [[UIScreen mainScreen] scale]);
    [firstImage drawAtPoint:CGPointMake(roundf((newImageSize.width-firstImage.size.width)/2),
                                        roundf((newImageSize.height-firstImage.size.height)/2))];
    [secondImage drawAtPoint:CGPointMake(roundf((newImageSize.width-secondImage.size.width)/2),
                                         roundf((newImageSize.height-secondImage.size.height)/2))];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}



@end
