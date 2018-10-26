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

    /// 增加车
    case addPrd(carBandName: String)
    
    /// 文件上传
    case upload(image: UIImage)

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
        case .upload:
            return "upload"
        }
    }
    
    
    var task: Task{
        
        switch self {
            
        case .post(let name):
            return .requestParameters(parameters: ["name": name ], encoding: JSONEncoding.default)

        case .push(let title, let content):
            return .requestParameters(parameters: ["title" : title, "content" : content], encoding: URLEncoding.default)
            
        case .getPrdList:
            return .requestPlain
            
        case .addPrd(let carBandName):
            return .requestParameters(parameters: ["name" : carBandName], encoding: URLEncoding.default)
            
        case .upload(let image):
            
            let data = image.jpegData(compressionQuality: 1)
            let formData = MultipartFormData(provider: .data(data!), name: "image", fileName: "ycy", mimeType: "image/jpg")
            
            return .uploadCompositeMultipart([formData], urlParameters: ["image" : "ycy"])

        }
    }
    
    var method: Moya.Method {
        
        switch self {
            
        case .post:
            fallthrough
        case .push:
            return .post
        case .getPrdList:
            return .get
        case .addPrd:
            return .post
        case .upload:
            return .post

        }
        
    }

    
    
}
