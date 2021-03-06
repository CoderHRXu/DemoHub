//
//  PhotoUploadViewController.swift
//  HRSwiftDemo
//
//  Created by haoran on 2018/10/26.
//  Copyright © 2018年 haoran. All rights reserved.
//

import UIKit

class PhotoUploadViewController: HRBaseViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    let viewModel = HomeViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "照片上传"
    }

    
    @IBAction func upload(_ sender: Any) {
        
        let picker = UIImagePickerController.init()
        picker.sourceType = .savedPhotosAlbum
        picker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func upload(image: UIImage)  {
     
        self.viewModel.uploadImage(image: image).done { (dict) in
            print("上传成功\(dict)")
            }.catch { (err) in
                print(err);
        }
    }
}

extension PhotoUploadViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as! UIImage
        imageView.image = image
        upload(image: image)
        self.dismiss(animated: true, completion: nil)
        
    }
}
