//
//  HomeViewController.swift
//  HRSwiftDemo
//
//  Created by haoran on 2018/10/19.
//  Copyright © 2018年 haoran. All rights reserved.
//

import UIKit
import Moya
import Result
import Alamofire

class HomeViewController: HRBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        moyaBaseUse()
        moyaAdvancedUse()
    }

    
    /// Moya最基本用法
    func moyaBaseUse() {
        
        let provider = MoyaProvider<HRHomeApiService>()
        
        provider.request(.getPrdList) { (result) in
            
            switch result{
                
            case let .success(response):
                
                // 回调解析
                guard let json = try? response.mapString() else {
                    print("json解析出错")
                    break
                }
                print("请求成功:\n\(json)")
                break
                
            case let .failure(error):
                print("请求失败\(error)")
                break
            }
            
        }
        
    
    }
    
    
    
    /// Moya高级用法
    func moyaAdvancedUse() {
    
        // 2.Moya高级用法
        // 扩展请求头之类的参数
        let myEndPointClosure = { (target: HRHomeApiService) -> Endpoint in
            
            // 拦截URL，可自定义转码之类
            let url = target.baseURL.appendingPathComponent(target.path).absoluteString
            
            
            let endPoint = Endpoint.init(url: url, sampleResponseClosure: { () -> EndpointSampleResponse in
                .networkResponse(200, target.sampleData)
            }, method: target.method, task: target.task, httpHeaderFields: target.headers)
            return endPoint
            
        }
        
        
        // 请求超时时间设置
        let requestClosure = { (endpoint : Endpoint , done : @escaping MoyaProvider<HRHomeApiService>.RequestResultClosure)  in
            
            guard var request = try? endpoint.urlRequest() else {
                return
            }
            request.timeoutInterval = 30
            done(.success(request))
            
        }
        
        let subClosure = { (target : HRHomeApiService) -> StubBehavior in
            return MoyaProvider<HRHomeApiService>.neverStub(target)
        }
        
        // 回调队列
        let queue = DispatchQueue.main
        
        // https设置  关闭这个ip的https验证 或者配置证书
        let trustPlocicy = ServerTrustPolicyManager.init(policies: ["192.169.1.200":.disableEvaluation])
        
        let manager = Manager.init(configuration: URLSessionConfiguration.default, serverTrustPolicyManager: trustPlocicy)

        
        // 插件 转菊花 HUD等等
        let plugins = [HRNetworkPlugin()]
        let provider = MoyaProvider.init(endpointClosure: myEndPointClosure, requestClosure: requestClosure, stubClosure: subClosure, callbackQueue: queue, manager: manager, plugins: plugins, trackInflights: true)
        
        provider.request(.getPrdList) { (result) in
            switch result{
            case let .success(response):
                // json 解析
                guard let jsonStr = try? response.mapString() else {
                    print("json解析出错")
                    break
                }
                print("请求成功：\n \(jsonStr)")
                break
                
            case let .failure(error):
                print(error)
                break
            }
        }
        
    }
    
    
    
    
    
    
}
