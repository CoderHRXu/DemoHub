//
//  CitySearchViewController.swift
//  TableView_RxSwift
//
//  Created by haoran on 2018/4/10.
//  Copyright © 2018年 Xuhaoran. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CitySearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let disposeBag = DisposeBag()
    
    let allCities = [
                    "苏州",
                    "上海",
                    "南京",
                    "无锡",
                    "南通",
                    "常州",
                    "镇江",
                    "泰州",
                    "扬州",
                    "徐州",
                    "宿迁",
                    "ChangSha",
                    "HangZhou",
                    "ShangHai",
                    "BeiJing",
                    "ShenZhen",
                    "New York",
                    "London",
                     ]
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>.init(configureCell: {(_, tableview, indexPath, element)  in
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = "\(element)"
        return cell
    })
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // 获取用户的搜索输入，并简单判断前缀来返回结果:
        let searchResult = searchBar.rx
            .text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter{!$0.isEmpty}
            .flatMapLatest {[unowned self] (queryStr) -> Observable<[String]> in
                if queryStr.isEmpty {
                    return Observable.just([])
                }else{
                    let results = self.allCities.filter({ (city) -> Bool in
                        return city.contains(queryStr)
                    })
                    return Observable.just(results)
                }
        }
            .share(replay: 1, scope: .forever)
        
        
        searchResult.map {
            [SectionModel(model: "", items: $0)]
        }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
    }

    

}
