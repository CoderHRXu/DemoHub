//
//  ViewController.swift
//  MultipleLan
//
//  Created by haoran on 2019/12/9.
//  Copyright © 2019 haoran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        test()
    }
    
    
    func test() {
        
        let label = UILabel.init(frame: CGRect(x: 10, y: 10, width: 100, height: 50))
//        label.text = NSLocalizedString("labelText", comment: "测试", bundle: nil,)
        label.text = NSLocalizedString("labelText", tableName: "Language", bundle: Bundle.main, value: "value", comment: "comment")
        view.addSubview(label)
        
        let btn = UIButton.init(frame: CGRect(x: 10, y: 200, width: 100, height: 100))
        btn.setTitle(NSLocalizedString("btnNormalTitle", tableName: "Language", bundle: Bundle.main, value: "按钮文字", comment: "注释"), for: .normal)
        btn.sizeToFit()
        view.addSubview(btn)
        btn.setTitleColor(UIColor.black, for: .normal)
    }

    
    @IBAction func btnclick(_ btn: UIButton) {
        
        var language = "en"
        if let lan = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String] {
            
            language = lan.first == "en" ? "es" : "en"
        }
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
//        let delagate = UIApplication.shared.delegate as! AppDelegate
//        delagate.perform(controller: vc)
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
}

