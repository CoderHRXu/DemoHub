//
//  ValidationResult.swift
//  观察者&订阅者
//
//  Created by haoran on 2018/3/23.
//  Copyright © 2018年 Xuhaoran. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


enum ValidationResult {
    /// 验证成功信息
    case ok(message: String)
    /// 输入为空
    case empty
    /// 正在验证..
    case validating
    /// 验证失败原因
    case failed(message: String)
}

// 然后绑定错误到label，为了让ValidationResult能绑定到label，需要给出不同结果的文字颜色和文字信息，这时需要给ValidationResult扩展一下。
extension ValidationResult: CustomStringConvertible {
    var description: String {
        
        switch self {
        case let .ok(message):
            return message
            
        case .empty:
            return ""
            
        case .validating:
            return "validating"
            
        case let .failed(message):
            return message
        }
    }
    
}


struct ValidationColor {
    static let okColor = UIColor(red: 138.0 / 255.0, green: 221.0 / 255.0, blue: 109.0 / 255.0, alpha: 1.0)
    static let errorColor = UIColor.red
}


extension ValidationResult {
    var textColor: UIColor {
        switch self {
        case .ok:
            return ValidationColor.okColor
            
        case .empty:
            fallthrough
        case .validating:
            return UIColor.black
            
        case .failed:
            return ValidationColor.errorColor
        }
    }
    
}


extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}
