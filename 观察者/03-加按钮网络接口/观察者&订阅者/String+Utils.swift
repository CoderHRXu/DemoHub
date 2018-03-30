//
//  String+Utils.swift
//  观察者&订阅者
//
//  Created by haoran on 2018/3/23.
//  Copyright © 2018年 Xuhaoran. All rights reserved.
//

import Foundation

extension String {

    
    var URLEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
    
    /// 验证手机号
    ///
    /// - Returns: 是/否
    func isValidPhoneNumber() -> Bool {
        
        if self.count != 11 {
            return false;
        }
        /**
         * 手机号码:
         * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
         * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
         * 联通号段: 130,131,132,145,152,155,156,170,171,176,185,186
         * 电信号段: 133,134,153,170,173,177,180,181,189
         */
        let MOBILE = "^1(3[0-9]|4[57]|5[0-35-9]|7[013678]|8[0-9])\\d{8}$"
        /**
         * 中国移动：China Mobile
         * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
         */
        let CM = "^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$"
        /**
         * 中国联通：China Unicom
         * 130,131,132,145,152,155,156,170,171,176,185,186
         */
        let CU = "^1(3[0-2]|4[5]|5[256]|7[016]|8[56])\\d{8}$"
        /**
         * 中国电信：China Telecom
         * 133,134,153,170,173,177,180,181,189
         */
        let CT = "^1(3[34]|53|7[037]|8[019])\\d{8}$"
  
        let regextestMobile = NSPredicate(format: "SELF MATCHES %@", MOBILE)
        let regextestCM     = NSPredicate(format: "SELF MATCHES %@", CM)
        let regextestCU     = NSPredicate(format: "SELF MATCHES %@", CU)
        let regextestCT     = NSPredicate(format: "SELF MATCHES %@", CT)
        
        if regextestMobile.evaluate(with: self) || regextestCM.evaluate(with: self) || regextestCU.evaluate(with: self) || regextestCT.evaluate(with: self) {
            return true
        }else{
            return false
        }
        
    }
    
    
    /// 验证邮箱
    ///
    /// - Returns: 是/否
    func isValidateEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    
}
