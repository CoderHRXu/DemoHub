//
//  TestViewController.swift
//  ExcelDemo
//
//  Created by haoran on 2018/6/13.
//  Copyright © 2018年 haoran. All rights reserved.
//

import UIKit

class TestViewController: UITableViewController {

    var count = 30
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // Do any additional setup after loading the view.
    }

    @objc func haha(){
        print("haha")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = "Test"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 40))
        view.backgroundColor = UIColor.darkGray
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(haha)))
        return view // I tried returning view.contentView, it didn't help
    }
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            count -= 1;
            tableView.deleteRows(at: [indexPath], with: .left)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}
