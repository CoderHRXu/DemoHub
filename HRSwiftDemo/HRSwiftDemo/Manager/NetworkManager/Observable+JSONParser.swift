//
//  Observable+JSONParser.swift
//  HRSwiftDemo
//
//  Created by haoran on 2018/10/23.
//  Copyright © 2018年 haoran. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import HandyJSON

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
    ///
    /// - Parameters:
    ///   - modelType: model类型
    ///   - designatedPath: 从json的那个节点开始解析
    /// - Returns: modelArray
    public func mapModelArray< T: HandyJSON>(modelType:T.Type, designatedPath: String = "data") -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
         
            guard let mapStr = try? response.mapString() , let objArray = [T].deserialize(from: mapStr, designatedPath: designatedPath) as? [T] else {
                
                throw NetworkError.ParseJSONError
            }
            return Observable<[T]>.just(objArray)
        }
        
    }
    
    
    /// json -> dict
    ///
    /// - Parameter designatedPath: json解析节点默认data
    /// - Returns: dict
    public func mapModelDictionary(designatedPath : String = "data") -> Observable<[String : Any]> {
        return flatMap { response -> Observable<[String : Any]> in
            print("start : json -> dict ")
            guard let mapStr = try? response.mapString(), let dict = try  JSONSerialization.jsonObject(with: mapStr.data(using: .utf8)!, options: [])  as? [String : Any] else {
                
                throw NetworkError.ParseJSONError
            }
            
            return Observable<[String : Any]>.just(dict)
        }
        
    }
    
    
    /// json -> jsonStrArray
    ///
    /// - Parameter designatedPath: json解析节点默认data
    /// - Returns: jsonStrArray
    public func mapStringArray(designatedPath:String = "data") -> Observable<[String]>{
        return flatMap({ (response) -> Observable<[String]> in
            guard let mapStr = try? response.mapString(), let obj = try JSONSerialization.jsonObject(with: mapStr.data(using: .utf8)!, options: []) as? [String: Any] else {
                throw NetworkError.ParseJSONError
            }
            
            return Observable.just(obj[designatedPath] as? [String] ?? [String]())
        })
    }
}
