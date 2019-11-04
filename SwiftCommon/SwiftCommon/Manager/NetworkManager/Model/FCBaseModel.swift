//
//  FCBaseModel.swift
//  SwiftDemo
//
//  Created by haoran on 2018/1/29.
//  Copyright © 2018年 xuhaoran. All rights reserved.
//

import Foundation
import HandyJSON


class FCBaseModel: HandyJSON {
    
    /// 状态码
    var code:Int?
    
    /// 错误消息
    var message:String?
    
    required init() {
        
    }
}
