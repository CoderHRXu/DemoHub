//
//  LanguageManager.swift
//  MultipleLan
//
//  Created by haoran on 2020/1/10.
//  Copyright © 2020 haoran. All rights reserved.
//

import UIKit

class LanguageManager: NSObject {

    static let shared = LanguageManager()
    
    func setLanguage(languageName: String) {
        Bundle.setLanguage(languageName)
        UserDefaults.standard.set([languageName], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
    
    func localizedString(key: String, value: String = "", table: String?) -> String? {
        let lan = UserDefaults.standard.value(forKey: "AppleLanguages") as! [String]
        let path = Bundle.main.path(forResource: lan.first!, ofType: "lproj")
        return Bundle.init(path: path!)?.localizedString(forKey: key, value: "", table: table)
    }
}
