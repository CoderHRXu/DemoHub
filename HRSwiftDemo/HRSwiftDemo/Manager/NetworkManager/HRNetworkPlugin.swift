//
//  FCNetworkPlugin.swift
//  SwiftDemo
//
//  Created by haoran on 2018/1/28.
//  Copyright © 2018年 xuhaoran. All rights reserved.
//

import Foundation
import Moya
import Result

public class HRNetworkPlugin : PluginType {
    
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
        HRLogger.info("API: \(target)")
        HRLogger.info("\(request.httpMethod ?? ""): \(request.url?.absoluteString ?? "")")
        HRLogger.info("header: \(request.allHTTPHeaderFields?.description ?? "")")
        let str = String.init(data: request.httpBody ?? Data(), encoding:.utf8)
        HRLogger.info("param: \(str ?? "")")
        
    }
    
    /// Called after a response has been received, but before the MoyaProvider has invoked its completion handler.
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        HRLogger.info("API Return: \(target)")
        
        switch result {
            
        case let .success(res):
            
            let jsStr: String = try! res.mapString()
            
            HRLogger.info("API Return ✅✅: \n\(jsStr)")
            
        case let .failure(err):
            
            HRLogger.error("API Return ❌❌:\n \(err)")
            
        }
    }

    
}

public class HUDPlugin: PluginType {
    
    public func willSend(_ request: RequestType, target: TargetType) {
        
//        HUDView.showHud()
        
        guard let _ = request.request  else {
            return
        }
        
    }
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        
//        HUDView.hideHud()
    }
}
