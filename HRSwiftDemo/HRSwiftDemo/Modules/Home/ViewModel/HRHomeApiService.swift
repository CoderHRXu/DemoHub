//
//  HRHomeApiService.swift
//  HRSwiftDemo
//
//  Created by haoran on 2018/10/19.
//  Copyright © 2018年 haoran. All rights reserved.
//

import Foundation
import Moya

enum HRHomeApiService{
    
    /// 增加人
    case post(name: String)
    
    /// 推送接口
    case push(title: String, content: String)

    /// 车列表
    case getPrdList

    /// 增加h车
    case addPrd(carBandName: String)

}


extension HRHomeApiService : TargetType {
    
    var path: String {
        switch self {
            
        case .post:
             return "post"
        
        case .push:
            return "post"
            
        case .getPrdList:
            return "getPrdList"
            
        case .addPrd:
            return "addPrd"
        }
    }
    
    
    var task: Task{
        
        switch self {
            
        case .post(let name):
            return .requestParameters(parameters: ["name": name ], encoding: URLEncoding.default)

        case .push(let title, let content):
            return .requestParameters(parameters: ["title" : title, "content" : content], encoding: URLEncoding.default)
            
        case .getPrdList:
            return .requestPlain
            
        case .addPrd(let carBandName):
            return .requestParameters(parameters: ["name" : carBandName], encoding: URLEncoding.default)
        }
    }
    
    var method: Moya.Method {
        
        switch self {
            
        case .post:
            fallthrough
        case .push:
            return .post
        case .getPrdList:
            fallthrough
        case .addPrd:
            return .get
        }
        
    }

    
}
