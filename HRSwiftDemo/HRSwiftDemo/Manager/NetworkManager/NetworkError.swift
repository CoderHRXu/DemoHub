//
//  NetworkError.swift
//  HRSwiftDemo
//
//  Created by haoran on 2018/10/23.
//  Copyright © 2018年 haoran. All rights reserved.
//

import Foundation

enum NetworkError: Swift.Error {
    case ParseJSONError
    case ServerError(code: Int, msg: String)
    case OtherError
}
