//
//  MyFormViewController.swift
//  HRSwiftDemo
//
//  Created by haoran on 2018/10/25.
//  Copyright © 2018年 haoran. All rights reserved.
//

import UIKit
import Eureka


class MyFormViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Eureka学习"
        setupForm()
        
    }
    
    func setupForm() {
        
        let multiRow: MultipleSelectorRow = MultipleSelectorRow<String>.init(tag: "mytag")
        
        multiRow.cellUpdate{ cell, row in
            cell.textLabel?.textColor = .red
//            cell.textLabel?.font = UIFont(name: "your_font", size: 17.0)
        }
        
        //  TO CHANGE COLOR OF OPTIONS
        _ = multiRow.onPresent { from, to in
            to.selectableRowCellUpdate = { cell, row in
                cell.textLabel!.textColor = .red
            }
        }
        

        
        form +++ Section("section1")
            <<< TextRow(){ row in
                row.title = "text row"
                row.placeholder = "enter text here"
        }
            <<< PhoneRow(){
                $0.title = "phone row"
                $0.placeholder = "add numbers here"
        }
        +++ Section("section2")
            <<< DateRow(){
                $0.title = "Data row"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
        }
            <<< NameRow(){ nameRow in
                nameRow.tag = "name"
                nameRow.title = "账户名字"
                nameRow.placeholder = "请输入名字"
                
                
        }
            <<< multiRow
//        +++ Section("section3")
//            <<< CustomRow(){ row in
//
//
//        }

    }
    
}
