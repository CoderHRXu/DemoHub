//
//  HRBaseModel.swift
//  HRSwiftDemo
//
//  Created by haoran on 2018/10/23.
//  Copyright © 2018年 haoran. All rights reserved.
//

import Foundation
import HandyJSON

class HRBaseModel: HandyJSON {
    
    /// 状态码
    var code:Int?
    
    /// 错误消息
    var message:String?
    
    required init() {
        
    }
}
