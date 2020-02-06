//
//  NextViewController.swift
//  MultipleLan
//
//  Created by haoran on 2020/1/10.
//  Copyright © 2020 haoran. All rights reserved.
//
        
import UIKit

class NextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnclick(_ btn: UIButton) {
        
        var language = "en"
        if let lan = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String] {
            
            language = lan.first == "en" ? "es" : "en"
        }
        LanguageManager.shared.setLanguage(languageName: language)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
        //        let delagate = UIApplication.shared.delegate as! AppDelegate
        //        delagate.perform(controller: vc)
        self.dismiss(animated: true) {
             UIApplication.shared.keyWindow?.rootViewController = vc
        }
    }
}
