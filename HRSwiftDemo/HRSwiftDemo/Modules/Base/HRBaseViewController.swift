//
//  HRBaseViewController.swift
//  HRSwiftDemo
//
//  Created by haoran on 2018/10/19.
//  Copyright © 2018年 haoran. All rights reserved.
//

import UIKit

enum NaviBarStyle : Int {
    
    case blue           = 1
    case transparent    = 2
    case darkGray       = 3
}

class HRBaseViewController: UIViewController {

    
    //MARK: Property
    
    /// 控制器名称
    var vcName:String? {
        willSet{
            self.title = newValue
        }
    }
    /// url传递参数
    var argument:[String : Any]?
    /// 上一个页面
    var fromPage:String?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var naviBarStyle: NaviBarStyle = .blue {
        
        willSet{
            
            guard let _ = self.navigationController else {
                return
            }
            
            for view in self.navigationController!.navigationBar.subviews {
                
                if view.height <= 2  {
                    
                    view.removeFromSuperview()
                }
            }
            
            let navigationBar       = (self.navigationController?.navigationBar)!
            
            let backBtnBarItem      = UIBarButtonItem(image: R.image.navigation_back_icon(), style: UIBarButtonItem.Style.plain, target: self, action: #selector(popViewController))
            
            if !checkNavRootVC(){
                self.navigationItem.leftBarButtonItem = backBtnBarItem
            }
            
            var isTranslucent       = false
            var barTintColor        = UIColor.init(hexString: "#3D88EA")
            var tintColor           = UIColor.white
            var titleColor          = UIColor(hex: 0x666666)
            var statusBarStyle      = UIStatusBarStyle.lightContent
            var backBtnTintColor    = UIColor.black
            
            
            switch newValue {
            case .blue:
                
                break
                
            case .transparent:
                
                backBtnTintColor    = .white
                isTranslucent       = true
                barTintColor        = UIColor.white
                tintColor           = UIColor.black
                titleColor          = UIColor.white
                statusBarStyle      = UIStatusBarStyle.lightContent
                
            case .darkGray:
                
                backBtnTintColor    = .white
                isTranslucent       = false
                barTintColor        = UIColor(hex: 0x454545) ?? .white
                tintColor           = UIColor.white
                titleColor          = UIColor.white
                statusBarStyle      = UIStatusBarStyle.lightContent
            }
            
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            
            backBtnBarItem.tintColor            = backBtnTintColor
            navigationBar.isTranslucent         = isTranslucent
            navigationBar.barTintColor          = barTintColor
            navigationBar.tintColor             = tintColor
            navigationBar.titleTextAttributes   = [NSAttributedString.Key.foregroundColor:titleColor ?? .white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
            UIApplication.shared.statusBarStyle = statusBarStyle
            
        }
    }
    
    private func checkNavRootVC () -> Bool {
        
        return self.navigationController?.viewControllers[0] == self
    }
    
    @objc @discardableResult
    func popViewController() -> UIViewController? {
        
        return self.navigationController?.popViewController(animated: true)
    }
}
