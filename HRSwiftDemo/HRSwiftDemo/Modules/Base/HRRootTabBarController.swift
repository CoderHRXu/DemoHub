//
//  HRBaseTabBarController.swift
//  HRSwiftDemo
//
//  Created by haoran on 2018/10/18.
//  Copyright © 2018年 haoran. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import SwifterSwift


class HRRootTabBarController: ESTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
        addChildVC()
//        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    /**
     *  iOS10 清除tabber线条颜色
     */
    private func clearTabBarLine() {
        
        let rect                = CGRect(x: 0, y: 0, width:kScreenWidth, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext? = UIGraphicsGetCurrentContext()
        context?.setFillColor((UIColor(hexString: "EBEBEB")?.cgColor)!)
        context?.fill(rect)
        let img: UIImage?       = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        tabBar.shadowImage      = img
        tabBar.backgroundImage  = UIImage()
        
    }
    
    //MARK: UI
    private func setUpTabBar() {
        clearTabBarLine()
        view.backgroundColor             = UIColor.white
    }
    
    /**
     *  添加一个子控制器
     */
    private func setUpOneChildView(_ vc: UIViewController, image: UIImage, selectedImage: UIImage, title: String?) -> HRNavigationController {


        var itemContentView : ESTabBarItemContentView?
        // 加号特殊处理
        if title == nil {
            itemContentView                 = ExampleBasicContentView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
            
        }else{
            itemContentView                 = ExampleBouncesContentView.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
            itemContentView?.imageView.size = CGSize(width: 40, height: 30)
        }
        itemContentView?.renderingMode      = .alwaysOriginal
        let tabBarItem                      = ESTabBarItem.init(itemContentView!, title:title, image: image, selectedImage: selectedImage)

        let nav                             = HRNavigationController(rootViewController: vc)
        nav.tabBarItem                      = tabBarItem
        return nav
    }

    
    private func addChildVC(){
        
        
        let homeVC              = setUpOneChildView(HomeViewController(), image: R.image.tabbar_notify_normal()!, selectedImage: R.image.tabbar_notify_selected()!, title: "动态")
        
        let learningVc          = setUpOneChildView(ViewController(), image:R.image.tabbar_learn_normal()!, selectedImage: R.image.tabbar_learn_selected()!, title: "学情追踪")
        
        let plusVc              = setUpOneChildView(ViewController(), image: R.image.tab_plus()!, selectedImage: R.image.tab_plus()!, title:nil)
        
        //题库
        
        let questionsVc         = setUpOneChildView(ViewController(), image:R.image.tabbar_questions_normal()!, selectedImage:R.image.tabbar_questions_selected()!, title: "题库")
        
        //个人中心
        let meVC                = setUpOneChildView(ViewController(), image:R.image.tabbar_me_normal()!, selectedImage: R.image.tabbar_me_selected()!, title: "我的")
        
        viewControllers         = [homeVC, learningVc, plusVc, questionsVc, meVC]
        selectedIndex           = 0
        
        self.shouldHijackHandler = {(_ , _, index: Int) in
            return index == 2
        }
        
        self.didHijackHandler   = {(_ , _, _ index: Int) in
            
            print("点击了第二个tabbaritem")
        
        }
        
        
    }
    
    
}
