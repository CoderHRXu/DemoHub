//
//  LoginViewModel.swift
//  观察者&订阅者
//
//  Created by haoran on 2018/3/22.
//  Copyright © 2018年 Xuhaoran. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum ValidationResult {
    /// 验证成功信息
    case ok(message: String)
    /// 输入为空
    case empty
    /// 正在验证..
    case validating
    /// 验证失败原因
    case failed(message: String)
}

// 然后绑定错误到label，为了让ValidationResult能绑定到label，需要给出不同结果的文字颜色和文字信息，这时需要给ValidationResult扩展一下。
extension ValidationResult: CustomStringConvertible {
    var description: String {
        
        switch self {
        case let .ok(message):
            return message
        
        case .empty:
            return ""
            
        case .validating:
            return "validating"
            
        case let .failed(message):
            return message
        }
    }
    
}

struct ValidationColor {
    static let okColor = UIColor(red: 138.0 / 255.0, green: 221.0 / 255.0, blue: 109.0 / 255.0, alpha: 1.0)
    static let errorColor = UIColor.red
}


extension ValidationResult {
    var textColor: UIColor {
        switch self {
        case .ok:
            return ValidationColor.okColor
            
        case .empty:
            fallthrough
        case .validating:
            return UIColor.black
            
        case .failed:
            return ValidationColor.errorColor
        }
    }
    
}


class LoginViewModel: NSObject {

    let validateUserName: Observable<ValidationResult>
    let validatePassword: Observable<ValidationResult>
    let validatedPasswordRepeated: Observable<ValidationResult>
    
    init(input:(
        username: Observable<String>,
        password: Observable<String>,
        repeatedPassword: Observable<String>,
        regidterTap: Observable<Void>
        )) {
        
        validateUserName = input.username.map({ (username) -> ValidationResult in
            return username == "" ? .empty : .ok(message:"用户名验证通过")
        }).share(replay: 1, scope: .forever)
        
        validatePassword = input.password.map({ (password) -> ValidationResult  in
            return password == "" ? .empty : .ok(message:"密码验证通过")
        }).share(replay: 1, scope: .forever)
        
        validatedPasswordRepeated = Observable.combineLatest(input.password, input.repeatedPassword){(password, repeatedPassword) -> ValidationResult in
            
            if repeatedPassword == "" {
                return .empty
            }
            if password != repeatedPassword {
                return .failed(message:"两次输入密码不一致")
            }
            return .ok(message:"验证通过")

        }.share(replay: 1, scope: .forever)
    }
}

//同样为了使label能够根据对应的信息和颜色更新，需要提供:
extension Reactive where Base: UILabel {
    
    /* 以下已过期
    var validationResult: UIBindingObserver<Base, ValidationResult>{
        return UIBindingObserver(UIElement: base, binding: { (label, result) in
            label.text = result.description
            label.textColor = result.textColor
        })
    }
    */
    
    var result: Binder<ValidationResult>{
        return Binder(base, binding: { (label, result) in
            label.text = result.description
            label.textColor = result.textColor

        })
        
    }
    
    
}
