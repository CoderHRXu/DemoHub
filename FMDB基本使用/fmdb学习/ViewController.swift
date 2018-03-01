//
//  ViewController.swift
//  fmdb学习
//
//  Created by haoran on 2018/1/16.
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

    @IBAction func btnClick(_ sender: UIButton) {
        
        let dbTool = FMDBTool.shareInstance
        switch sender.tag {
        case 1:
            dbTool.creatTable()
        case 2:
            dbTool.dropTable()
        case 3:
            dbTool.insertStu()
        case 4:
            dbTool.deleteStu()
        case 5:
            dbTool.updateStu()
        case 6:
            dbTool.queryAll()
        default:
            print("弄啥嘞")
        }
    }
    
    
    
}

