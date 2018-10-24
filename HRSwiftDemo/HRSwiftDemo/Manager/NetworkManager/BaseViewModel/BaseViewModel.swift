//
//  BaseViewModel.swift
//  HRSwiftDemo
//
//  Created by haoran on 2018/10/23.
//  Copyright © 2018年 haoran. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import HandyJSON
import Alamofire


class BaseViewModel {
    
    let disposeBag = DisposeBag()
    
    func sendRequest<T:TargetType>(target: T, withHUD : Bool = false) -> Observable<Response> {
        
        // 确定插件
         var plugins: [PluginType] = [HRNetworkPlugin()]
        if withHUD {
            plugins.append(HUDPlugin())
        }
        
        return Observable.create({ (observer) -> Disposable in
            
            let cancellableToken = HRBaseProvider<T>(plugins: plugins).request(target, completion: { (result) in
                switch result {
                case let .success(response):
                    observer.onNext(response)
                    observer.onCompleted()
                case let .failure(error):
                    observer.onError(error)
                }
            })
            
            return Disposables.create {
                cancellableToken.cancel()
            }
        }).parseError()
    }
    
}
