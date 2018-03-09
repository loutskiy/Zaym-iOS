//
//  ViewManager.swift
//  Zachetka
//
//  Created by Mikhail Lutskiy on 19.02.2018.
//  Copyright © 2018 BigBadBird. All rights reserved.
//

import UIKit

class ViewManager {
    static func topViewController() -> UIViewController {
        return topViewControllerWithRootViewController((UIApplication.shared.keyWindow?.rootViewController)!)
    }
    
    static func topViewControllerWithRootViewController(_ rootViewController:UIViewController) -> UIViewController {
        if rootViewController.isKind(of: UITabBarController.self) {
            let tabBarController = rootViewController as! UITabBarController
            return topViewControllerWithRootViewController(tabBarController.selectedViewController!)
        } else if rootViewController.isKind(of: UINavigationController.self) {
            let navigationController = rootViewController as! UINavigationController
            return topViewControllerWithRootViewController(navigationController.visibleViewController!)
        } else if (rootViewController.presentedViewController != nil) {
            let presentedViewController = rootViewController.presentedViewController
            return topViewControllerWithRootViewController(presentedViewController!)
        } else if rootViewController.childViewControllers.count > 0 {
            return topViewControllerWithRootViewController(rootViewController.childViewControllers.last!)
        } else {
            return rootViewController
        }
    }
}
