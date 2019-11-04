
//
//  FCBaseProvider.swift
//  SwiftDemo
//
//  Created by haoran on 2018/1/31.
//  Copyright © 2018年 xuhaoran. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
import Alamofire

public class FCBaseProvider<T> : MoyaProvider<T>  where T : TargetType {

    
    public override init(
        endpointClosure: @escaping MoyaProvider<T>.EndpointClosure = { (target : T) -> Endpoint in
        
        let url                 = target.baseURL.appendingPathComponent(target.path).absoluteString
        let endpoint            = Endpoint.init(url: url, sampleResponseClosure:{.networkResponse(200, target.sampleData) }, method: target.method, task: target.task, httpHeaderFields: target.headers)
        return endpoint
        },
        requestClosure: @escaping MoyaProvider<T>.RequestClosure = { (endpoint : Endpoint , done : @escaping MoyaProvider<T>.RequestResultClosure)  in
        guard var request = try? endpoint.urlRequest() else {
            return
        }
        request.timeoutInterval = 30
        done(.success(request))
        
        },
        stubClosure: @escaping MoyaProvider<T>.StubClosure = { (Target : T) -> Moya.StubBehavior in
        return MoyaProvider<T>.neverStub(Target)
        },
        callbackQueue: DispatchQueue? = nil,
        manager: Manager        = Manager.init(configuration: URLSessionConfiguration.default, serverTrustPolicyManager: ServerTrustPolicyManager.init(policies: ["192.169.1.200":.disableEvaluation])),
        plugins: [PluginType],
        trackInflights: Bool = false) {
        
        super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, callbackQueue: nil, manager: manager, plugins: plugins, trackInflights: trackInflights)
    }
    
}
