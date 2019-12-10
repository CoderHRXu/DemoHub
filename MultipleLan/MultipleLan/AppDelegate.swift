//
//  AppDelegate.swift
//  MultipleLan
//
//  Created by haoran on 2019/12/9.
//  Copyright © 2019 haoran. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        window                      = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController  = vc;
        window?.makeKeyAndVisible()
        return true
    }
    
    func perform(controller: UIViewController, animated: Bool = true) {
        if let previousRootViewController = window?.rootViewController {
            previousRootViewController.dismiss(animated: false) {
                previousRootViewController.view.removeFromSuperview()
            }
        }
        window?.rootViewController = controller
        if animated {
            UIView.transition(with: window!, duration: 0.25, options: .transitionCrossDissolve, animations: {
                self.window?.rootViewController = controller
            }, completion: nil)
        }
    }


}

