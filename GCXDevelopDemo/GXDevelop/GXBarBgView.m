//
//  GXBarBgView.m
//  EarthSpirit
//
//  Created by 小新 on 2017/11/3.
//  Copyright © 2017年 KarlSW. All rights reserved.
//

#import "GXBarBgView.h"
#import "UIDevice+GXDevelop.h"

@implementation GXBarBgView

+ (GXBarBgView *)gxView:(UIColor *)color nav:(UINavigationController *)vc {
    BOOL hidden = [UIApplication sharedApplication].statusBarHidden;
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    CGRect rectNav = vc.navigationBar.frame;
    CGFloat w = MAX(rectStatus.size.width, rectNav.size.width);
    CGFloat h = rectStatus.size.height + rectNav.size.height;
    if ((hidden == true) && (h != 0) && ([UIDevice gxIsIphoneX] == true)) { // 有导航栏 没状态栏 是 iphonex
        h = h + 44;
    }
    GXBarBgView *view = [[GXBarBgView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    view.backgroundColor = color;
    return view;
}

@end
