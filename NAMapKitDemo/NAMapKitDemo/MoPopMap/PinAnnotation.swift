//
//  RoomAnnotation.swift
//  NAMapKitDemo
//
//  Created by haoran on 2019/12/10.
//  Copyright © 2019 haoran. All rights reserved.
//

import UIKit

enum MoPopPinType {
    case Room
    case Destination
    case User
}

class PinAnnotation: NAAnnotation {
    
    var pinType: MoPopPinType!
    /// title
    var title: String!
    
    init(point: CGPoint, type: MoPopPinType) {
        super.init(point: point)
        self.pinType = type
    }
    
    override func createView(on mapView: NAMapView!) -> UIView! {
        PinAnnotationView(self, mapView)
    }
    
    override func add(to mapView: NAMapView!, animated animate: Bool) {
        super.add(to: mapView, animated: animate)
        mapView.addSubview(view)
        if animate {
            view.transform = CGAffineTransform.identity.scaledBy(x: 0.0, y: 0.0)
            UIView.animate(withDuration: 0.168, animations: {
                self.view.transform = CGAffineTransform.identity
            })
        }
    }
    
    override func updatePosition() {
        if let annoView = self.view as? PinAnnotationView {
            annoView.updatePosition()
        }
    }
}
