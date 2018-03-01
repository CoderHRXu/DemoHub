//
//  FCBaseModel.swift
//  JiKeJiaoShi
//
//  Created by haoran on 2018/1/29.
//  Copyright © 2018年 fclassroom. All rights reserved.
//

import Foundation
import HandyJSON


class FCBaseModel: HandyJSON {
    
    /// 状态码
    var error_code:Int?
    
    /// 错误消息
    var error_msg:String?
    
    required init() {
        
    }
}
