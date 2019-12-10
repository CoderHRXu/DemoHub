//
//  PinAnnotationBubbleView.swift
//  NAMapKitDemo
//
//  Created by haoran on 2019/12/10.
//  Copyright © 2019 haoran. All rights reserved.
//

import UIKit

class PinAnnotationBubbleView: NibView {

    @IBOutlet weak var titleLabel: UILabel!
    var point: CGPoint!
    var position: CGPoint!
    
    
    weak var annotation: PinAnnotation! {
        didSet {
            self.position = self.annotation.point
            self.position = self.annotation.point
            self.titleLabel.text = self.annotation.title
            self.updatePostition()
        }
    }
    weak var mapView: NAMapView! {
        didSet {
            self.isHidden = true
        }
    }
   
    init(frame: CGRect, onMapView mapView: NAMapView) {
        super.init(frame: CGRect.zero)
        self.mapView = mapView
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updatePostition() {
        
        if position != nil {
            let point = mapView.zoomRelativePoint(position)
            let xPostion = point.x - (frame.size.width / 2.0)
            let yPostion = point.y - (frame.size.height) - 26
            frame = CGRect(x: floor(xPostion), y: yPostion, width: frame.size.width, height: frame.size.height)
//            if let superV = superview {
//                superV.frame = CGRect(x: floor(xPostion), y: floor(yPostion), width: frame.size.width, height: frame.size.height)
//            } else {
//                frame = CGRect(x: floor(xPostion), y: yPostion, width: frame.size.width, height: frame.size.height)
//            }
        }
        
    }
    
}
