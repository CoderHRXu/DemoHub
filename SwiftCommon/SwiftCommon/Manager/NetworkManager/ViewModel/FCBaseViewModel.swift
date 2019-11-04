//
//  FCBaseViewModel.swift
//  SwiftDemo
//
//  Created by haoran on 2018/1/29.
//  Copyright © 2018年 xuhaoran. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import HandyJSON
import Alamofire


class FCBaseViewModel {

    let disposeBag = DisposeBag()
    
    
    /// 发送请求方法
    ///
    /// - Parameters:
    ///   - target: 接口
    ///   - hasHUD: 是否包含loading动画
    /// - Returns: 接口返回
    func sendRequest<T:TargetType>(target : T , withHUD hasHUD: Bool = false ) -> Observable<Response> {
        
        let myEndPointClosure = { (target : T) -> Endpoint in
            
            let url = target.baseURL.appendingPathComponent(target.path).absoluteString
            
            let endpoint = Endpoint.init(url: url, sampleResponseClosure:{.networkResponse(200, target.sampleData) }, method: target.method, task: target.task, httpHeaderFields: target.headers)
            
            return endpoint
        }
        
        let plugins: [PluginType] = [FCNetworkPlugin()]
        if hasHUD {
            //            plugins.append(HUDPlugin())
        }
        
        // MARK: - 设置请求超时时间
        let requestClosure = { (endpoint : Endpoint , done : @escaping MoyaProvider<T>.RequestResultClosure)  in
            
            guard var request = try? endpoint.urlRequest() else {
                return
            }
            request.timeoutInterval = 30
            done(.success(request))
            
        }
        
        let stubClosure = { (Target : T) -> Moya.StubBehavior in
            return MoyaProvider<T>.neverStub(Target)
        }
        
        let trustPlocicy = ServerTrustPolicyManager.init(policies: ["192.169.1.200":.disableEvaluation])
        
        let manager = Manager.init(configuration: URLSessionConfiguration.default, serverTrustPolicyManager: trustPlocicy)
        
        let provider = MoyaProvider(endpointClosure: myEndPointClosure, requestClosure: requestClosure, stubClosure: stubClosure, manager: manager , plugins: plugins, trackInflights: true)
        
        return Observable<Response>.create { (observer) -> Disposable in
            
            let cancellableToken = provider.request(target, completion: { (result) in
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
        }.parseError()
        
    }
    
    
    
}
