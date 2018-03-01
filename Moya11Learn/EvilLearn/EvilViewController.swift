//
//  EvilViewController.swift
//  Moya11Learn
//
//  Created by haoran on 2018/2/13.
//  Copyright © 2018年 Fclassroom. All rights reserved.
//

import UIKit
import Evil

class EvilViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        showImagePicker()
    }

    func showImagePicker() {
        
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let pickerVC = UIImagePickerController()
            pickerVC.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            pickerVC.sourceType = .photoLibrary
            pickerVC.allowsEditing = false
            self.present(pickerVC, animated: true, completion: nil)
        }
        
    
    }
    
    func evilAnalyze(image : UIImage) {
        
        let img : Recognizable = image
//        let result = evil?.recognize(img)
//        print(result ?? "")
        
//        let evil = try? Evil(contentsOf: Bundle.main.url(forResource: "ChineseIDCard", withExtension: "mlmodel")!, name: "ChineseIDCard")
        let evil = try? Evil.init(recognizer: .chineseIDCard)
        
        let result = evil?.recognize(image)
        print(result ?? "")
    }

}

extension EvilViewController : UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print(info)
        
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        evilAnalyze(image: img)
        picker.dismiss(animated: true, completion: nil)
    }
}

extension EvilViewController : UINavigationControllerDelegate {
    
}
