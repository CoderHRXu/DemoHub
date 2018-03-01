//
//  ViewController.swift
//  YGCVideoToolboxTest
//
//  Created by haoran on 2018/2/22.
//  Copyright © 2018年 Fclassroom. All rights reserved.
//

import UIKit
import AVKit
import YGCVideoToolbox
import MobileCoreServices

class ViewController: UIViewController {

    lazy var videoPickerVC : UIImagePickerController? = {
        
        let vc                  = UIImagePickerController.init()
        vc.delegate             = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        vc.sourceType           = .camera
        vc.cameraDevice         = .rear
        vc.mediaTypes           = [(kUTTypeMovie as String)]
        vc.videoQuality         = .typeMedium
        vc.cameraCaptureMode    = .video
        vc.allowsEditing        = true
        return vc
        }()
    
    var composition:AVMutableComposition!
    var player:AVPlayer!
    var item:AVPlayerItem!
    var playerLayer:AVPlayerLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnClick(_ sender: UIButton) {
        present(videoPickerVC!, animated: true, completion: nil)
    }
    
    func videoTest(url : URL) {
        
        let videoAsset = AVURLAsset(url:url)
        composition = try? slowMotion(videoAsset: videoAsset, slowTimeRange: YGCTimeRange.secondsRange(1, 4), slowMotionRate: 5)
        item = AVPlayerItem.init(asset: composition)
        player = AVPlayer.init(playerItem: item)
        playerLayer = AVPlayerLayer.init(player: player)
        playerLayer.frame = view.bounds
        view.layer.addSublayer(playerLayer)
        player.seek(to: kCMTimeZero)
        player.play()
//        composition = try! slowMotion(videoAsset: videoAsset, slowTimeRange: YGCTimeRange.secondsRange(1, 3), slowMotionRate: 8)
    }

}


extension ViewController : UIImagePickerControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print(info)
        
        let url = info[UIImagePickerControllerMediaURL] as! URL
    
        picker.dismiss(animated: true) {
            self.videoTest(url: url)
        }
        
      
    }
}

extension ViewController : UINavigationControllerDelegate {
    
}

