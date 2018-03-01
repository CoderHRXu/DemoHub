//
//  TargetType+Base.swift
//  Moya11Learn
//
//  Created by haoran on 2018/2/13.
//  Copyright © 2018年 Fclassroom. All rights reserved.
//

import Foundation
import Moya

extension TargetType{
    

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
    

//
    /// The headers to be used in the request.
    var headers: [String: String]? {
        return [
                "Authorization" : "Bearer ee1a32d9adc24f4ceb449a30ceb33f38",
                "Client-Value"  : "13"
                ]
    }
    
    /// 加入公共参数
    /// 带参数的网络请求都需要调用
    /// - Parameter para: 参数
    /// - Returns: 参数
    func mergePublicParameter( para : [String :Any]?) -> [String : Any] {
        
        var pubPara                    = [String : Any]()
        pubPara["jike-client-from"]    = "APP"
        pubPara["jike-platform"]       = 10
        pubPara["accessToken"]         = "ee1a32d9adc24f4ceb449a30ceb33f38"
        
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

