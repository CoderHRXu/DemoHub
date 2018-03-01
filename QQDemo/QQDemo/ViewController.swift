//
//  ViewController.swift
//  QQDemo
//
//  Created by haoran on 2018/1/23.
//  Copyright © 2018年 fclassroom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnClick(_ sender: Any) {
        
        
        let urlStr = "http://10.0.3.86/中文/main.html#/help"
       
        let str = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        
//        let charSet = CharacterSet.urlQueryAllowed as NSCharacterSet
//        let mutSet = charSet.mutableCopy() as! NSMutableCharacterSet
//        mutSet.addCharacters(in: "#")
//        let encodingURL = urlStr.addingPercentEncoding(withAllowedCharacters: mutSet as CharacterSet)
//        if mutSet as CharacterSet == CharacterSet.urlQueryAllowed {
//            print("yes")
//        }
        
//        let charSet = NSMutableCharacterSet()
//        charSet.formUnion(with: CharacterSet.urlQueryAllowed)
//        charSet.addCharacters(in: "#")
        
        var charSet = CharacterSet.urlQueryAllowed
        charSet.insert(charactersIn: "#")
        let encodingURL = urlStr.addingPercentEncoding(withAllowedCharacters: charSet as CharacterSet)
        print(encodingURL ?? "")
        
        
        /*
        // 是否安装QQ
        let url = URL.init(string: "mqq://")
        
        if UIApplication.shared.canOpenURL(url!) {
            
            let qq = "1099779883"
            
            let urlstr = "mqq://im/chat?chat_type=wpa&ype=wpa&uin="+qq+"&version=1&src_type=web"
            let qqUrl = URL.init(string: urlstr)
            
            if UIApplication.shared.canOpenURL(qqUrl!) {
              
                UIApplication.shared.open(qqUrl!, options: ["":""], completionHandler: nil)
            }
            
            
        }
        */
    }
    
}

