//
//  TargetType+Base.swift
//  SwiftDemo
//
//  Created by haoran on 2018/1/27.
//  Copyright © 2018年 xuhaoran. All rights reserved.
//

import Foundation
import Moya

extension TargetType {
    
    /// The target's base `URL`.
//    var baseURL: URL { get }
    
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        return .post
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        return .requestPlain
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
    
    var headers: [String : String]? {
        
        var header = ["Client-Value": "13"]
//        if let accesstoken = CacheHandler.shared.currentUser?.accessToken {
//            if !accesstoken.isEmpty{
//                header["Authorization"] = "Bearer "+accesstoken
//            }
//        }
        return header
    }

    
    /// 加入公共参数
    /// 带参数的网络请求都需要调用
    /// - Parameter para: 参数
    /// - Returns: 参数
    func mergePublicParameter( para : [String :Any]?) -> [String : Any] {
        
        var pubPara                    = [String : Any]()
        pubPara["jike-client-from"]    = "APP"
        pubPara["jike-platform"]       = 10
        pubPara["accessToken"]         = "8a9c138f45dbf69d555d58123ab74803"
        
        if let para = para{
            pubPara.merge(para) { (_, new) -> Any in
                new
            }
            return pubPara
        }else{
            return pubPara
        }
        
        
        
    }
    
}
