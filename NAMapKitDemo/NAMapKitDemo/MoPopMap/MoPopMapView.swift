//
//  MoPopMapView.swift
//  NAMapKitDemo
//
//  Created by haoran on 2019/12/10.
//  Copyright © 2019 haoran. All rights reserved.
//

import UIKit

let BubbleAnimationDuration: Double = 0.1

class MoPopMapView: NAMapView {

    var annotationArray = [NAAnnotation]()
    var bubbleView: PinAnnotationBubbleView!
    
    override func setupMap() {
        super.setupMap()
        bubbleView = PinAnnotationBubbleView.init(frame: CGRect(x: 0, y: 0, width: 120, height: 40), onMapView: self)
        addSubview(bubbleView)
    }
    
    override func add(_ annotation: NAAnnotation!, animated animate: Bool) {
        super.add(annotation, animated: true)
        annotationArray.append(annotation)
        if let view = annotation.view as? PinAnnotationView {
            view.addTarget(self, action: #selector(showBubble(btn:)), for: .touchUpInside)
        }
    }
    
    @objc func showBubble(btn: UIButton) {
        
        let annotationView = btn as! PinAnnotationView
        showBubbleForAnnotation(annotation: annotationView.annotation)
    }
    
    func showBubbleForAnnotation(annotation: PinAnnotation, animate: Bool = true) {
        
        hideBubble()
        bubbleView.annotation = annotation
        bubbleView.position = annotation.point
        bubbleView.point = annotation.point
        center(on: annotation.point, animated: true)
       
        let duration = animate ? BubbleAnimationDuration : 0
        bubbleView.transform = CGAffineTransform.identity.scaledBy(x: 0.4, y: 0.4)
        bubbleView.isHidden = false
        UIView.animate(withDuration: duration) {
            self.bubbleView.transform = CGAffineTransform.identity
        }
    }
    
    func hideBubble() {
        bubbleView.isHidden = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.isDragging == false {
            hideBubble()
        }
        super .touchesEnded(touches, with: event)
    }
    
    override func updatePositions() {
        bubbleView.updatePostition()
        super.updatePositions()
    }
}
