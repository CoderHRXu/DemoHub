//
//  Observable+JSONParser.swift
//  SwiftDemo
//
//  Created by haoran on 2018/1/29.
//  Copyright © 2018年 xuhaoran. All rights reserved.
//

import Foundation

import RxSwift
import Moya
import HandyJSON

enum NetworkError: Swift.Error {
    case ParseJSONError
    case ServerError(code: Int, msg: String)
    case OtherError
}

extension ObservableType where E : Response {
    
    
    /// Json to Model
    ///
    /// - Parameters:
    ///   - type: Model类型
    ///   - designatedPath: 从json的那个节点开始解析 (默认从data)
    /// - Returns: model
    public func mapModelObject< T: HandyJSON>(_ type:T.Type, designatedPath: String = "data") -> Observable<T> {

        
        return flatMap{ response -> Observable<T> in
            guard let mapStr = try? response.mapString(), let obj = T.deserialize(from: mapStr, designatedPath: designatedPath) else {
                throw NetworkError.ParseJSONError
            }
            return Observable<T>.just(obj)
        }
        
    }
    
    
    /// json -> modelArray
    public func mapModelArray< T: HandyJSON>(modelType:T.Type, designatedPath: String) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            print("start : json -> modelArray")
            guard let mapStr = try? response.mapString() , let objArray = [T].deserialize(from: mapStr, designatedPath: designatedPath) as? [T] else {
                
                throw NetworkError.ParseJSONError
            }
            return Observable<[T]>.just(objArray)
        }
        
    }
    
    /// json -> dict
    public func mapDictionary(designatedPath : String = "data") -> Observable<[String : Any]> {
        return flatMap { response -> Observable<[String : Any]> in
            print("start : json -> dict ")
            guard let mapStr = try? response.mapString(), let dict = try  JSONSerialization.jsonObject(with: mapStr.data(using: .utf8)!, options: [])  as? [String : Any] else {
                
                throw NetworkError.ParseJSONError
            }
            
            return Observable<[String : Any]>.just(dict)
        }
        
    }
}
