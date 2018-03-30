//
//  SectionViewController.swift
//  TableView_RxSwift
//
//  Created by haoran on 2018/3/29.
//  Copyright © 2018年 Xuhaoran. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class SectionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    let items = Observable.just([
        SectionModel(model: "FirstSection", items: [
            1.0,
            2.0,
            3.0
            ]),
        SectionModel(model: "SecondSection", items: [
            1.0,
            2.0,
            3.0
            ]),
        SectionModel(model: "ThirdSection", items: [
            1.0,
            2.0,
            3.0
            ]),
        ])
    
    var dataSource:RxTableViewSectionedReloadDataSource<SectionModel<String, Double>>?

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // 配置cell
        dataSource = RxTableViewSectionedReloadDataSource.init(configureCell: { (_, tableView, indexPath, element) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            cell?.textLabel?.text = "\(element) @row \(indexPath.row)"
            return cell!
        })
        
        // 设置section的titile
        dataSource?.titleForHeaderInSection = { (dataSource, sectionIndex ) in
            return dataSource[sectionIndex].model
        }
        
        // 把数据绑定到dataSource:
        items.bind(to: tableView.rx.items(dataSource: dataSource!)).disposed(by: disposeBag)
        
        // 点击事件：
        tableView.rx.itemSelected.map {indexPath in
            return (indexPath, self.dataSource![indexPath])
            }.subscribe(onNext: { (indexPath, item) in
                print("Tap \(item) @ \(indexPath)")
            }).disposed(by: disposeBag)
        
        // 虽然RxDataSource内部有一个代理对象，但是我们仍然可以设置delegate。
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }

}


extension SectionViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
