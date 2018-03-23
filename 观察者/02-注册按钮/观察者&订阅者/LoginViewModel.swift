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


class LoginViewModel: NSObject {

    let validateUserName: Observable<ValidationResult>
    let validatePassword: Observable<ValidationResult>
    let validatedPasswordRepeated: Observable<ValidationResult>
    let registerEnabled: Observable<Bool>
    let registerTap = PublishSubject<Void>()
    
    
    
    init(input:(
        username: Observable<String>,
        password: Observable<String>,
        repeatedPassword: Observable<String>,
        regidterTap: Observable<Void>
        )) {
        
        let API = GitHubAPI.sharedAPI
        let minPasswordCount = 5

        
        validateUserName = input.username.map({ (username) -> ValidationResult in
            
            if (username == ""){
                return .empty
            }
            if username.count > 11 {

                return .failed(message:"手机号不能超过11位")
            }
            if username .isValidPhoneNumber(){
                return .ok(message:"用户名验证通过")
            }else {
                return .failed(message:"用户名需要为手机号")
            }
            
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
        
        
        registerEnabled = Observable.combineLatest(validateUserName, validatePassword, validatedPasswordRepeated){ (username, password, repeatPassword) -> Bool in
            return username.isValid && password.isValid && repeatPassword.isValid
        }
            .distinctUntilChanged()
            .share(replay: 1, scope: .forever)
        
        
        
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
    
    var validationResult: Binder<ValidationResult>{
        return Binder(base, binding: { (label, result) in
            label.text = result.description
            label.textColor = result.textColor

        })
        
    }
    
    
}


