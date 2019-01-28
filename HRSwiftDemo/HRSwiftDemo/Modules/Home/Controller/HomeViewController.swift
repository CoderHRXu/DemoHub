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
import PromiseKit

class HomeViewController: HRBaseViewController {

    let homeVM = HomeViewModel()
    var carList = [CarListModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        moyaBaseUse()
//        moyaAdvancedUse()
//        requestCarlist()
//        let num = roundString(round: 3, numberString: "0.1555")
//        print(num)
        print(removeSuffix(numberString: "10.23"));
        print(removeSuffix(numberString: "10.20"));
        print(removeSuffix(numberString: "10.00"));

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
    
    
    func requestCarlist() {
        
//        homeVM.getCarList().done { (items) in
//
//            self.carList = items
//            print("========= \n \(items)")
//            }.catch { (err) in
//
//        }
        
        // 连环调用用then,最后一个请求用done
        homeVM.addCarBand(carBandName: "马自达").then { (items) -> Promise<[CarListModel]> in
            print("增加\(items)")
            return self.homeVM.getCarList()
            }.done({ (newItems) in
                print("列表\(newItems)")
            }).catch { (err) in
                print("错误\(err)")
        }
        
    }
    
    
    /// 四舍五入2位小数小数
    ///
    /// - round: 小数位（默认2位小数）
    /// - Parameter numberString: 格式化之前 eg 0.125
    /// - Returns: 格式化之后 eg: 0.13
    func roundNumberString(round:Int = 2, numberString : String) -> Double {
        if numberString.isEmpty || round == 0 {
            return 0.0
        }
        
        let roudingBehavior     = NSDecimalNumberHandler(roundingMode: .plain, scale: Int16(round), raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        let aDn                 = NSDecimalNumber(string: numberString)
        let resultDn            = aDn.rounding(accordingToBehavior: roudingBehavior)
        return resultDn.doubleValue
        
    }
    
    /// 过滤器 将.2f格式化的字符串，去除末尾0
    ///
    /// - Parameter numberString: .2f格式化后的字符串
    /// - Returns: 去除末尾0之后的
    func removeSuffix(numberString : String) -> String {
        
        if numberString.count > 1 {
            let strs = numberString.components(separatedBy: ".")
            let last = strs.last!
            if strs.count == 2 {
                if last == "00" {
                    
                    let indexEndOfText      = numberString.index(numberString.endIndex, offsetBy:-3)
                    return String(numberString[..<indexEndOfText])
                    
                }else{
                    
                    let indexStartOfText    = numberString.index(numberString.endIndex, offsetBy:-1)
                    let str                 = numberString[indexStartOfText...]
                    let indexEndOfText      = numberString.index(numberString.endIndex, offsetBy:-1)
                    if str == "0" {
                        return String(numberString[..<indexEndOfText])
                    }
                    
                }
                
            }
            
            return numberString
            
        }else{
            return ""
        }
    }
}
