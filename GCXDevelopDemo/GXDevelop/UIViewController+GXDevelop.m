//
//  UIViewController+GXDevelop.m
//  GIFY
//
//  Created by 高才新 on 16/5/23.
//  Copyright © 2016年 Steven.C. All rights reserved.
//

#import "UIViewController+GXDevelop.h"
#import "GXDevelopKey.h"

@implementation UIViewController (GXDevelop)

- (void)gxDismissViewController:(BOOL)animationed completion:(void (^)(void))complete
{
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:animationed];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (complete) {
                    complete();
                }
            });
        } else {
            [self.navigationController dismissViewControllerAnimated:animationed completion:complete];
        }
    } else {
        [self dismissViewControllerAnimated:animationed completion:complete];
    }
}

- (void)gxPushViewController:(UIViewController *)vc animationed:(BOOL)animationed completion:(void (^)(void))complete
{
    if (self.navigationController) {
        [self.navigationController pushViewController:vc animated:animationed];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (complete) {
                complete();
            }
        });
    } else {
        [self presentViewController:vc animated:YES completion:^{
            if (complete) {
                complete();
            }
        }];
    }
}

+ (UIViewController *)gxGetCurrentVC
{
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    
    return result;
}

+ (void)gxGoRootVC
{
    GXWeakSelf(weakSelf)
    UIViewController *vc = [weakSelf gxGetCurrentVC];
    if (vc.navigationController) {
        [vc.navigationController dismissViewControllerAnimated:NO completion:^{
            [weakSelf gxGoRootVC];
        }];
    } else {
        [vc dismissViewControllerAnimated:NO completion:^{
            [weakSelf gxGoRootVC];
        }];
    }
}

@end
