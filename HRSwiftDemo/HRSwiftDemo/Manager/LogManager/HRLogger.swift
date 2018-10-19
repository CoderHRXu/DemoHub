//
//  FCLogger.swift
//  SwiftDemo
//
//  Created by haoran on 2018/1/28.
//  Copyright © 2018年 xuhaoran. All rights reserved.
//

import Foundation

class HRLogger: NSObject {

    
    // Print information
    class func info<T>(_ msg:T) {
        
        let msg = "💚 \(msg)"
        
        printLog(msg: msg)
    }
    
    // Print error log
    class  func error<T>(_ msg:T) {
        let msg = "‼️ \(msg)"
        
        printLog(msg: msg)
    }
    
    // Print warning info
    class func warning<T>(_ msg:T) {
        let msg = "💛 \(msg)"
        
        printLog(msg: msg)
    }
    
    
    fileprivate class func printLog<T>( msg:T) {
        
        
        
        #if !(RELEASE)
            
            let now         = Date()
            
            let df          = DateFormatter()
            df.dateFormat   = "yyyy-MM-dd HH:mm:ss"
            
            print("\(df.string(from: now)): \(msg)")
        #endif
    }

    
    
}
