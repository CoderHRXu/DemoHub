//
//  BaseViewController.swift
//  SwiftCommon
//
//  Created by haoran on 2019/10/14.
//  Copyright © 2019 haoran. All rights reserved.
//

import UIKit
import SwifterSwift
import Format

class BaseViewController: UIViewController {
    
    // MARK: Property
    
    /// 控制器名称
    var vcName:String?
    /// url传递参数
    var argument:[String : Any]?
    /// 上一个页面
    var fromPage:String?
    
    private let startDate = Date.init()
    
    
    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent   = false
//        navigationController?.navigationBar.barTintColor    = NavigationBarColor
        navigationController?.navigationBar.barStyle        = .default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyBoard()
    }
    
    /// 隐藏键盘
    func hideKeyBoard() {
        
        UIApplication.shared.keyWindow?.endEditing(true)
    }
    

    
    deinit {
        
        let classString = String(describing: self.classForCoder)
        
//        FCLogger.error("\(classString)-- deinit")
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: Public Methods
    
    /// 设置参数 需要子类扩展
    ///
    /// - Parameter para: 参数
    @objc func setArgument(para: [String : Any]?) {
        
        if let para = para {
            vcName      = para["vcName"] as? String
            fromPage    = para["fromPage"] as? String
            argument    = para
        }
    }
    
    // MARK: - UI
    
    
    /// 设置导航条左边按钮
    ///
    /// - Parameters:
    ///   - leftStr: 按钮文字
    ///   - imageName: 图片名
    func setNavigationLeftItem( leftStr: String, imageName: String?) {
      
        let leftItem = self.createBarButtonItem(title: leftStr, imageName: imageName, action: #selector(naviLeftBtnClick(_:) ))
        
        self.navigationItem.setLeftBarButton(leftItem, animated: true)
    }
    
    
    /// 设置导航条右边按文字
    ///
    /// - Parameters:
    ///   - rightStr: 按钮文字
    ///   - imageName: 图片名称
    func setNavigationRightItem(rightStr: String, imageName: String?) {
      
        let rightItem = self.createBarButtonItem(title: rightStr, imageName: imageName, action: #selector(naviRightBtnClick(_:) ))
        
        self.navigationItem.setRightBarButton(rightItem, animated: true)
    }
    
    // MARK: - event
    /// 导航条左边按钮点击（子类不重写重写默认返回）
    ///
    /// - Parameter btn: 按钮
    @objc func naviLeftBtnClick(_ btn: UIButton){
        self.navigationController?.popViewController()
        
    }
    
    /// 导航条右边按钮点击（需要子类重写）
    ///
    /// - Parameter btn: 按钮
    @objc func naviRightBtnClick(_ btn: UIButton){
        
    }
    
    
    // MARK: - private method
    private func createBarButtonItem(title: String, imageName: String?, action: Selector?) -> UIBarButtonItem{
        
        var item = UIBarButtonItem.init()
        
        // 有图标先设置图标
        if let icon = imageName, icon.count > 0 {
            
            let icon = UIImage.init(named: icon)
            item = UIBarButtonItem.init(image: icon, style: .plain, target: self, action: action)
       
            
        }else{
            item = UIBarButtonItem.init(title: title, style: .plain, target: self, action: action)
        }
        return item
    }
    
    func getButtonNavigationTitle(_ title: String, imageName: String, imageHighlightedName: String) -> UIButton {
        
        let btn                             = UIButton(type: .custom)
        btn.titleLabel?.font                = UIFont.boldSystemFont(ofSize: 20)
        btn.imageView?.bounds               = CGRect(x: 0, y: 0, width: 20, height: 20)
        btn.imageView?.contentMode          = .scaleAspectFit
        btn.contentHorizontalAlignment      = .right
        btn.setTitle(title, for: .normal)
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: imageHighlightedName), for: .selected)
        btn.sizeToFit()
        btn.titleEdgeInsets                 = UIEdgeInsets.init(top: 10, left: -(btn.imageView?.image?.size.width)!, bottom: 0, right: (btn.imageView?.image?.size.width)!)
        btn.imageEdgeInsets                 = UIEdgeInsets.init(top: 10, left: (btn.titleLabel?.bounds.size.width)! + 3, bottom: 10, right: -(btn.titleLabel?.bounds.size.width)! - 3)
        btn.addTarget(self, action: Selector(("onTitleBarButton:")), for: .touchUpInside)
        navigationItem.titleView            = btn
        return btn
    }
    
    
    /// 快速文字弹窗
    /// - Parameter title: 标题
    /// - Parameter message: 消息
    func flash(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.default)
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

}
