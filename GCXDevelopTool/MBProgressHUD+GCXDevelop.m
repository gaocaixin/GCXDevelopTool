//
//  MBProgressHUD+GCXDevelop.m
//  LOCO
//
//  Created by 高才新 on 16/1/7.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import "MBProgressHUD+GCXDevelop.h"

@implementation MBProgressHUD (GCXDevelop)

+ (void)gcxShowNotiInView:(UIView *)view duration:(CGFloat)duration image:(UIImage *)image text:(NSString *)text {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    if (text.length > 0) {
        hud.labelText = text;
    }
    if (image) {
        hud.customView = [[UIImageView alloc] initWithImage:image];
    }
    //    hud.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    hud.color = [UIColor colorWithWhite:0 alpha:0.88];
    hud.dimBackground = NO;
    hud.cornerRadius = 8;
    hud.animationType  = MBProgressHUDAnimationFade;
    [view addSubview:hud];
    hud.labelFont = [UIFont fontWithName:@"AvenirNext-Regular" size:[UIFont systemFontSize]];
//    hud.labelFont = [UIFont systemFontSize];
    [hud show:YES];
    [hud hide:YES afterDelay:duration];
}

@end

