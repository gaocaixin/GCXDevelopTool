//
//  UIImageView+GXDevelop.m
//  LOCO
//
//  Created by 高才新 on 15/12/16.
//  Copyright © 2015年 IU-Apps. All rights reserved.
//

#import "UIImageView+GXDevelop.h"

@implementation UIImageView (GXDevelop)

- (void)gxSetFrame:(CGRect)frame contentMode:(UIViewContentMode)contentMode backgroundColor:(UIColor *)backgroundColor image:(UIImage *)image{
    [self setFrame:frame];
    self.contentMode = contentMode;
    if (image) {
        self.image = image;
    }
    if (!backgroundColor) {
        backgroundColor = [UIColor clearColor];    
    }
    self.backgroundColor = backgroundColor;
}

+ (UIImageView *)gxImageViewFrame:(CGRect)frame contentMode:(UIViewContentMode)contentMode backgroundColor:(UIColor *)backgroundColor image:(UIImage *)image{
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView gxSetFrame:frame contentMode:contentMode backgroundColor:backgroundColor image:image];
    return imageView;
}




@end
