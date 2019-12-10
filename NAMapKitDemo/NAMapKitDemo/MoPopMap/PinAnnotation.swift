//
//  RoomAnnotation.swift
//  NAMapKitDemo
//
//  Created by haoran on 2019/12/10.
//  Copyright © 2019 haoran. All rights reserved.
//

import UIKit

enum PinType {
    case Room
    case Elevator
}


class PinAnnotation: NAAnnotation {
    
    var type: PinType!
    /// title
    var title: String!
    
    override init!(point: CGPoint) {
        super.init(point: point)
        self.type = .Room
    }
    
    override func createView(on mapView: NAMapView!) -> UIView! {
        PinAnnotationView.init(self, mapView)
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
