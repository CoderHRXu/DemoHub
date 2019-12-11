//
//  PinAnnotationView.swift
//  NAMapKitDemo
//
//  Created by haoran on 2019/12/10.
//  Copyright © 2019 haoran. All rights reserved.
//

import UIKit

let NAMapViewAnnotationPinWidth: CGFloat = 20.0
let NAMapViewAnnotationPinHeight: CGFloat = 20.0
let NAMapViewAnnotationPinPointX: CGFloat = 20.0
let NAMapViewAnnotationPinPointY: CGFloat = 20.0

class PinAnnotationView: UIButton {

    weak var annotation: PinAnnotation!
    var isAnimate: Bool!
    private weak var mapView: NAMapView!
    let circleView: UIView = {
        let view = UIView.init(frame: CGRect(x: 5, y: 5, width: 10, height: 10))
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.isUserInteractionEnabled = false
        return view
    }()
    
    init(_ annotation: PinAnnotation, _ mapView: NAMapView, _ isAnimate: Bool = false) {
        super.init(frame: CGRect.zero)
        self.mapView = mapView
        self.annotation = annotation
        self.isAnimate = isAnimate
        
        if annotation.pinType == .Room {
            setTitle("      " + annotation.title, for: .normal)
            titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
            sizeToFit()
            addSubview(circleView)
        }
        if annotation.pinType == .Destination {
            addSubview(circleView)
        }
        if annotation.pinType == .User {
            setImage(UIImage(named: "icon_user_position")!, for: .normal)
            sizeToFit()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func updatePosition() {
        
        var ponit = mapView.zoomRelativePoint(annotation.point)
        switch annotation.pinType {
        case .Destination:
            
            ponit.x -= NAMapViewAnnotationPinWidth * 0.5
            ponit.y -= NAMapViewAnnotationPinHeight * 0.5
            frame = CGRect(x: ponit.x, y: ponit.y, width: NAMapViewAnnotationPinWidth, height: NAMapViewAnnotationPinHeight)

        case .Room:
    
            ponit.y -= bounds.size.height * 0.5
            frame = CGRect(x: ponit.x, y: ponit.y, width: bounds.size.width, height: bounds.size.height)

        case .User:
            
            ponit.x -= NAMapViewAnnotationPinWidth * 0.5
            ponit.y -= NAMapViewAnnotationPinHeight * 0.5
            frame = CGRect(x: ponit.x, y: ponit.y, width: NAMapViewAnnotationPinWidth, height: NAMapViewAnnotationPinHeight)
            
        default: break
            
        }
    }
}
