//
//  Repository.swift
//  Rx多线程
//
//  Created by haoran on 2018/4/11.
//  Copyright © 2018年 Xuhaoran. All rights reserved.
//

import ObjectMapper

class Repository: Mappable {
    required init?(map: Map) {
        
    }
    
    var identifier: Int!
    var language: String!
    var url: String!
    var name: String!
    
    
    func mapping(map: Map) {
        identifier <- map["id"]
        language <- map["language"]
        url <- map["url"]
        name <- map["name"]
    }
    
}
