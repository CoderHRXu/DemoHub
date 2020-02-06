//
//  Bundle+Extension.swift
//  MultipleLan
//
//  Created by haoran on 2020/1/10.
//  Copyright © 2020 haoran. All rights reserved.
//

import Foundation
import ObjectiveC

private var _bundle = 0

class BundleEx: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        let bundle = objc_getAssociatedObject(self, &_bundle) as? Bundle
        return bundle != nil ? bundle!.localizedString(forKey: key, value: value, table: tableName) : super.localizedString(forKey: key, value: value, table: tableName)
    }
}

extension Bundle {
    
    class func setLanguage(_ language: String?) {
        do {
            object_setClass(Bundle.main, BundleEx.self)
        }

        objc_setAssociatedObject(Bundle.main, &_bundle, language != nil ? Bundle(path: Bundle.main.path(forResource: language, ofType: "lproj") ?? "") : nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
