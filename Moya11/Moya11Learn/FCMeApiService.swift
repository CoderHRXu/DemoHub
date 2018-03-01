//
//  FCMeApiService.swift
//  Moya11Learn
//
//  Created by haoran on 2018/2/13.
//  Copyright © 2018年 Fclassroom. All rights reserved.
//

import Foundation
import Moya

enum FCMeApiService {
    
    /// 请求出卷数量接口
    case taskReadExamCount
    
    /// 请求试题蓝数量接口
    case questionCartWithQuerySimple
    
    /// 请求星星数量接口
    case taskTurnExamCount
    
    /// 更新昵称
    case updateNickName(nickName: String);
}

extension FCMeApiService : TargetType {
    
    var baseURL: URL {
        switch self {
        case .taskReadExamCount:
            return URL.init(string: "https://msgxqtk-api.fclassroom.cn/")!
        default:
            return URL.init(string: "https://msgxqtk-api.fclassroom.cn/")!
        }
    }
    
    var path: String {
        
        switch self {
        case .taskReadExamCount:
            return "getReadAndTurnExamCount.json"
            
        case .questionCartWithQuerySimple:
            return "v2/questioncart/querysimple.json"
            
        case .taskTurnExamCount:
            return "exam/getTurnCount.json"
            
        case .updateNickName:
            return "updateAccountBase.json"
        }
    }

    var task: Task {
        
        switch self {
        case .questionCartWithQuerySimple , .taskReadExamCount , .taskTurnExamCount:
            
            return .requestParameters(parameters: mergePublicParameter(para: ["accountId":1547733]), encoding: URLEncoding.default)
            
        case .updateNickName(let nickName):
            
            let para = ["nick": nickName] as [String : Any]
            return .requestParameters(parameters:mergePublicParameter(para:para), encoding: URLEncoding.default )
        }
        
        
        
    }
    
    
}
