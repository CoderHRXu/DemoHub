//
//  ActionViewController.swift
//  TableView_RxSwift
//
//  Created by haoran on 2018/4/12.
//  Copyright © 2018年 Xuhaoran. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Action


class ActionViewController: UIViewController {

    
    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var pwdTF: UITextField!
    
    @IBOutlet weak var tapBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepOne()
        login()
        tableViewCellBtnTap()
    }

    func stepOne()  {
        
//        Action是observable的一个抽象库，它定义了一个动作，传入输入的事件，然后对事件进行处理，返回处理结果。它有如下特点:
//
//        只有enabled的时候才会执行，可以传入enabledIf参数
//        同时只能执行一个，下次input必须等上次的action执行完
//        可以分别处理错误和next
        
        // 一个简单的例子，没有输入也没有输出如下:
        let buttonAction: Action<Void, Void> = Action{
            
            print("button action")
            return Observable.empty()
        }
        
        
        
        tapBtn.rx.action = buttonAction
        
    }
    
    func login() {
        
        // 或者传入用户名密码，返回登录结果:
        let loginAction: Action<(String, String), Bool> = Action { (username, password) in
            
            print("\(username) \(password)")
            return Observable.just(true)
        }
        
        let userNameAndPassword = Observable.combineLatest(usernameTF.rx.text.orEmpty, pwdTF.rx.text.orEmpty)
        
        loginBtn.rx.tap
            .asObservable()
            .withLatestFrom(userNameAndPassword)
            .bind(to: loginAction.inputs)
            .disposed(by: disposeBag)
        
//        loginAction.elements.filter { $0 }.subscribe(onNext: { (loginOK) in
//            print(loginOK)
//        }).disposed(by: disposeBag)
        loginAction.elements.filter{$0}.subscribe(
            onNext:{
                _ in
                print("login OK")
        }
        ).disposed(by: disposeBag)
        
        loginAction.errors.subscribe(
            onError:{
                error in
                print("error")
            }
        )
            .disposed(by: disposeBag)
    }

    func tableViewCellBtnTap() {

        tableView.register(UINib.init(nibName: "DemoCell", bundle: nil), forCellReuseIdentifier: "DemoCell")

        let items = Observable.just(
            (0...20).map({ "\($0)"})
        )
        
        items.bind(to: tableView.rx.items(cellIdentifier: "DemoCell", cellType: UITableViewCell.self)){ (row, element, cell) in
            let title = cell.viewWithTag(100) as! UILabel
            title.text = element    
            
            var button = cell.viewWithTag(101) as! UIButton
            button.rx.action = CocoaAction{
                
                print("cell btn tap - to do sth \(element)")
                return .empty()
            }
            
            
        }.disposed(by: disposeBag)
        
        
    }
}
