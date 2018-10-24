//
//  ObservableType+ParseError.swift
//  HRSwiftDemo
//
//  Created by haoran on 2018/10/23.
//  Copyright © 2018年 haoran. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
import RxSwift

enum NetworkStatusCodeType : Int {
    /// 成功
    case Success                    = 0
    /// 账号或密码错误
    case LoginNameOrPasswordWrong   = 20101
    ///  账号或密码错误 v2.0
    case LoginWrong                 = 20003
    /// token失效
    case TokenInvalid               = 20001
    /// token过期
    case TokenOverdue               = 20002
    /// loginByToken时返回，不处理
    case TokenInvalidOrExpire       = 20103
    /// 账号已被禁用
    case AccountDisabled            = 4000
    /// 帐号被禁用
    case AccountDisabled2           = 20004
    /// 账号无权限
    case RoleDisabled               = 4001
    /// 旧密码错误
    case OldPasswordWrong           = 20117
    /// 旧密码错误
    case OldPasswordWrong2          = 20005
    /// 手机号未被登记
    case PhoneNumUnregistered       = 20011
    /// 手机号已登记
    case PhoneNumRegistered         = 20022
    /// 缺少参数
    case LackParameters             = 10006
}



extension ObservableType where E : Response {
    
    public func parseError() -> Observable<Response> {
        
        return flatMap({ (response) -> Observable<Response> in
            
            guard let mapStr = try? response.mapString(), let bean = HRBaseModel.deserialize(from: mapStr) else {
                
                throw NetworkError.ParseJSONError
            }
            
            switch bean.status {
                
            case NetworkStatusCodeType.Success.rawValue:
                return Observable<Response>.just(response)
            
            /// token失效/过期
            case NetworkStatusCodeType.TokenInvalid.rawValue, NetworkStatusCodeType.TokenOverdue.rawValue:
                
                //TODO:清空token
                NotificationCenter.default.post(name: .UserStatusHasChanged, object: nil)
                fallthrough
                
            default:
                
                throw NetworkError.ServerError(code: bean.status ?? NSNotFound, msg: bean.message ?? "")
            }
        })
    }
}
