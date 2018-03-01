//
//  FCNetworkPlugin.swift
//  Moya11Learn
//
//  Created by haoran on 2018/2/13.
//  Copyright © 2018年 Fclassroom. All rights reserved.
//

import Foundation
import Moya
import Result

public class FCNetworkPlugin : PluginType {
    
    // Plugin提供了一种插件的机制让你可以在网络请求的关键节点插入代码，比如显示小菊花等等。
    /// Called immediately before a request is sent over the network (or stubbed).
    public func willSend(_ request: RequestType, target: TargetType){
        
        guard let request = request.request else {
            return
        }
        
        // 转菊花
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        
        // 打开loading
        // TODO: loading 动画
        
        // 打印log
        FCLogger.info("API: \(target)")
        FCLogger.info("\(request.httpMethod ?? ""): \(request.url?.absoluteString ?? "")")
        FCLogger.info("header: \(request.allHTTPHeaderFields?.description ?? "")")
        let str = String.init(data: request.httpBody ?? Data(), encoding:.utf8)
        FCLogger.info("param: \(str ?? "")")
        
    }
    
    /// Called after a response has been received, but before the MoyaProvider has invoked its completion handler.
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        FCLogger.info("API Return: \(target)")
        
        switch result {
            
        case let .success(res):
            
            let jsStr: String = try! res.mapString()
            
            FCLogger.info(jsStr)
            
        case let .failure(err):
            
            FCLogger.error(err)
            
        }
    }
    
}
