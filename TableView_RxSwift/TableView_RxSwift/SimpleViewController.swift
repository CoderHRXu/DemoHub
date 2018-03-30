//
//  SimpleViewController.swift
//  TableView_RxSwift
//
//  Created by haoran on 2018/3/29.
//  Copyright © 2018年 Xuhaoran. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class SimpleViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupUI() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        let items = Observable.just(
            (0...20).map{"\($0)"}
        )
        
        // 使用数据初始化cell
        items.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)){ (row, element, cell) in
            
            cell.textLabel?.text = "\(element) @row \(row)"
        }.disposed(by: disposeBag)
        
        // cell 点击事件
        tableView.rx.modelSelected(String.self).subscribe { (value) in
            print("click \(value)")
        }.disposed(by: disposeBag)
        
        // 虽然RxDataSource内部有一个代理对象，但是我们仍然可以设置delegate。
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
    }

}

extension SimpleViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

