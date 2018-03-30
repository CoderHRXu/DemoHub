//
//  LoginViewModel.swift
//  观察者&订阅者
//
//  Created by haoran on 2018/3/22.
//  Copyright © 2018年 Xuhaoran. All rights reserved.
//

import RxSwift
import RxCocoa


class LoginViewModel: NSObject {

    let validateUserName: Observable<ValidationResult>
    let validatePassword: Observable<ValidationResult>
    let validatedPasswordRepeated: Observable<ValidationResult>
    
    let registerEnabled: Observable<Bool>
    let registered: Observable<Bool>

    let registerTap = PublishSubject<Void>()
    
 
    
    init(input:(
        username: Observable<String>,
        password: Observable<String>,
        repeatedPassword: Observable<String>,
        regidterTap: Observable<Void>
        )) {
        
        let API = GitHubAPI.sharedAPI
        let minPasswordCount = 5

        /*
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
        */

        
        // 那么用户名验证可以改为：
        // flatMapLatest 如果有新的值发射出来，则会取消原来发出的网络请求
        // flatMap 则不会

        validateUserName = input.username.flatMapLatest({ (username) -> Observable<ValidationResult> in
            
            if username.isEmpty {
                return Observable.just(.empty)
            }
            let loadingValue = ValidationResult.validating
            return API.usernameAvailable(username: username).map({ (available) in
                
                if available {
                    return .ok(message: "Username available")
                }else {
                    return .failed(message: "Username already taken")
                }
                
            }).startWith(loadingValue)  // 开始发射时一个正在验证的值
            .observeOn(MainScheduler.instance) // 将监听事件绑定到主线程
            .catchErrorJustReturn(.failed(message: "Error contacting server"))
            
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
        
        let usernameAndPassword = Observable.combineLatest(input.username, input.password) { ($0, $1)
        }
        
        
        registered = self.registerTap.asObservable().withLatestFrom(usernameAndPassword)
            .flatMapLatest({ (username, password) in
                return API.register(username: username, password: password)
                    .observeOn(MainScheduler.instance)
                    .catchErrorJustReturn(false)
            }).share(replay: 1, scope: .forever)
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


