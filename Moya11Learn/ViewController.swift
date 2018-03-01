//
//  ViewController.swift
//  Moya11Learn
//
//  Created by haoran on 2018/2/13.
//  Copyright © 2018年 Fclassroom. All rights reserved.
//

import UIKit
import Moya
import Alamofire
//import Result

class ViewController: UIViewController {

    let viewModel = FCMeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnClick(_ sender: Any) {
        
//        moyaAdvanceUsage()
//        viewModel.updateNickName(nickName: "大帅哥").then { (dict)  in
//            print(dict)
//            }.catch { (error) in
//                print(error)
//            }.always {
//                print("不管成功失败都执行")
//        }
        
        viewModel.requestTaskReadExamCount().then { (model) in
            print(model)
            }.catch { (error) in
                print(error)
            }.always {
                print("xxxx")
        }
    }
    
    
    func moyaBaseUsage() {
        
        let provider = MoyaProvider<FCMeApiService>.init()
        provider.request(.taskReadExamCount) { (reuslt) in
            
            switch reuslt {
                
            case let .success(response):
                guard let jsonStr = try? response.mapString() else{
                    print("json解析出错")
                    return
                }
                print("请求成功-----\(jsonStr)")
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    func moyaAdvanceUsage() {
        
        // 2.Moya高级用法
        // 扩展请求头之类的参数
        let myEndPointClosure = { (target : FCMeApiService) -> Endpoint in
            
            let url = target.baseURL.appendingPathComponent(target.path).absoluteString
            
            let endpoint = Endpoint.init(url: url, sampleResponseClosure:{.networkResponse(200, target.sampleData) }, method: target.method, task: target.task, httpHeaderFields: target.headers)
            
            
            return endpoint
        }
        
        // MARK: - 设置请求超时时间
        let requestClosure = { (endpoint : Endpoint , done : @escaping MoyaProvider<FCMeApiService>.RequestResultClosure)  in
            
            guard var request = try? endpoint.urlRequest() else {
                return
            }
            request.timeoutInterval = 30
            done(.success(request))
            
        }
        
        let stubClosure = { (Target : FCMeApiService) -> Moya.StubBehavior in
            return MoyaProvider<FCMeApiService>.neverStub(Target)
        }
        
        // 关闭这个ip的https验证
        let trustPlocicy = ServerTrustPolicyManager.init(policies: ["192.169.1.200":.disableEvaluation])
        
        let manager = Manager.init(configuration: URLSessionConfiguration.default, serverTrustPolicyManager: trustPlocicy)

        let provider = MoyaProvider<FCMeApiService>(endpointClosure: myEndPointClosure, requestClosure: requestClosure, stubClosure: stubClosure, callbackQueue: DispatchQueue.main, manager: manager , plugins: [FCNetworkPlugin()], trackInflights: true)
        
        
        provider.request(.taskReadExamCount) { result in
            
            switch result {
                
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

