//
//  GitHubAPI.swift
//  观察者&订阅者
//
//  Created by haoran on 2018/3/23.
//  Copyright © 2018年 Xuhaoran. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class GitHubAPI {

    let URLSession: URLSession
    
    static let sharedAPI = GitHubAPI(
        URLSession: Foundation.URLSession.shared
    )
    
    init(URLSession: URLSession) {
        self.URLSession = URLSession
    }
    
    
    /// 用户名是否可以
    ///
    /// - Parameter username: <#username description#>
    /// - Returns: <#return value description#>
    func usernameAvailable(username: String) -> Observable<Bool> {
        let url = URL.init(string: "https://github.com/\(username.URLEscaped)")!
        let request = URLRequest(url: url)
        return self.URLSession.rx.response(request: request).map({ (res, data) in
            
            return res.statusCode == 404
        })
        .catchErrorJustReturn(false)
        
    }
    
    
    /// 注册
    ///
    /// - Parameters:
    ///   - username: <#username description#>
    ///   - password: <#password description#>
    /// - Returns: <#return value description#>
    func register(username: String, password: String) -> Observable<Bool> {
        let registerReuslt = arc4random() % 5 == 0 ? false : true
        return Observable.just(registerReuslt)
        .delay(1.0, scheduler: MainScheduler.instance) // 延迟一秒
        
    }
}
