//
//  TargetType+Base.swift
//  HRSwiftDemo
//
//  Created by haoran on 2018/10/19.
//  Copyright © 2018年 haoran. All rights reserved.
//

import Foundation
import Moya

extension TargetType {
    
    /// The target's base `URL`.
    var baseURL: URL {
        return URL.init(string: "http://10.0.3.50:3000")!
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
//    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: Moya.Method { return .post }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        return .requestPlain
    }
    
    /// The type of validation to perform on the request. Default is `.none`.
    var validationType: ValidationType {
        return .none
    }
    
    /// The headers to be used in the request.
    var headers: [String: String]? {
        let header = ["Client-Value": "13"]
        return header
    }
}
