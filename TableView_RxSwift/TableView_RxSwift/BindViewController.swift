//
//  BindViewController.swift
//  TableView_RxSwift
//
//  Created by haoran on 2018/3/30.
//  Copyright © 2018年 Xuhaoran. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class BindViewController: UIViewController {

    // MARK: - IBUnit
    @IBOutlet weak var tf: UITextField!
    
    @IBOutlet weak var tv: UITextView!
    
    @IBOutlet weak var label: UILabel!
        
    let disposeBag = DisposeBag()
    
    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
      
    }

    func setupUI() {
//        比如我想要 textfield.text = "这是我修改的值" 这样去赋值也会发射事件。
//        这里我们可以用到双向绑定，把UITextField的修改和赋值绑定到一个Subject，同时还可以被订阅。
        
        // textField 双向绑定
        let text = Variable("双向绑定")
        _ = tf.rx.textInput + text
        
        tf.rx.text.asObservable().subscribe {
            print("textField: \($0)")
        }.disposed(by: disposeBag)
        
        tf.text = "这是我修改的值"
        
        // UILabel 双向绑定
        label.rx_text.asObservable().subscribe { text in
            print("xxxxx"+text.element! )
        }.disposed(by: disposeBag)
        
        label.text = "修改label"
        
        tv.rx.text.asObservable().subscribe{
                print("textview: \($0)")
        }.disposed(by: disposeBag)
        
        tv.text = "这是我修改的值"
    }
    
    
    
}

extension UILabel {
    
    public var rx_text: ControlProperty<String> {
        
        // 观察text
        let source: Observable<String> = self.rx.observe(String.self, "text").map { $0 ?? ""}
        let setter: (UILabel, String) -> Void = { $0.text = $1}
        let bindingObsever = Binder.init(self, binding: setter)
        return ControlProperty<String>.init(values: source, valueSink: bindingObsever)
        
    }
}


