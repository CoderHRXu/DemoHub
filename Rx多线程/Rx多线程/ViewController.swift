//
//  ViewController.swift
//  Rx多线程
//
//  Created by haoran on 2018/4/11.
//  Copyright © 2018年 Xuhaoran. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var searchViewModel: SearchViewModel!
    let disposeBag = DisposeBag()
    
    var rx_searchBarText: Observable<String>{
        return searchBar
            .rx
            .text
            .orEmpty
            .filter { $0.count > 0 }
            .throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }


    func setupUI(){
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        searchViewModel = SearchViewModel.init(searchText: rx_searchBarText)
        
        searchViewModel.rx_repositories.drive(tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)){ (row, repository, cell) in
            cell.textLabel?.text = repository.name
        }.disposed(by: disposeBag)
        
        searchViewModel.rx_repositories.drive(onNext: { (repositories) in
            if repositories.count == 0 {
                
                let alertVC = UIAlertController(title: "Sorry", message: "No repositories for this user", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if self.navigationController?.visibleViewController?.isMember(of: UIAlertController.self) != true {
                    self.present(alertVC, animated: true, completion: nil)
                
                }
                
            }
        }).disposed(by: disposeBag)
        
    }

}

