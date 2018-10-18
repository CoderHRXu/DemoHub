//
//  HRNavigationController.swift
//  HRSwiftDemo
//
//  Created by haoran on 2018/10/18.
//  Copyright © 2018年 haoran. All rights reserved.
//

import UIKit

class HRNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent     = false
        navigationBar.tintColor         = UIColor.white
        navigationBar.barTintColor      = UIColor.init(hexString: "#3D88EA")
        //隐藏NavigationBar黑线
        navigationBar.setBackgroundImage(UIImage.init(), for: .any, barMetrics: .default)
        navigationBar.shadowImage       = UIImage.init()
        //设置字体和字体颜色
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)
        ];
    }
    
    // MARK: - Override
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        delegate = nil
        interactivePopGestureRecognizer?.delegate = nil
        NotificationCenter.default.removeObserver(self)
    }

}

// MARK: - UINavigationControllerDelegate
extension HRNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard navigationController is HRNavigationController else {
            return
        }
        
    }
    
}

// MARK: - UIGestureRecognizerDelegate

extension HRNavigationController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == interactivePopGestureRecognizer else {
            return true // default value
        }
        
        // Disable pop gesture in two situations:
        // 1) when the pop animation is in progress
        // 2) when user swipes quickly a couple of times and animations don't have time to be performed
        return viewControllers.count > 1
    }
}
