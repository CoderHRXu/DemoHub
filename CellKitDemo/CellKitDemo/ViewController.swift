//
//  ViewController.swift
//  CellKitDemo
//
//  Created by haoran on 2018/6/15.
//  Copyright © 2018年 haoran. All rights reserved.
//

import UIKit
import SwipeCellKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var count = 30;
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SwipeCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UINib.init(nibName: String(describing: SwipeCell.classForCoder()), bundle: nil), forCellReuseIdentifier: "cell")
    }

   
    
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SwipeCell
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 40))
        view.backgroundColor = UIColor.darkGray
        return view // I tried returning view.contentView, it didn't help
    }
    
    //  to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.beginUpdates()
            count -= 1
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}


extension ViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        // 指定右侧
        guard orientation == .right else {
            return nil
        }
        
        let action = SwipeAction.init(style: .default, title: "delete") { (action, index) in
            tableView.beginUpdates()
            print("点我删除 第\(indexPath.row)行")
            self.count -= 1
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
        
//        action.image
        return [action]
    }
    
    
}

