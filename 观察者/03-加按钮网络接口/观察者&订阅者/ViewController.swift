//
//  ViewController.swift
//  观察者&订阅者
//
//  Created by haoran on 2018/3/22.
//  Copyright © 2018年 Xuhaoran. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tf1: UITextField!
    
    @IBOutlet weak var tf2: UITextField!
    
    @IBOutlet weak var tf3: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!

    @IBOutlet weak var label1: UILabel!

    @IBOutlet weak var label2: UILabel!

    @IBOutlet weak var label3: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel: LoginViewModel = LoginViewModel(input: ( username: tf1.rx.text.orEmpty.asObservable(), password: tf2.rx.text.orEmpty.asObservable(), repeatedPassword: tf3.rx.text.orEmpty.asObservable(), regidterTap: loginBtn.rx.tap.asObservable())
        )
//        然后绑定:
        viewModel.validateUserName.bind(to: label1.rx.validationResult).disposed(by: disposeBag)
        viewModel.validatePassword.bind(to: label2.rx.validationResult).disposed(by: disposeBag)
        viewModel.validatedPasswordRepeated.bind(to: label3.rx.validationResult).disposed(by: disposeBag)

        //不用每次改变都发射给订阅者，只有当发生改变时再发射，使用distinctUntilChanged
//        捕获self的弱引用，然后再里面转成强引用
        viewModel.registerEnabled.subscribe(onNext: {[weak self] (valid) in
            guard let `self` = self else{
                return
            }
            self.loginBtn.isEnabled = valid            
        }).disposed(by: disposeBag)
        
        
        // 订阅事件，操作输入长度
        tf1.rx.controlEvent(.editingChanged).subscribe(onNext: { _ in
            
            guard var text = self.tf1.text else{
                return
            }
            if  text.count > 11 {
                text = (text as NSString).substring(to: 11)
                self.tf1.text = text
            }
            
        }).disposed(by: disposeBag)

        // 优化项：
        // 点击背景收起键盘
        // 点击键盘的Next调到下一个UITextField
        // 点击Go触发注册流程

        // 收起键盘
        let tapBackground = UITapGestureRecognizer()
        tapBackground.rx.event.subscribe(onNext: {[unowned self] (tap) in
            self.view.endEditing(true)
        }).disposed(by: disposeBag)
        
        
        tf1.rx.controlEvent(.editingDidEnd)
            .subscribe(onNext: {[unowned self] in
                self.tf2.becomeFirstResponder()
            }).disposed(by: disposeBag)
        
        tf2.rx.controlEvent(.editingDidEnd)
            .subscribe(onNext: { [unowned self] in
                self.tf3.becomeFirstResponder()
            }).disposed(by: disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        test5()
        
    }

    func demo() {
        
//        tf1.rx.text.orEmpty.asObservable()
//            .filter({
//             return $0 != ""
//        }).subscribe {
//            print($0)
//        }.disposed(by: disposeBag)
        
        //        Observable.combineLatest(numberOne.rx.text.orEmpty,numberTwo.rx.text.orEmpty,numberThree.rx.text.orEmpty) { (numberOneText, numberTwoText, numberThreeText) -> Int in
//            return (Int(numberOneText) ?? 0) + (Int(numberTwoText) ?? 0) + (Int(numberThreeText) ?? 0)
//            }.map{
//                $0.description
//            }.bindTo(result.rx.text)
//            .disposed(by: disposeBag)
        
        
        Observable.combineLatest(tf1.rx.text.orEmpty, tf2.rx.text.orEmpty){ (tf1Text, tf2Text) -> Int in
                let result = (Int(tf1Text) ?? 0) + (Int(tf2Text) ?? 0)
                return result
            }.map{
                $0.description
            }.bind(to: tf3.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    
    func test(){
        
        /*
         create
         常见的两种方式来创建一个Observable对象，一种是通过引入RxCocoa(RxCocoa是对cocoa进行的Rx扩展)，它已经包含了我们常用到的Observable流，比如button的tap事件。一般做iOS开发的要使用到RxSwift都要用到RxCocoa的，这两个是相辅相成的。
         
         */
        
//        也可以使用提供的create函数来创建一个Observable对象。
        
        
        let loginBtn = UIButton.init()
//        var observable = loginBtn.rx.tap.asObservable()
        
        
        let observable = Observable<String>.create({ (observerOfString) -> Disposable in
            
            observerOfString.onNext("😝")
            observerOfString.onCompleted()
            return Disposables.create()
        })
        
        observable.subscribe { (str) in
            print(str)
        }.disposed(by: disposeBag)
        
        
    }
    
    
    func test2() {
        
        //        创建一个序列，不会终止也不会发出任何事件。
        let neverSequence = Observable<String>.never()
        
        let neverSequenceSubscription = neverSequence.subscribe { _ in
            
            print("will not print")
        }
        
        neverSequenceSubscription.disposed(by: disposeBag)
        
    }
    
    func test3() {
        
//        just
//        创建一个单个元素的序列
       
        Observable.just("🍎").subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
        
        
        
    }
    
    
    func test4()  {
//        of
//        使用固定数量的元素创建一个序列。
        Observable.of("🐶","🐱","🐷").subscribe(onNext: { (element) in
            print(element)
        }).disposed(by: disposeBag)

    }
    
    
    func test5() {
//        from
//        从一个序列创建一个可被观察的序列。
//        Observable.from(["🐶","🐱","🐷"]).subscribe(onNext: {
//            print($0)
//        }).disposed(by: disposeBag)
        
//        range
//        创建一个发出一系列顺序整数然后终止的序列。
        
//        Observable.range(start: 1, count: 10).subscribe {
//            print($0)
//        }
        
//        repeatElement
//        创建一个给予元素的无限序列。
        Observable.repeatElement("🍉")
            .take(3) // 这里的take(3)表示只取前3个元素。
            .subscribe {
                print($0)}
            .disposed(by: disposeBag)
        
        
        
        
//        generate
//        创建一个满足条件的序列。
        Observable.generate(initialState: 0, condition: { $0 < 3}, iterate: { $0 + 1 }).subscribe {
            print($0)
        }.disposed(by: disposeBag)
    }
}

