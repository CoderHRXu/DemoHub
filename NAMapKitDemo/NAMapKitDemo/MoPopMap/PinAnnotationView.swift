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
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    init(_ annotation: PinAnnotation, _ mapView: NAMapView, _ isAnimate: Bool = false) {
        super.init(frame: CGRect.zero)
        self.mapView = mapView
        self.annotation = annotation
        self.isAnimate = isAnimate
        self.backgroundColor = UIColor.blue
        self.addSubview(circleView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func updatePosition() {
        let ponit = mapView.zoomRelativePoint(annotation.point)
        frame = CGRect(x: ponit.x, y: ponit.y, width: NAMapViewAnnotationPinWidth, height: NAMapViewAnnotationPinHeight)
    }
}
