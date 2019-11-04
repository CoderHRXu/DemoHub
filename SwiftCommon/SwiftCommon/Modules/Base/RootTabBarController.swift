//
//  RootTabBarController.swift
//  SwiftCommon
//
//  Created by haoran on 2019/10/14.
//  Copyright © 2019 haoran. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class RootTabBarController: ESTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
        addChildVC()
        // Do any additional setup after loading the view.
    }
    

    // MARK: UI
    private func setUpTabBar() {
        clearTabBarLine()
        view.backgroundColor             = UIColor.white
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

    /**
     *  添加一个子控制器
     */
    private func setUpOneChildView(_ vc: UIViewController, image: UIImage, selectedImage: UIImage, title: String?) -> BaseNavigationController {


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

        let nav                             = BaseNavigationController(rootViewController: vc)
        nav.tabBarItem                      = tabBarItem
        return nav
    }

    
    private func addChildVC(){
        
        
//        let homeVC              = setUpOneChildView(HomeViewController(), image: R.image.tabbar_notify_normal()!, selectedImage: R.image.tabbar_notify_selected()!, title: "动态")
        let homeVC              = setUpOneChildView(ViewController(), image: R.image.tabbar_notify_normal()!, selectedImage: R.image.tabbar_notify_selected()!, title: "动态")

//
//        let learningVc          = setUpOneChildView(MyFormViewController(), image:R.image.tabbar_learn_normal()!, selectedImage: R.image.tabbar_learn_selected()!, title: "学情追踪")
        let learningVc              = setUpOneChildView(ViewController(), image: R.image.tabbar_notify_normal()!, selectedImage: R.image.tabbar_notify_selected()!, title: "学情追踪")

//
//        let plusVc              = setUpOneChildView(ViewController(), image: R.image.tab_plus()!, selectedImage: R.image.tab_plus()!, title:nil)
        let plusVc              = setUpOneChildView(HomeViewController(), image: R.image.tabbar_notify_normal()!, selectedImage: R.image.tabbar_notify_selected()!, title: "动态")

//
//        //题库

        let questionsVc         = setUpOneChildView(ViewController(), image:UIImage(named: "tabbar_questions_normal")!, selectedImage:UIImage(named: "tabbar_questions_seleted")!, title: "题库")
//
//        //个人中心
        let meVC                = setUpOneChildView(ViewController(), image:UIImage.init(named: "tabbar_me_normal")!, selectedImage: UIImage.init(named: "tabbar_me_selected")!, title: "我的")

//        let meVC                = setUpOneChildView(ViewController(), image:R.image.tabbar_me_normal()!, selectedImage: R.image.tabbar_me_selected()!, title: "我的")
        
        viewControllers         = [ViewController(), ViewController(), ViewController(), ViewController(), ViewController()]
        selectedIndex           = 0
        
        self.shouldHijackHandler = {(_ , _, index: Int) in
            return index == 2
        }
        
        self.didHijackHandler   = {(_ , _, _ index: Int) in
            
            print("点击了第二个tabbaritem")
        
        }
        
        
    }
}
