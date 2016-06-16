//
//  UIViewController+GXDevelop.m
//  GIFY
//
//  Created by 高才新 on 16/5/23.
//  Copyright © 2016年 Steven.C. All rights reserved.
//

#import "UIViewController+GXDevelop.h"

@implementation UIViewController (GXDevelop)

- (void)gxDismissViewController:(BOOL)animationed completion:(void (^)(void))complete
{
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:animationed];
            if (complete) {
                complete();
            }
        } else {
            [self.navigationController dismissViewControllerAnimated:animationed completion:complete];
        }
    } else {
        [self dismissViewControllerAnimated:animationed completion:complete];
    }
}

@end
