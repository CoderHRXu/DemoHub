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
    

}
