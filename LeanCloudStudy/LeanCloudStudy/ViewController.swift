//
//  ViewController.swift
//  LeanCloudStudy
//
//  Created by haoran on 2018/4/4.
//  Copyright © 2018年 Xuhaoran. All rights reserved.
//

import UIKit
import LeanCloud

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func btnClick(_ sender: UIButton) {
        
        let post = LCObject.init(className: "TestObject")
        post.set("words", value: "hello world")
        let result = post.save()
        print(result)
    }



}

