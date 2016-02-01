//
//  UIImageView+GCXDevelop.m
//  LOCO
//
//  Created by 高才新 on 15/12/16.
//  Copyright © 2015年 IU-Apps. All rights reserved.
//

#import "UIImageView+GCXDevelop.h"

@implementation UIImageView (GCXDevelop)

- (void)gcxSetFrame:(CGRect)frame contentMode:(UIViewContentMode)contentMode backgroundColor:(UIColor *)backgroundColor image:(UIImage *)image{
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

+ (UIImageView *)gcxImageViewFrame:(CGRect)frame contentMode:(UIViewContentMode)contentMode backgroundColor:(UIColor *)backgroundColor image:(UIImage *)image{
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView gcxSetFrame:frame contentMode:contentMode backgroundColor:backgroundColor image:image];
    return imageView;
}




@end
