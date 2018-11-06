//
//  UIViewController+Extension.swift
//  StormSpirit
//
//  Created by fanyinan2 on 2018/3/7.
//  Copyright © 2018年 tianzhedong. All rights reserved.
//


extension UIViewController {
    
    static var currentViewController: UIViewController {
        return getCurrentViewController(UIApplication.shared.keyWindow!.rootViewController!)
    }
    
    class func getCurrentViewController(_ viewController: UIViewController) -> UIViewController {
        if let viewController = viewController.presentedViewController {
            return getCurrentViewController(viewController)
        }
        if let viewController = viewController as? UINavigationController,
            viewController.viewControllers.count > 0 {
            return getCurrentViewController(viewController.topViewController!)
        }
        if let viewController = viewController as? UITabBarController,
            viewController.viewControllers!.count > 0 {
            return getCurrentViewController(viewController.selectedViewController!)
        }
        return viewController
    }
    
}
