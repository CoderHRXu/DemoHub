//
//  ViewController.swift
//  SwiftCommon
//
//  Created by haoran on 2019/10/13.
//  Copyright © 2019 haoran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        test()
    }
    
    func test() {
        
        var str = "没变化"
        #if PRO
        str = "pro"
        #elseif DEV
        str = "dev"
        #elseif SIT
        str = "sit"
        #elseif UAT
        str = "uat"
        #endif
        
        print(str)
    }
}

